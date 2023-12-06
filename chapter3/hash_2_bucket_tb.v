`timescale 1ns / 1ps
module hash_2_bucket_tb;
// Inputs
reg clk;
reg rstn;
reg se_source;
reg [47:0] se_mac;
reg [15:0] se_portmap;
reg [9:0] se_hash;
reg se_req;
reg aging_req;
// Outputs
wire se_ack;
wire se_nak;
wire [15:0] se_result;
wire aging_ack;
always #5 clk=~clk;
// Instantiate the Unit Under Test (UUT)
hash_2_bucket #(10'd3) uut (	
	.clk(clk), 
	.rstn(rstn), 
	.se_source(se_source), 
	.se_mac(se_mac), 
	.se_portmap(se_portmap), 
	.se_hash(se_hash), 
	.se_req(se_req), 
	.se_ack(se_ack), 
	.se_nak(se_nak), 
	.se_result(se_result), 
	.aging_req(aging_req), 
	.aging_ack(aging_ack)
);

initial begin
	// Initialize Inputs
	clk = 0;
	rstn = 0;
	se_source = 0;
	se_mac = 0;
	se_portmap = 0;
	se_hash = 0;
	se_req = 0;
	aging_req = 0;

	// Wait 100 ns for global reset to finish
	#100;
	rstn=1;
	// Add stimulus here
	#20_000;
	add_entry(48'he0e1e2e3e4e5,16'h0002,100);
	add_entry(48'hd0d1d2d3d4d5,16'h0004,100);
	add_entry(48'hc0c1c2c3c4c5,16'h0008,100);
	#100;
	search(48'he0e1e2e3e4e5,100);
	search(48'hd0d1d2d3d4d5,100);
	search(48'hc0c1c2c3c4c5,100);
	#100;
	aging;
	#100;
	aging;
	add_entry(48'he0e1e2e3e4e5,16'h0002,100);
	#100;
	aging;
	#100;
	aging;
	search(48'he0e1e2e3e4e5,100);
	search(48'hd0d1d2d3d4d5,100);
end
task add_entry;    
input	[47:0]	mac_addr;
input	[15:0]	portmap;
input	[9:0]	hash;
begin
	repeat(1)@(posedge clk);
	#2;
	se_source=1;
	se_mac=mac_addr;
	se_portmap=portmap;
	se_hash=hash[9:0];
	se_req<=#2 1;
	while(!(se_ack | se_nak)) repeat(1)@(posedge clk);
	#2;
	se_req=0;
	se_source=0;
	end
endtask
task search;
input	[47:0]	mac_addr;
input	[9:0]	hash;
begin
	repeat(1)@(posedge clk);
	#2;
	se_source=0;
	se_mac=mac_addr;
	se_hash=hash[9:0];
	se_req<=#2 1;
	while(!(se_ack | se_nak)) repeat(1)@(posedge clk);
	#2;
	se_req=0;
	end
endtask
task aging;
begin
	repeat(1)@(posedge clk);
	#2;
	aging_req=1;
	while(!aging_ack) repeat(1)@(posedge clk);
	#2;
	aging_req=0;
	end
endtask
endmodule
