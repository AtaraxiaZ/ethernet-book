module afifo_w8_d4k (
    input  logic        rst,
    input  logic        wr_clk,
    input  logic        rd_clk,
    input  logic [7:0]  din,
    input  logic        wr_en,
    input  logic        rd_en,
    output logic [7:0]  dout,
    output logic        full,
    output logic        empty,
    output logic [11:0] rd_data_count,
    output logic [11:0] wr_data_count
);

xpm_fifo_async #(
    .FIFO_MEMORY_TYPE("auto"),
    .FIFO_WRITE_DEPTH(4096),
    .WRITE_DATA_WIDTH(8),
    .READ_DATA_WIDTH(8),
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
    .empty(empty),
    .rd_data_count(rd_data_count),
    .wr_data_count(wr_data_count)
);

endmodule

