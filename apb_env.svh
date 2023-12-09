class apb_env extends uvm_env;
`uvm_component_utils(apb_env)
  
  apb_agent agent;
  apb_scoreboard scoreboard;
  apb_bus_monitor bus_monitor;

 function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = apb_agent::type_id::create("agent",this);
    scoreboard = apb_scoreboard::type_id::create("scoreboard",this);
    bus_monitor = apb_bus_monitor::type_id::create("bus_monitor", this);
  endfunction

    function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
      agent.monitor.mon_port.connect(scoreboard.mon_export);
       bus_monitor.bus_mon_port.connect(scoreboard.sb_export);
  endfunction
  
endclass