`timescale 1ns / 1ps
module cam_w48_d64_tb;
// Inputs
reg clk;
reg rstn;
reg cam_search;
reg cam_wr_req;
wire [5:0] cam_wr_addr;
reg [47:0] cam_content;
reg aging_req;
reg init_req;
reg	[5:0]	cam_refresh_addr;
reg			cam_refresh_req;

// Outputs
wire cam_wr_ack;
wire cam_matched;
wire cam_mismatched;
wire [5:0] cam_match_addr;
wire cam_empty;
wire aging_ack;
wire init_ack;

always #5 clk=~clk;
cam_w48_d64  #(10'd3)  u_cam_w48_d64 (
    .clk(clk), 
    .rstn(rstn), 
    .init_req(init_req),
    .init_ack(init_ack),
    .cam_search(cam_search), 
    .cam_wr_req(cam_wr_req), 
    .cam_wr_addr(cam_wr_addr),
    .cam_wr_ack(cam_wr_ack), 
    .cam_refresh_req(cam_refresh_req),
    .cam_refresh_ack(cam_refresh_ack),
    .cam_refresh_addr(cam_refresh_addr),
    .cam_content(cam_content), 
    .cam_matched(cam_matched), 
    .cam_mismatched(cam_mismatched), 
    .cam_match_addr(cam_match_addr), 
    .cam_empty(cam_empty), 
    .aging_req(aging_req), 
    .aging_ack(aging_ack)
);

integer i;
reg [47:0]  mac_address;
initial begin
    // Initialize Inputs
	clk = 0;
	rstn = 0;
	cam_search = 0;
	cam_wr_req = 0;
	cam_content = 0;
	cam_refresh_addr=0;
	cam_refresh_req=0;

	aging_req = 0;
	init_req=0;
	i=0;
    // Wait 100 ns for global reset to finish.
    #100;
	rstn=1;
    // Add stimulus here
    #1000;
	init_req=1;
    while(!init_ack) repeat(1)@(posedge clk);
	init_req=0;
    for(i=1;i<=64;i=i+1) begin
		mac_address=i;
		add_entry(i);
        end
    #100;
    search(48'h10);
    search(48'h20);
    search(48'hf0f1f2f3f4f5);
	aging_req=1;
    while(!aging_ack) repeat(1)@(posedge clk);
	aging_req=0;
    #100;
	aging_req=1;
    while(!aging_ack) repeat(1)@(posedge clk);
	aging_req=0;
    #100;
	aging_req=1;
    while(!aging_ack) repeat(1)@(posedge clk);
	aging_req=0;
    #100;
    refresh(48'h10);
    refresh(48'h1);
	aging_req=1;
    while(!aging_ack) repeat(1)@(posedge clk);
	aging_req=0;
    #100;
    end
task add_entry;
input   [47:0]  mac_addr;
begin
    repeat(1)@(posedge clk);
	cam_wr_req=1;
	cam_content=mac_addr;
    while(!cam_wr_ack) repeat(1)@(posedge clk);
	cam_wr_req=0;
    $display ("add entry ok");
    end
endtask
task search;
input   [47:0]  mac_addr;
begin
	repeat(1)@(posedge clk);
	cam_search = 1;
	cam_content = mac_addr;
    repeat(1)@(posedge clk);
	cam_search=0;
    end
endtask
task aging;
begin
    repeat(1)@(posedge clk);
	aging_req=1;
    while(!aging_ack) repeat(1)@(posedge clk);
	aging_req=0;
    repeat(1)@(posedge clk);
    end
endtask
task refresh;
input	[5:0]	cam_addr;
begin
    repeat(1)@(posedge clk);
	cam_refresh_req = 1;
	cam_refresh_addr = cam_addr;
    while(!cam_refresh_ack) repeat(1)@(posedge clk);
	cam_refresh_req = 0;
    repeat(1)@(posedge clk);
    end
endtask
endmodule
