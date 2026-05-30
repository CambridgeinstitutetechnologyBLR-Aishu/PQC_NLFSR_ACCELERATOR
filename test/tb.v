`default_nettype none
`timescale 1ns / 1ps

module tb ();
  // ... (keep the top of the file the same)

  // Replace the instantiation around line 31 with this:
  tt_um_nlfsr_pqc user_project (
`ifdef GL_TEST
      .VPWR(1'b1),
      .VGND(1'b0),
`endif
      .ui_in  (ui_in),    
      .uo_out (uo_out),   
      .uio_in (uio_in),   
      .uio_out(uio_out),  
      .uio_oe (uio_oe),   
      .ena    (ena),      
      .clk    (clk),      
      .rst_n  (rst_n)     
  );

endmodule
