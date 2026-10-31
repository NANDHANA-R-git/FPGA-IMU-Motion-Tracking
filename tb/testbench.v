`timescale 1ns/1ps

module imu_fir_demo_tb;

    reg clk;
    reg rst;

    wire [3:0] led;

    imu_fir_demo_top #(
        .SAMPLE_DIV(10)
    ) dut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1'b1;

        repeat (5) @(negedge clk);

        rst = 1'b0;

        repeat (1800) @(posedge clk);

        #20;
        $finish;
    end

    always @(negedge clk) begin
        if (!rst && dut.filtered_valid) begin
            $display(
                "TIME=%0t RAW_IMU=%0d FILTERED=%0d LED=%b",
                $time,
                dut.fake_imu_sample,
                dut.filtered_sample,
                led
            );
        end
    end

endmodule