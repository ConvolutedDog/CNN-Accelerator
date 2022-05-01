//  Copyright 2022 ConvolutedDog (https://github.com/ConvolutedDog/)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

`timescale 10ns/10ns

`include "./src/delayer.v"

module tb_delayer;
    reg         clk;
    reg         rstn;
    reg         stall;
    reg [31:0]  in;
    wire [31:0] out;
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_delayer);
        
        clk = 'b0;
        rstn = 'b1;
        stall = 'b0;
        in = 'd1;
        
        #20 
        rstn = 'b0;
        stall = 'b0;

        #20
        rstn = 'b1;
        stall = 'b0;

        #100
        stall = 'b1;

        #100
        stall = 'b0;

        #6000 $finish;
    end

    always #20 clk = !clk;

    always@(posedge clk)begin
        in <= in + 'd1;
    end

    delayer
    #(.WIDTH(32),
      .DELAY(5))
      mydelayer(
        .clk(clk),
        .rstn(rstn),
        .stall(stall),
        .in(in),
        .out(out)
    );

endmodule 
