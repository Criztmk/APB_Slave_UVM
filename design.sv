// Code your design here
// Code your design here
interface dutintf;
  logic clk;
  logic rst_n;
  logic [7:0] paddr;
  logic pwrite;
  logic penable;
  logic psel;
  logic [31:0] prdata;
  logic [31:0] pwdata;
endinterface

module apb_slave(dutintf dif);
logic [31:0] mem [256];
logic [1:0] apb_st;
const logic [1:0] SETUP = 0;
const logic [1:0] W_ENABLE = 1;
const logic [1:0] R_ENABLE = 2;
// SETUP -> ENABLE
  always @(negedge dif.rst_n or posedge dif.clk) begin
  if (dif.rst_n == 0) begin
    apb_st <= 0;
    dif.prdata <= 0;
  end
  else begin
    case (apb_st)
      SETUP : begin
        // clear the prdata
        dif.prdata <= 0;
        // Move to ENABLE when the psel is asserted
        if (dif.psel && !dif.penable) begin
          if (dif.pwrite) begin
            apb_st <= W_ENABLE;
          end
          else begin
            apb_st <= R_ENABLE;
          end
        end
      end
      W_ENABLE : begin
        // write pwdata to memory
        if (dif.psel && dif.penable && dif.pwrite) begin
          mem[dif.paddr] <= dif.pwdata;
        end
        // return to SETUP
        apb_st <= SETUP;
      end
      R_ENABLE : begin
        // read prdata from memory
        if (dif.psel && dif.penable && !dif.pwrite) begin
          dif.prdata <= mem[dif.paddr];
        end
        // return to SETUP
        apb_st <= SETUP;
      end
    endcase
  end
end
endmodule