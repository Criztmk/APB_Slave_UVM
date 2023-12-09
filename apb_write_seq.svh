class apb_write_sequence extends uvm_sequence#(apb_transaction);
  
  `uvm_object_utils(apb_write_sequence)
  
  function new(string name = "");
    super.new(name);
  endfunction
  
  task body();
    begin
      `uvm_do_with(req,{req.penable == 1'b0;req.pwrite == 1'b1;})
      `uvm_do_with(req,{req.paddr == 8'h00;req.pwdata == 32'hffffeeee;req.penable == 1'b1;req.pwrite == 1'b1;})
      `uvm_do_with(req,{req.penable == 1'b0;req.pwrite == 1'b1;})
      `uvm_do_with(req,{req.paddr == 8'h04;req.pwdata == 32'hffff1111;req.penable == 1'b1;req.pwrite == 1'b1;})
      `uvm_do_with(req,{req.penable == 1'b0;req.pwrite == 1'b1;})
      `uvm_do_with(req,{req.paddr == 8'h08;req.pwdata == 32'hffff2222;req.penable == 1'b1;req.pwrite == 1'b1;})
    end
  endtask
endclass