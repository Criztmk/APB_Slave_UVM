//This scorebaord has 2 analysis ports
//1.mon_export - Data comes from apb_monitor
//2.sb_export - Data comes form apb_bus_monitor

`uvm_analysis_imp_decl(_expdata)
`uvm_analysis_imp_decl(_actdata)

class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
  
  uvm_analysis_imp_expdata#(apb_transaction, apb_scoreboard) mon_export;
  uvm_analysis_imp_actdata#(apb_transaction, apb_scoreboard) sb_export;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_export = new("mon_export", this);
    sb_export = new("sb_export", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
 
  apb_transaction act_queue[$];
  
  function write_expdata(input apb_transaction tr);
    apb_transaction actdata;
    if(act_queue.size()) begin
      actdata =act_queue.pop_front();
      if(tr.compare(actdata))begin
        `uvm_info("",$sformatf("MATCHED"),UVM_LOW)
      end
      else begin
        `uvm_info("",$sformatf("MISMATCHED"),UVM_LOW)
      end
    end
  endfunction
  
  function write_actdata(input apb_transaction tr);
    act_queue.push_back(tr);
  endfunction
                            
endclass

  
  