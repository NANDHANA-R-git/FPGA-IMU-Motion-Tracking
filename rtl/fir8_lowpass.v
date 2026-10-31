module fir8_lowpass (
    input  wire       clk,
    input  wire       rst,
    input  wire       sample_valid,
    input  wire [7:0] sample_in,
    output reg  [7:0] filtered_out,
    output reg        filtered_valid
);

    reg [7:0] d0, d1, d2, d3, d4, d5, d6;

    wire [15:0] x0 = {8'd0, sample_in};
    wire [15:0] x1 = {8'd0, d0};
    wire [15:0] x2 = {8'd0, d1};
    wire [15:0] x3 = {8'd0, d2};
    wire [15:0] x4 = {8'd0, d3};
    wire [15:0] x5 = {8'd0, d4};
    wire [15:0] x6 = {8'd0, d5};
    wire [15:0] x7 = {8'd0, d6};

    wire [15:0] acc =
          (x0 * 16'd4)
        + (x1 * 16'd12)
        + (x2 * 16'd20)
        + (x3 * 16'd28)
        + (x4 * 16'd28)
        + (x5 * 16'd20)
        + (x6 * 16'd12)
        + (x7 * 16'd4);

    always @(posedge clk) begin
        if (rst) begin
            d0 <= 0;
            d1 <= 0;
            d2 <= 0;
            d3 <= 0;
            d4 <= 0;
            d5 <= 0;
            d6 <= 0;

            filtered_out   <= 0;
            filtered_valid <= 0;
        end else begin
            filtered_valid <= sample_valid;

            if (sample_valid) begin
                filtered_out <= acc[14:7];

                d6 <= d5;
                d5 <= d4;
                d4 <= d3;
                d3 <= d2;
                d2 <= d1;
                d1 <= d0;
                d0 <= sample_in;
            end
        end
    end

endmodule


module imu_fir_demo_top #(
    parameter integer SAMPLE_DIV = 1250000
) (
    input  wire       clk,
    input  wire       rst,
    output wire [3:0] led
);

    reg [20:0] sample_count;
    reg [6:0] phase;
    reg [7:0] lfsr;
    reg [7:0] fake_imu_sample;
    reg        sample_valid;

    wire [8:0] generated_value =
          9'd128
        + {3'b000, phase[5:0]}
        + {4'b0000, lfsr[4:0]}
        - 9'd16;

    wire [7:0] filtered_sample;
    wire       filtered_valid;

    always @(posedge clk) begin
        if (rst) begin
            sample_count   <= 0;
            phase          <= 0;
            lfsr           <= 8'hA5;
            fake_imu_sample <= 8'd128;
            sample_valid   <= 0;
        end else begin
            sample_valid <= 0;

            if (sample_count == SAMPLE_DIV - 1) begin
                sample_count    <= 0;
                sample_valid    <= 1;
                phase           <= phase + 1'b1;
                lfsr            <= {
                    lfsr[6:0],
                    lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]
                };
                fake_imu_sample <= generated_value[7:0];
            end else begin
                sample_count <= sample_count + 1'b1;
            end
        end
    end

    fir8_lowpass FIR (
        .clk            (clk),
        .rst            (rst),
        .sample_valid   (sample_valid),
        .sample_in      (fake_imu_sample),
        .filtered_out   (filtered_sample),
        .filtered_valid (filtered_valid)
    );

    assign led = filtered_sample[7:4];

endmodule
