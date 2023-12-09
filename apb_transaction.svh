class apb_transaction extends uvm_sequence_item;  
  `uvm_object_utils(apb_transaction)
  
  rand bit [7:0]paddr;
  rand bit pwrite;
  rand bit [31:0] pwdata;
  rand bit [31:0] prdata;
  rand bit psel;
  rand bit penable;
  
  constraint c1{paddr[1:0] ==2'b00;};
  constraint c3 {psel == 1'b1;};

   function new(string name = "");
    super.new(name);
  endfunction
  
endclass