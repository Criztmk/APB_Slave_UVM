// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
module top;
 import uvm_pkg::*;
  `include "apb_transaction.svh"
  `include "apb_sequence.svh"
  `include "apb_monitor.svh"
  `include "apb_driver.svh"
  `include "apb_agent.svh"
  `include "apb_bus_monitor.svh"  
  `include "apb_scoreboard.svh"
  `include "apb_env.svh"
  `include "apb_test.svh"
  
  dutintf intf();
  
  apb_slave dut(.dif(intf));
  
  initial begin
    intf.clk =0;
    forever 
      #5 intf.clk = ~intf.clk;
  end
  
  initial begin
    uvm_config_db#(virtual dutintf)::set(null,"*","vintf", intf);
    run_test("apb_test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
     $dumpvars(0, top);
  end
endmodule