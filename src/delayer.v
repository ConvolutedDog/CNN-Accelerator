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

/*
 * @Author: ConvolutedDog
 * @Date: 2022-04-30 23:30:07
 * @LastEditTime: 2022-05-01 12:27:40
 * @LastEditors: ConvolutedDog
 * @Description: delayer.v
 * @FilePath: \src\delayer.v
 */

/**
 * @description: Signal delay.
 * @param {WIDTH}: Data width.
 * @param {DELAY}: Cycles for delay.
 * @param {stall}: Stall for delay.
 * @input {in}: Input signal, width is WIDTH.
 * @return {out}: Output signal, width is WIDTH and delaye cycles is DELAY.
 */
module delayer
#(parameter WIDTH=16,
  parameter DELAY=10)(
    input clk,
    input rstn,
    input stall,
    input [WIDTH-1:0] in,
    output [WIDTH-1:0] out
);
    /**
     * @description: index for delayer_register shift.
     */    
    integer i = 0;
    integer j = 0;

    /**
     * @description: delayer_register, width is WIDTH and array_size is DELAY.
     */    
    reg [WIDTH-1:0] delayReg [DELAY-1:0];

    always@(posedge clk or negedge rstn)begin
        if(!rstn)begin
            for(i=0; i<DELAY; i=i+1)begin
                delayReg[i] <= 'b0;
            end
        end
        else if(!stall)begin
            delayReg[0] <= in;
            for(j=0; j<DELAY; j=j+1)begin
                delayReg[j+1] <= delayReg[j];
            end
        end
    end

    assign out = delayReg[DELAY-1];
endmodule
