// Innovation: Dual-path Non-Linear Feedback
    // Path A: Standard PQC NLFSR
    // Path B: Chaotic feedback using XOR-AND logic
    wire feedback_a = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ (lfsr[1] & lfsr[0]);
    wire feedback_b = lfsr[7] ^ (lfsr[6] & lfsr[5]) ^ lfsr[3] ^ lfsr[2];
    
    // Switch between them using uio_in[2]
    wire chosen_feedback = uio_in[2] ? feedback_b : feedback_a;

    always @(posedge clk) begin
        if (!rst_n) begin
            lfsr <= 8'h01; 
        end else if (ena) begin
            if (uio_in[0]) // Load
                lfsr <= (ui_in == 8'h00) ? 8'h01 : ui_in;
            else if (uio_in[1]) // Run
                lfsr <= {lfsr[6:0], chosen_feedback};
        end
    end
