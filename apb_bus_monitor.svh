class apb_bus_monitor extends uvm_monitor;
  `uvm_component_utils(apb_bus_monitor)
  
   virtual dutintf vintf;
  
   apb_transaction apb_trans;
  
  uvm_analysis_port#(apb_transaction) bus_mon_port;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    apb_trans = new();
    bus_mon_port=new("bus_mon_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dutintf)::get(this, "*", "vintf", vintf))begin
      `uvm_error("","bus monitor interface failed")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    @(posedge vintf.clk);
    apb_trans.paddr = vintf.paddr;
    apb_trans.pwdata = vintf.pwdata;
    apb_trans.prdata = vintf.prdata;
    bus_mon_port.write(apb_trans);
    `uvm_info("",$sformatf("Bus MOnitor Paddr %x, pwdata %x, prdata %x", vintf.paddr, vintf.pwdata, vintf.prdata), UVM_LOW)
    end
  endtask
endclass
  