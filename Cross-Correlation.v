module cross_correlation_6mic (
    input clk,
    input signed [15:0] mic_signals[0:5],  // 6 microphone signals input
    output reg signed [31:0] correlations[0:14]  // 15 unique cross-correlations
);
    reg signed [15:0] delay_line[0:5][0:127];  // Delay lines for each microphone
    integer i, j, k, pair_index;

    always @(posedge clk) begin
        // Shift delay lines for each microphone
        for (j = 0; j < 6; j = j + 1) begin
            delay_line[j][0] <= mic_signals[j];
            for (i = 1; i < 128; i = i + 1) begin
                delay_line[j][i] <= delay_line[j][i - 1];
            end
        end

        // Calculate cross-correlations for each microphone pair
        pair_index = 0;
        for (j = 0; j < 6; j = j + 1) begin
            for (k = j + 1; k < 6; k = k + 1) begin
                correlations[pair_index] <= 0;
                for (i = 0; i < 128; i = i + 1) begin
                    correlations[pair_index] <= correlations[pair_index] + (delay_line[j][i] * delay_line[k][i]);
                end
                pair_index = pair_index + 1;
            end
        end
    end
endmodule