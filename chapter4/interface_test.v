`timescale 1ns / 1ps
module interface_test;
reg          clk;
reg          rstn;
reg [31:0]    fcs=32'h1234_5678;
reg          bp;
reg          bp0,bp1,bp2,bp3;
wire         sof;
wire         dv;
wire  [7:0]   data;
wire  [47:0]  se_mac;
wire         se_req;
wire         se_ack;
wire  [9:0]   se_hash;
wire  [15:0]  source_portmap;
wire  [15:0]  se_result;
wire         se_nak;
wire         se_source;
wire         sfifo_rd;
wire  [7:0]   sfifo_dout;
wire         ptr_sfifo_rd;
wire  [15:0]  ptr_sfifo_dout;
wire         ptr_sfifo_empty;
wire         emac0_rx_data_fifo_rd;
wire  [7:0]   emac0_rx_data_fifo_dout;
wire         emac0_rx_ptr_fifo_rd;
wire  [15:0]  emac0_rx_ptr_fifo_dout;
wire         emac0_rx_ptr_fifo_empty;
reg          emac0_rx_data_fifo_wr;
reg   [7:0]   emac0_rx_data_fifo_din;
reg          emac0_rx_ptr_fifo_wr;
reg   [15:0]  emac0_rx_ptr_fifo_din;
wire         emac1_rx_data_fifo_rd;
wire  [7:0]   emac1_rx_data_fifo_dout;
wire         emac1_rx_ptr_fifo_rd;
wire  [15:0]  emac1_rx_ptr_fifo_dout;
wire         emac1_rx_ptr_fifo_empty;
reg          emac1_rx_data_fifo_wr;
reg   [7:0]   emac1_rx_data_fifo_din;
reg          emac1_rx_ptr_fifo_wr;
reg   [15:0]  emac1_rx_ptr_fifo_din;
always #5 clk<=~clk;
initial  begin
     bp0=0;
     bp1=0;    
     bp2=0;
     bp3=0;
     rstn<=0;
     clk<=0;
     bp<=0;
     emac0_rx_data_fifo_wr=0;
     emac0_rx_data_fifo_din=0;
     emac0_rx_ptr_fifo_wr=0;
     emac0_rx_ptr_fifo_din=0;
     emac1_rx_data_fifo_wr=0;
     emac1_rx_data_fifo_din=0;
     emac1_rx_ptr_fifo_wr=0;
     emac1_rx_ptr_fifo_din=0;
     #2;
     repeat(5)@(posedge clk);
     rstn=1;
     repeat(3)@(posedge clk);
     write0_frame( 
                11'd100, 
                48'hf0f1f2f3f4f5,
                48'he0e1e2e3e4e5,
                16'h0800,
                1'b0,
                1'b0
                );
     repeat(20)@(posedge clk);
     write1_frame(
                 11'd100,
                 48'he0e1e2e3e4e5,
                 48'hf0f1f2f3f4f5,
                 16'h0800,
                 1'b0,
                 1'b0
                 );
     repeat(5)@(posedge clk);
     write1_frame(
                 11'd100,
                 48'he0e1e2e3e4e5,
                 48'hf0f1f2f3f4f5,
                     16'h0800,
                     1'b1,
                     1'b0
                     );
    end

task write0_frame;
input   [10:0]  length;  
input   [47:0]  da;     
input   [47:0]  sa;     
input   [15:0]  len_type;
input          crc_error;
input          length_error;
integer         i;
begin
 for(i=0;i<length;i=i+1)begin
        emac0_rx_data_fifo_wr<=1;
        if    (i==0) emac0_rx_data_fifo_din=da[47:40];  
        else if (i==1) emac0_rx_data_fifo_din=da[39:32];
        else if (i==2) emac0_rx_data_fifo_din=da[31:24];
        else if (i==3) emac0_rx_data_fifo_din=da[23:16];
        else if (i==4) emac0_rx_data_fifo_din=da[15:8] ;
        else if (i==5) emac0_rx_data_fifo_din=da[7:0]  ;
        else if (i==6) emac0_rx_data_fifo_din=sa[47:40];
        else if (i==7) emac0_rx_data_fifo_din=sa[39:32];
        else if (i==8) emac0_rx_data_fifo_din=sa[31:24];
        else if (i==9) emac0_rx_data_fifo_din=sa[23:16];
        else if (i==10) emac0_rx_data_fifo_din=sa[15:8] ;
        else if (i==11) emac0_rx_data_fifo_din=sa[7:0]  ;
        else if (i==12) emac0_rx_data_fifo_din=len_type[15:8];
        else if (i==13) emac0_rx_data_fifo_din=len_type[7:0];
        else emac0_rx_data_fifo_din=i;
          repeat(1)@(posedge clk);
          end
 emac0_rx_data_fifo_din=fcs[31:24];
 repeat(1)@(posedge clk);
 emac0_rx_data_fifo_din=fcs[23:16];
 repeat(1)@(posedge clk);
 emac0_rx_data_fifo_din=fcs[15:8];
 repeat(1)@(posedge clk);
 emac0_rx_data_fifo_din=fcs[7:0];
 repeat(1)@(posedge clk);
 emac0_rx_data_fifo_wr=0;
 emac0_rx_ptr_fifo_wr=1;
 length=length+4;
 emac0_rx_ptr_fifo_din={5'b0,length[10:0]};
 repeat(1)@(posedge clk);
 emac0_rx_ptr_fifo_wr=0;
end
endtask
task write1_frame;
input   [10:0]  length; 
input   [47:0]  da;   
input   [47:0]  sa;  
input   [15:0]  len_type; 
input         crc_error;
input         length_error;
integer        i;
begin
 for(i=0;i<length;i=i+1)begin
        emac1_rx_data_fifo_wr<=1;
        if    (i==0)    emac1_rx_data_fifo_din=da[47:40];  
        else if (i==1)  emac1_rx_data_fifo_din=da[39:32];
        else if (i==2)  emac1_rx_data_fifo_din=da[31:24];
        else if (i==3)  emac1_rx_data_fifo_din=da[23:16];
        else if (i==4)  emac1_rx_data_fifo_din=da[15:8] ;
        else if (i==5)  emac1_rx_data_fifo_din=da[7:0]  ;
        else if (i==6)  emac1_rx_data_fifo_din=sa[47:40];
        else if (i==7)  emac1_rx_data_fifo_din=sa[39:32];
        else if (i==8)  emac1_rx_data_fifo_din=sa[31:24];
        else if (i==9)  emac1_rx_data_fifo_din=sa[23:16];
        else if (i==10) emac1_rx_data_fifo_din=sa[15:8] ;
        else if (i==11) emac1_rx_data_fifo_din=sa[7:0]  ;
        else if (i==12) emac1_rx_data_fifo_din=len_type[15:8];
        else if (i==13) emac1_rx_data_fifo_din=len_type[7:0];
        else emac1_rx_data_fifo_din=i;
          repeat(1)@(posedge clk);
          end
 emac1_rx_data_fifo_din=fcs[31:24];
 repeat(1)@(posedge clk);
 emac1_rx_data_fifo_din=fcs[23:16];
 repeat(1)@(posedge clk);
 emac1_rx_data_fifo_din=fcs[15:8];
 repeat(1)@(posedge clk);
 emac1_rx_data_fifo_din=fcs[7:0];
 repeat(1)@(posedge clk);
 emac1_rx_data_fifo_wr=0;
 emac1_rx_ptr_fifo_wr=1;
 length=length+4;
 emac1_rx_ptr_fifo_din={crc_error,length_error,3'b0,length[10:0]};
 repeat(1)@(posedge clk);
 emac1_rx_ptr_fifo_wr=0;
end
endtask
interface_mux u_interface_mux(
	.clk(clk),
	.rstn(rstn),
	.rx_data_fifo_dout0(emac0_rx_data_fifo_dout),
	.rx_data_fifo_rd0(emac0_rx_data_fifo_rd),
	.rx_ptr_fifo_dout0(emac0_rx_ptr_fifo_dout),
	.rx_ptr_fifo_rd0(emac0_rx_ptr_fifo_rd),
	.rx_ptr_fifo_empty0(emac0_rx_ptr_fifo_empty),                                      
	.rx_data_fifo_dout1(emac1_rx_data_fifo_dout),
	.rx_data_fifo_rd1(emac1_rx_data_fifo_rd),
	.rx_ptr_fifo_dout1(emac1_rx_ptr_fifo_dout),
	.rx_ptr_fifo_rd1(emac1_rx_ptr_fifo_rd),
	.rx_ptr_fifo_empty1(emac1_rx_ptr_fifo_empty),     
	
	.rx_data_fifo_dout2(8'b0),
	.rx_data_fifo_rd2(),
	.rx_ptr_fifo_dout2(16'b0),
	.rx_ptr_fifo_rd2(),
	.rx_ptr_fifo_empty2(1'b1),                                         

	.rx_data_fifo_dout3(8'b0),
	.rx_data_fifo_rd3(),
	.rx_ptr_fifo_dout3(16'b0),
	.rx_ptr_fifo_rd3(),
	.rx_ptr_fifo_empty3(1'b1),                                        

	.sfifo_rd(sfifo_rd),
	.sfifo_dout(sfifo_dout),
	.ptr_sfifo_rd(ptr_sfifo_rd),
	.ptr_sfifo_dout(ptr_sfifo_dout),
	.ptr_sfifo_empty(ptr_sfifo_empty)
	);                                
frame_process u_frame_process(
	.clk(clk),
	.rstn(rstn),
	.bp0(bp0),
	.bp1(bp1),
	.bp2(bp2),
	.bp3(bp3),
	.sfifo_dout(sfifo_dout),
	.sfifo_rd(sfifo_rd),
	.ptr_sfifo_rd(ptr_sfifo_rd),
	.ptr_sfifo_empty(ptr_sfifo_empty),
	.ptr_sfifo_dout(ptr_sfifo_dout),                                         
	.sof(sof),
	.dv(dv),
	.data(data),                                        
	.se_mac(se_mac),
	.se_req(se_req),
	.se_ack(se_ack),
	.source_portmap(source_portmap),
	.se_result(se_result),
	.se_nak(se_nak),
	.se_source(se_source),
	.se_hash(se_hash)
	);      
hash_2_bucket u_hash(
	.clk(clk),
	.rstn(rstn),
	.se_req(se_req),
	.se_ack(se_ack),
	.se_hash(se_hash),
	.se_portmap(source_portmap),
	.se_source(se_source),
	.se_result(se_result),
	.se_nak(se_nak),
	.se_mac(se_mac),
	.aging_req(1'b0),
	.aging_ack()
	);
afifo_w8_d4k u0_data_fifo (
  .rst(!rstn),                      // input rst
  .wr_clk(clk),                     // input wr_clk
  .rd_clk(clk),                     // input rd_clk
  .din(emac0_rx_data_fifo_din),      // input [7 : 0] din
  .wr_en(emac0_rx_data_fifo_wr),    // input wr_en
  .rd_en(emac0_rx_data_fifo_rd),     // input rd_en
  .dout(emac0_rx_data_fifo_dout),     // output [7 : 0] dout
  .full(), 							// output full
  .empty(), 							// output empty
  .rd_data_count(),  // output [11 : 0] rd_data_count
  .wr_data_count()  // output [11 : 0] wr_data_count
);

afifo_w16_d32 u0_ptr_fifo (
  .rst(!rstn),                      // input rst
  .wr_clk(clk),                     // input wr_clk
  .rd_clk(clk),                     // input rd_clk
  .din(emac0_rx_ptr_fifo_din),        // input [15 : 0] din
  .wr_en(emac0_rx_ptr_fifo_wr),     // input wr_en
  .rd_en(emac0_rx_ptr_fifo_rd),      // input rd_en
  .dout(emac0_rx_ptr_fifo_dout),     // output [15 : 0] dout
  .full(),          // output full
  .empty(emac0_rx_ptr_fifo_empty)    // output empty
);

afifo_w8_d4k u1_data_fifo (
  .rst(!rstn),                      // input rst
  .wr_clk(clk),                     // input wr_clk
  .rd_clk(clk),                     // input rd_clk
  .din(emac1_rx_data_fifo_din),      // input [7 : 0] din
  .wr_en(emac1_rx_data_fifo_wr),    // input wr_en
  .rd_en(emac1_rx_data_fifo_rd),     // input rd_en
  .dout(emac1_rx_data_fifo_dout),     // output [7 : 0] dout
  .full(), 							// output full
  .empty(), 							// output empty
  .rd_data_count(),  // output [11 : 0] rd_data_count
  .wr_data_count()  // output [11 : 0] wr_data_count
);
afifo_w16_d32 u1_ptr_fifo (
  .rst(!rstn),                      // input rst
  .wr_clk(clk),                    // input wr_clk
  .rd_clk(clk),                     // input rd_clk
  .din(emac1_rx_ptr_fifo_din),       // input [15 : 0] din
  .wr_en(emac1_rx_ptr_fifo_wr),     // input wr_en
  .rd_en(emac1_rx_ptr_fifo_rd),      // input rd_en
  .dout(emac1_rx_ptr_fifo_dout),     // output [15 : 0] dout
  .full(),         			 // output full
  .empty(emac1_rx_ptr_fifo_empty)   // output empty
);
endmodule
