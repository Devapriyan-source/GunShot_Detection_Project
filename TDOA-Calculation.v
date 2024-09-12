module tdoa_calculation_6mic (
    input clk,
    input signed [31:0] correlations[0:14],  // 15 cross-correlations
    output reg [15:0] tdoas[0:14]  // 15 TDOA values
);
    reg signed [31:0] max_correlation[0:14];
    reg [15:0] max_index[0:14];
    integer i, j;

    always @(posedge clk) begin
        for (j = 0; j < 15; j = j + 1) begin
            max_correlation[j] <= correlations[j];
            max_index[j] <= 0;
            for (i = 0; i < 128; i = i + 1) begin
                if (correlations[j] > max_correlation[j]) begin
                    max_correlation[j] <= correlations[j];
                    max_index[j] <= i;
                end
            end
            tdoas[j] <= max_index[j];
        end
    end
endmodule
