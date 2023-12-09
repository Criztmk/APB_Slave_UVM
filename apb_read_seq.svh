class apb_read_sequence extends uvm_sequence#(apb_transaction);
  `uvm_object_utils(apb_read_sequence)
  
  function new(string name = "");
    super.new(name);
  endfunction
  
  apb_transaction apb_trans;
  
  task body();
    begin
      `uvm_do_with(apb_trans,{apb_trans.pwrite == 1'b0; apb_trans.penable == 1'b0;})
      `uvm_do_with(req,{req.pwrite == 1'b0; req.penable == 1'b1; req.paddr == 8'h00;})
      `uvm_do_with(req,{req.pwrite == 1'b0; req.penable == 1'b0;})
      `uvm_do_with(req,{req.pwrite == 1'b0; req.penable == 1'b1; req.paddr == 8'h04;})
      `uvm_do_with(req,{req.pwrite == 1'b0; req.penable == 1'b0;})
      `uvm_do_with(req,{req.pwrite == 1'b0; req.penable == 1'b1; req.paddr == 8'h08;})
    end
  endtask
endclass
  
  