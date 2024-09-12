module doa_estimation_6mic (
    input clk,
    input [15:0] tdoas[0:14],  // 15 TDOA values
    output reg [31:0] doa_angle
);
    always @(posedge clk) begin
        // Implement geometric equations to convert TDOAs to angle
        // Here is a simplified equation for demonstration purposes; you must provide the correct calculation based on your setup
        doa_angle <= (tdoas[0] - tdoas[1]);  // Example calculation
    end
endmodule
