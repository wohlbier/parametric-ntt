/*
Copyright 2020, Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

`include "src/defines.v"

module ModMult(input clk,reset,
               input [`DATA_SIZE_ARB-1:0] A,B,
               input [`DATA_SIZE_ARB-1:0] q,
               output[`DATA_SIZE_ARB-1:0] C);

// --------------------------------------------------------------- connections
wire [(2*`DATA_SIZE_ARB)-1:0] P;

// --------------------------------------------------------------- modules
intMult im(clk,reset,A,B,P);
ModRed  mr(clk,reset,q,P,C);

endmodule
