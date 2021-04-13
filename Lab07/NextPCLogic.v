module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output [63:0] NextPC; 
       
       reg [63:0] NextPC;
       
       always@(*)
              begin
                     if(Uncondbranch)                                 //for unconditional branches
                     begin
                            NextPC <= #3 CurrentPC + SignExtImm64;
                     end
                     else if(Branch)
                     begin
                            if(ALUZero == 1)
                            begin
                                   NextPC <= #3 CurrentPC + SignExtImm64;        //for conditional branches and ALUZero
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
