`timescale 1ns / 1ps
module top_testbench;

// Inputs
reg       sys_clk;
reg       rstn;
reg [3:0] MII_RXD_0;
reg       MII_RX_DV_0;
reg       MII_RX_CLK_0;
reg       MII_RX_ER_0;
reg [3:0] MII_RXD_1;
reg       MII_RX_DV_1;
reg       MII_RX_CLK_1;
reg       MII_RX_ER_1;
reg [3:0] MII_RXD_2;
reg       MII_RX_DV_2;
reg       MII_RX_CLK_2;
reg       MII_RX_ER_2;
reg [3:0] MII_RXD_3;
reg       MII_RX_DV_3;
reg       MII_RX_CLK_3;
reg       MII_RX_ER_3;
reg       MII_TX_CLK_0;
reg       MII_TX_CLK_1;
reg       MII_TX_CLK_2;
reg       MII_TX_CLK_3;
// Outputs
wire [3:0] MII_TXD_0;
wire       MII_TX_EN_0;
wire       MII_TX_ER_0;
wire [3:0] MII_TXD_1;
wire       MII_TX_EN_1;
wire       MII_TX_ER_1;
wire [3:0] MII_TXD_2;
wire       MII_TX_EN_2;
wire       MII_TX_ER_2;
wire [3:0] MII_TXD_3;
wire       MII_TX_EN_3;
wire       MII_TX_ER_3;

wire       phy_rstn_0;
wire       phy_rstn_1;
wire       phy_rstn_2;
wire       phy_rstn_3;
//interface of hash_match
reg        calc_en;
reg [7:0]  crc_din;
reg        load_init;
reg        d_valid;
wire[31:0] crc_reg;
wire[7:0]  crc_out;	
// Instantiate the Unit Under Test (UUT)
top_switch uut (
    .sys_clk(sys_clk),
	.MII_RXD_0(MII_RXD_0), 
	.MII_RX_DV_0(MII_RX_DV_0), 
	.MII_RX_CLK_0(MII_RX_CLK_0), 
	.MII_RX_ER_0(MII_RX_ER_0), 
	.MII_TXD_0(MII_TXD_0), 
	.MII_TX_EN_0(MII_TX_EN_0), 
	.MII_TX_CLK_0(MII_TX_CLK_0), 
	.MII_TX_ER_0(MII_TX_ER_0), 
	.MII_RXD_1(MII_RXD_1), 
	.MII_RX_DV_1(MII_RX_DV_1), 
	.MII_RX_CLK_1(MII_RX_CLK_1), 
	.MII_RX_ER_1(MII_RX_ER_1), 
	.MII_TXD_1(MII_TXD_1), 
	.MII_TX_EN_1(MII_TX_EN_1), 
	.MII_TX_CLK_1(MII_TX_CLK_1), 
	.MII_TX_ER_1(MII_TX_ER_1), 
	.MII_RXD_2(MII_RXD_2), 
	.MII_RX_DV_2(MII_RX_DV_2), 
	.MII_RX_CLK_2(MII_RX_CLK_2), 
	.MII_RX_ER_2(MII_RX_ER_2), 
	.MII_TXD_2(MII_TXD_2), 
	.MII_TX_EN_2(MII_TX_EN_2), 
	.MII_TX_CLK_2(MII_TX_CLK_2), 
	.MII_TX_ER_2(MII_TX_ER_2), 
	.MII_RXD_3(MII_RXD_3), 
	.MII_RX_DV_3(MII_RX_DV_3), 
	.MII_RX_CLK_3(MII_RX_CLK_3), 
	.MII_RX_ER_3(MII_RX_ER_3), 
	.MII_TXD_3(MII_TXD_3), 
	.MII_TX_EN_3(MII_TX_EN_3), 
	.MII_TX_CLK_3(MII_TX_CLK_3), 
	.MII_TX_ER_3(MII_TX_ER_3)
);
always begin
    #5;
    MII_RX_CLK_0=~MII_RX_CLK_0;
	MII_RX_CLK_1=~MII_RX_CLK_1;
	MII_RX_CLK_2=~MII_RX_CLK_2;
	MII_RX_CLK_3=~MII_RX_CLK_3;
    
    MII_TX_CLK_0=~MII_TX_CLK_0;
    MII_TX_CLK_1=~MII_TX_CLK_1;
    MII_TX_CLK_2=~MII_TX_CLK_2;
    MII_TX_CLK_3=~MII_TX_CLK_3;
    end
always #10 sys_clk=~sys_clk;
initial begin
	// Initialize Inputs
	sys_clk=0;
	rstn=0;
	MII_RXD_0 = 0;
	MII_RX_DV_0 = 0;
	MII_RX_CLK_0 = 0;
	MII_RX_ER_0 = 0;
	MII_RXD_1 = 0;
	MII_RX_DV_1 = 0;
	MII_RX_CLK_1 = 0;
	MII_RX_ER_1 = 0;
	MII_RXD_2 = 0;
	MII_RX_DV_2 = 0;
	MII_RX_CLK_2 = 0;
	MII_RX_ER_2 = 0;
	MII_RXD_3 = 0;
	MII_RX_DV_3 = 0;
	MII_RX_CLK_3 = 0;
	MII_RX_ER_3 = 0;
    MII_TX_CLK_0=0;
    MII_TX_CLK_1=0;
    MII_TX_CLK_2=0;
    MII_TX_CLK_3=0;
	repeat(10)@(posedge MII_RX_CLK_0);
	rstn=1;
    repeat(150)@(posedge MII_RX_CLK_0);
	send_mac0_frame(11'd100,48'hffffffffffff,48'he0e1e2e3e4e5,16'h0806,1'b0);
	repeat(15)@(posedge MII_RX_CLK_0);
	send_mac0_frame(11'd100,48'hf0f1f2f3f4f5,48'he0e1e2e3e4e5,16'h0800,1'b0);
	repeat(15)@(posedge MII_RX_CLK_0);
	send_mac1_frame(11'd100,48'he0e1e2e3e4e5,48'hf0f1f2f3f4f5,16'h0800,1'b0);	
end


task send_mac0_frame;
input   [10:0]  length;	
input   [47:0]  da;		
input   [47:0]  sa;		
input   [15:0]  len_type;
input           crc_error_insert;
integer         i;
reg     [7:0]   mii_din;
reg     [31:0]  fcs;
begin
    MII_RX_DV_0=0;
	MII_RXD_0=0;
	fcs=0;
	#2;
	load_init=1;
	repeat(1)@(posedge MII_RX_CLK_0);
	load_init=0;
	MII_RX_DV_0=1;
	MII_RXD_0=4'h5;
	repeat(15)@(posedge MII_RX_CLK_0);
	MII_RXD_0=4'hd;
	repeat(1)@(posedge MII_RX_CLK_0);
    for(i=0;i<length;i=i+1)begin
	    if    (i==0)  mii_din=da[47:40];  
        else if (i==1)  mii_din=da[39:32];
        else if (i==2)  mii_din=da[31:24];
        else if (i==3)  mii_din=da[23:16];
        else if (i==4)  mii_din=da[15:8] ;
        else if (i==5)  mii_din=da[7:0]  ;
        else if (i==6)  mii_din=sa[47:40];
        else if (i==7)  mii_din=sa[39:32];
        else if (i==8)  mii_din=sa[31:24];
        else if (i==9)  mii_din=sa[23:16];
        else if (i==10) mii_din=sa[15:8] ;
        else if (i==11) mii_din=sa[7:0]  ;
        else if (i==12) mii_din=len_type[15:8];
        else if (i==13) mii_din=len_type[7:0];
        else mii_din={$random}%256;
		MII_RXD_0=mii_din[3:0];
		calc_en=1;
		crc_din=mii_din[7:0];
		d_valid=1;
		repeat(1)@(posedge MII_RX_CLK_0);
		d_valid=0;
		calc_en=0;
		crc_din=mii_din[7:0];
		MII_RXD_0=mii_din[7:4];
		repeat(1)@(posedge MII_RX_CLK_0);
	    end
	d_valid=1;
    if(!crc_error_insert) crc_din=crc_out[7:0];
    else crc_din=~crc_out[7:0];
    MII_RXD_0=crc_din[3:0];
    repeat(1)@(posedge MII_RX_CLK_0);
    d_valid=0;
    MII_RXD_0=crc_din[7:4];
    repeat(1)@(posedge MII_RX_CLK_0);
	 
	d_valid=1;
    if(!crc_error_insert) crc_din=crc_out[7:0];
    else crc_din=~crc_out[7:0];
    MII_RXD_0=crc_din[3:0];
    repeat(1)@(posedge MII_RX_CLK_0);
    d_valid=0;
    MII_RXD_0=crc_din[7:4];
    repeat(1)@(posedge MII_RX_CLK_0);
	 
	d_valid=1;
    if(!crc_error_insert) crc_din=crc_out[7:0];
    else crc_din=~crc_out[7:0];
    MII_RXD_0=crc_din[3:0];
    repeat(1)@(posedge MII_RX_CLK_0);
    d_valid=0;
    MII_RXD_0=crc_din[7:4];
    repeat(1)@(posedge MII_RX_CLK_0);
	 
	d_valid=1;
    if(!crc_error_insert) crc_din=crc_out[7:0];
    else crc_din=~crc_out[7:0];
    MII_RXD_0=crc_din[3:0];
    repeat(1)@(posedge MII_RX_CLK_0);
    d_valid=0;
    MII_RXD_0=crc_din[7:4];
    repeat(1)@(posedge MII_RX_CLK_0);
	MII_RX_DV_0=0;
    end
endtask


task send_mac1_frame;
input   [10:0]  length;	
input   [47:0]  da;		
input   [47:0]  sa;		
input   [15:0]  len_type;	
input           crc_error_insert;
integer         i;
reg     [7:0]   mii_din;
reg     [31:0]  fcs;
begin
    MII_RX_DV_1=0;
    MII_RXD_1=0;
    fcs=0;
    #2;
	load_init=1;
	repeat(1)@(posedge MII_RX_CLK_1);
	load_init=0;
	MII_RX_DV_1=1;
	MII_RXD_1=4'h5;
	repeat(15)@(posedge MII_RX_CLK_1);
	MII_RXD_1=4'hd;
	repeat(1)@(posedge MII_RX_CLK_1);
    for(i=0;i<length;i=i+1)begin
		if    (i==0)  mii_din=da[47:40];  
		else if (i==1)  mii_din=da[39:32];
		else if (i==2)  mii_din=da[31:24];
		else if (i==3)  mii_din=da[23:16];
		else if (i==4)  mii_din=da[15:8] ;
		else if (i==5)  mii_din=da[7:0]  ;
		else if (i==6)  mii_din=sa[47:40];
		else if (i==7)  mii_din=sa[39:32];
		else if (i==8)  mii_din=sa[31:24];
		else if (i==9)  mii_din=sa[23:16];
		else if (i==10) mii_din=sa[15:8] ;
		else if (i==11) mii_din=sa[7:0]  ;
		else if (i==12) mii_din=len_type[15:8];
		else if (i==13) mii_din=len_type[7:0];
		else mii_din={$random}%256;
		MII_RXD_1=mii_din[3:0];
		calc_en=1;
		crc_din=mii_din[7:0];
		d_valid=1;
		repeat(1)@(posedge MII_RX_CLK_1);
		d_valid=0;
		calc_en=0;
		crc_din=mii_din[7:0];
		MII_RXD_1=mii_din[7:4];
		repeat(1)@(posedge MII_RX_CLK_1);
	    end
	d_valid=1;
	if(!crc_error_insert) crc_din=crc_out[7:0];
	else crc_din=~crc_out[7:0];
	MII_RXD_1=crc_din[3:0];
	repeat(1)@(posedge MII_RX_CLK_1);
	d_valid=0;
	MII_RXD_1=crc_din[7:4];
	repeat(1)@(posedge MII_RX_CLK_1);
	 
	d_valid=1;
	if(!crc_error_insert) crc_din=crc_out[7:0];
	else crc_din=~crc_out[7:0];
	MII_RXD_1=crc_din[3:0];
	repeat(1)@(posedge MII_RX_CLK_1);
	d_valid=0;
	MII_RXD_1=crc_din[7:4];
	repeat(1)@(posedge MII_RX_CLK_1);
	 
	d_valid=1;
	if(!crc_error_insert) crc_din=crc_out[7:0];
	else crc_din=~crc_out[7:0];
	MII_RXD_1=crc_din[3:0];
	repeat(1)@(posedge MII_RX_CLK_1);
	d_valid=0;
	MII_RXD_1=crc_din[7:4];
	repeat(1)@(posedge MII_RX_CLK_1);
	 
	d_valid=1;
	if(!crc_error_insert) crc_din=crc_out[7:0];
	else crc_din=~crc_out[7:0];
	MII_RXD_1=crc_din[3:0];
	repeat(1)@(posedge MII_RX_CLK_1);
	d_valid=0;
	MII_RXD_1=crc_din[7:4];
	repeat(1)@(posedge MII_RX_CLK_1);
	MII_RX_DV_1=0;
    end
	endtask


crc32_8023 u1_crc32_8023(
	.clk(MII_RX_CLK_0), 
	.reset(!rstn), 
	.d(crc_din[7:0]), 
	.load_init(load_init),
	.calc(calc_en), 
	.d_valid(d_valid), 
	.crc_reg(crc_reg), 
	.crc(crc_out)
	);
  
endmodule

