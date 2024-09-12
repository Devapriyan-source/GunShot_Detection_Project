module bandpass_filter_6mic (
    input clk,
    input signed [15:0] mic_signals[0:5],  // 6 microphone signals input
    output reg signed [15:0] filtered_signals[0:5]  // 6 filtered outputs
);
    reg signed [15:0] delay_line[0:5][0:127];  // Delay lines for each microphone
    integer i, j;
    wire signed [15:0] coeffs[0:127];  // Load MATLAB-generated coefficients here

    initial begin
        // Assign coefficients here; use the coefficients generated in MATLAB
        coeffs[0] = 16'h0010;
        // Repeat for all 128 coefficients
    end

    always @(posedge clk) begin
        // Process each microphone signal
        for (j = 0; j < 6; j = j + 1) begin
            // Shift delay line for the current microphone
            delay_line[j][0] <= mic_signals[j];
            for (i = 1; i < 128; i = i + 1) begin
                delay_line[j][i] <= delay_line[j][i - 1];
            end

            // Apply FIR filter to the current microphone signal
            filtered_signals[j] <= 0;
            for (i = 0; i < 128; i = i + 1) begin
                filtered_signals[j] <= filtered_signals[j] + (delay_line[j][i] * coeffs[i]);
            end
        end
    end
endmodule
