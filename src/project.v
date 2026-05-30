`default_nettype none

module tt_um_nlfsr_pqc (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    reg [7:0] lfsr;
    wire feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ (lfsr[1] & lfsr[0]);

    // Internal Clock Buffer to stop "Outside Die Area" errors
    wire internal_clk = clk;

    always @(posedge internal_clk) begin
        if (!rst_n) begin
            lfsr <= 8'h01; 
        end else if (ena) begin
            if (uio_in[0])
                lfsr <= (ui_in == 8'h00) ? 8'h01 : ui_in;
            else if (uio_in[1])
                lfsr <= {lfsr[6:0], feedback};
        end
    end

    assign uo_out = lfsr;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
