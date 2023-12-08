module afifo_w16_d32 (
    input  logic        rst,
    input  logic        wr_clk,
    input  logic        rd_clk,
    input  logic [15:0] din,
    input  logic        wr_en,
    input  logic        rd_en,
    output logic [15:0] dout,
    output logic        full,
    output logic        empty
);

xpm_fifo_async #(
    .FIFO_MEMORY_TYPE("auto"),
    .FIFO_WRITE_DEPTH(32),
    .WRITE_DATA_WIDTH(16),
    .READ_DATA_WIDTH(16),
    .READ_MODE("std"),
    .ECC_MODE("no_ecc")
) afifo (
    .rst(rst),
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .din(din),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .dout(dout),
    .full(full),
    .empty(empty)
);

endmodule

