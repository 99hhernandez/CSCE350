module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output [63:0] NextPC; 
       
       reg [63:0] tempImm64;
       reg [63:0] NextPC;
       
       always@(*)
              begin
                     tempImm64 = SignExtImm64 << 2;                   //shift value over by 2
                     if(Uncondbranch)                                 //for unconditional branches
                     begin
                            NextPC <= #1 CurrentPC + tempImm64;
                     end
                     else if(Branch)
                     begin
                            if(ALUZero == 1)
                            begin
                                   NextPC <= #2 CurrentPC + tempImm64;        //for conditional branches and ALUZero
                            end
                            else 
                            begin
                                   NextPC <= #2 CurrentPC + 4;               //for conditional branches and not ALUZero
                            end
                     end
                     else                                             //Unconditional branch and Branch are false
                     begin                
                            NextPC <= #2 CurrentPC + 4;
                     end
              end
endmodule
