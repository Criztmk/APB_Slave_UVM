class apb_driver extends uvm_driver#(apb_transaction);
  `uvm_component_utils(apb_driver)
  
  virtual dutintf vintf;
  
  apb_transaction apb_trans;
  function new(string name, uvm_component parent);
    super.new(name, parent);
    apb_trans = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dutintf)::get(this, "*", "vintf", vintf)) begin
      `uvm_error("","driver virtual interface failed")
    end
  endfunction
  

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    vintf.rst_n = 0;
    #5;
    @(posedge vintf.clk);
    vintf.rst_n = 1;
    forever begin
    seq_item_port.get_next_item(req);
    vintf.paddr = req.paddr;
    vintf.pwrite = req.pwrite;
    vintf.psel = req.psel;
    vintf.pwdata = req.pwdata;
    vintf.penable = req.penable;
    //`uvm_info("",$sformatf("paddr is %x, pwdata is %x, psel is %x, penable is %x, pwrite is %x", vintf.paddr, vintf.pwdata, vintf.psel, vintf.penable, vintf.pwrite), UVM_LOW)
    @(posedge vintf.clk);
    seq_item_port.item_done();
    end
  endtask
  
endclass
  
    