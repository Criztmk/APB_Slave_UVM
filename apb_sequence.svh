`include "apb_write_seq.svh"
`include "apb_read_seq.svh"
class apb_sequence extends uvm_sequence #(apb_transaction);
  `uvm_object_utils(apb_sequence)
  
  
  function new(string name = "");
    super.new(name);
  endfunction
  
  task body();
    apb_write_sequence write;
    apb_read_sequence read;
    begin
      repeat(4)begin
        `uvm_do(write);
      end
      repeat(4) begin
        `uvm_do(read);
      end
    end
  endtask
  
endclass