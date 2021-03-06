/* 
Copyright (c) 2018, IIT Madras All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions
  and the following disclaimer.  
* Redistributions in binary form must reproduce the above copyright notice, this list of 
  conditions and the following disclaimer in the documentation and/or other materials provided 
 with the distribution.  
* Neither the name of IIT Madras  nor the names of its contributors may be used to endorse or 
  promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------------------------

Author: Neel Gala
Email id: neelgala@gmail.com
Details:

--------------------------------------------------------------------------------------------------
*/
package Soc;
  // project related imports
	import Semi_FIFOF:: *;
	import AXI4_Types:: *;
	import AXI4_Fabric:: *;
  import cclass:: * ;
  import Clocks :: *;
  import common_types::*;
  `include "Soc.defines"

  // peripheral imports
  import bram::*;
  import bootrom:: *;
  import uart::*;
  import clint::*;
  import err_slave::*;
  // package imports
  import Connectable:: *;
  import GetPut:: *;
  import Vector::*;

  import debug_types::*;                                                                          
  import jtagdtm::*;                                                                              
  import riscvDebug013::*;                                                                        
  import debug_halt_loop::*;

	import gpio				::*;
	import plic				::*;
	import i2c			 :: *;
 
  function Bit#(TLog#(`Num_Slaves)) fn_slave_map (Bit#(`paddr) addr);
    Bit#(TLog#(`Num_Slaves)) slave_num = 0;
    if(addr >= `MemoryBase && addr<= `MemoryEnd)
      slave_num = `Memory_slave_num;
    else if(addr>= `UartBase && addr<= `UartEnd)
      slave_num = `Uart_slave_num;
    else if(addr>= `ClintBase && addr<= `ClintEnd)
      slave_num = `Clint_slave_num;
    else if(addr>= `DebugBase && addr<= `DebugEnd)
      slave_num = `Debug_slave_num;
    else if(addr>= `GPIOBase && addr<= `GPIOEnd)
      slave_num = `GPIO_slave_num;
    else if(addr>= `PLICBase && addr<= `PLICEnd)
      slave_num = `PLIC_slave_num;
    else if(addr>= `I2CBase && addr<= `I2CEnd)
      slave_num = `I2C_slave_num;
    else
      slave_num = `Err_slave_num;
      
    return slave_num;
  endfunction:fn_slave_map

  interface Ifc_Soc;
    interface AXI4_Master_IFC#(`paddr, ELEN, USERSPACE) mem_master;
    interface RS232 uart_io;
      // ------------- JTAG IOs ----------------------//
    (*always_enabled,always_ready*)                                                               
    method Action wire_tms(Bit#(1)tms_in);                                                        

    (*always_enabled,always_ready*)                                                               
    method Action wire_tdi(Bit#(1)tdi_in);                                                        

    (*always_enabled,always_ready*)                                                               
    method Bit#(1)wire_tdo;                                                                       
      // ---------------------------------------------//
		method I2C_out i2c_out;									//I2c IO interface

    (*always_enabled,always_ready*)                                                               
		method Action interrupts(Bit#(8) inp);	//External interrupts to PLIC
    interface GPIO#(16) gpio_io;						//GPIO IO interface
  endinterface

  (*synthesize*)
	(*conflict_free = "rl_core_plic_connection, operation"*)
  module mkSoc#(Clock tck_clk, Reset trst)(Ifc_Soc);
    let curr_clk<-exposeCurrentClock;
    let curr_reset<-exposeCurrentReset;
    Ifc_cclass_axi4 cclass <- mkcclass_axi4();

    AXI4_Fabric_IFC #(`Num_Masters, `Num_Slaves, `paddr, ELEN, USERSPACE) 
                                                    fabric <- mkAXI4_Fabric(fn_slave_map);
    Ifc_debug_halt_loop#(`paddr, ELEN, USERSPACE) debug_memory <- mkdebug_halt_loop;
	  Ifc_uart_axi4#(`paddr,ELEN,0, 16) uart <- mkuart_axi4(curr_clk,curr_reset, 68);
    Ifc_clint_axi4#(`paddr, ELEN, 0, 1, 16) clint <- mkclint_axi4();
    Ifc_err_slave_axi4#(`paddr,ELEN,0) err_slave <- mkerr_slave_axi4;
		Ifc_i2c_axi4#(`paddr, ELEN, 0) i2c <- mki2c_axi4(curr_clk, curr_reset);
		Ifc_gpio_axi4#(`paddr, ELEN, 0, 16) gpio <- mkgpio_axi4;
		Ifc_plic_axi4#(`paddr, ELEN, 0, 26, 2, 0) plic <-mkplic_axi4(`PLICBase);

    // -------------------------------- JTAG + Debugger Setup ---------------------------------- //
    // null crossing registers to transfer input signals from current_domain to tck domain
    CrossingReg#(Bit#(1)) tdi<-mkNullCrossingReg(tck_clk,0);                                        
    CrossingReg#(Bit#(1)) tms<-mkNullCrossingReg(tck_clk,0);                                        
    // null crossing registers to transfer signals from tck to curr_clock domain.
    CrossingReg#(Bit#(1)) tdo<-mkNullCrossingReg(curr_clk,0,clocked_by tck_clk, reset_by trst);     
                                                                                                    
    Ifc_jtagdtm jtag_tap <- mkjtagdtm(clocked_by tck_clk, reset_by trst);                           
    Ifc_riscvDebug013 debug_module <- mkriscvDebug013();                                           

    // synFIFOs to transact data between JTAG and debug module                                                                                                    
    SyncFIFOIfc#(Bit#(41)) sync_request_to_dm <-mkSyncFIFOToCC(1,tck_clk,trst);                     
    SyncFIFOIfc#(Bit#(34)) sync_response_from_dm <-mkSyncFIFOFromCC(1,tck_clk);                     
                           
		Wire#(Bit#(8)) wr_external_interrupts <- mkDWire('d0);
             // ----------- Connect JTAG IOs through null-crossing registers ------ //
    rule assign_jtag_inputs;                                                                                
      jtag_tap.tms_i(tms.crossed);                                                                  
      jtag_tap.tdi_i(tdi.crossed);                                                                  
      jtag_tap.bs_chain_i(0);                                                                       
      jtag_tap.debug_tdi_i(0);                                                                      
    endrule                                                                                         
                                                                                                    
    rule assign_jtag_output;                                                                                 
      tdo <= jtag_tap.tdo(); //  Launched by a register clocked by inverted tck                     
    endrule                                                                                        
            // ------------------------------------------------------------------- //

    // capture jtag tap request into a syncfifo first.                                                                                                                  
    rule connect_tap_request_to_syncfifo;                                                           
      let x<-jtag_tap.request_to_dm;                                                                
      sync_request_to_dm.enq(zeroExtend(x));          

    // send captured synced jtag tap request to the debug module
    endrule                                                                                         
    rule read_synced_request_to_dm;                                                                 
      sync_request_to_dm.deq;                                                                       
      debug_module.dtm.putCommand.put(sync_request_to_dm.first);                                    
    endrule                                                                                         

    // collect debug response into a syncfifo
    rule connect_debug_response_to_syncfifo;                                                        
      let x <- debug_module.dtm.getResponse.get;                                                    
      sync_response_from_dm.enq(x);          
    endrule                                  

    // send synced debug response back to the JTAG
    rule read_synced_response_from_dm;                                                              
      sync_response_from_dm.deq;                                                                    
      jtag_tap.response_from_dm(sync_response_from_dm.first);                                       
    endrule                                                                                         
    
		//Rule to connect PLIC interrupt to the core's sideband
		rule rl_core_plic_connection;
			let {lv_plic_intr, x}<- plic.intrpt_note_sb.get;
			cclass.sb_externalinterrupt.put(pack(lv_plic_intr));
		endrule

		//Rule to connect interrupts from various sources to PLIC
		rule rl_connect_plic_connections;
			let tmp<- gpio.sb_gpio_to_plic.get;
			Bit#(16) lv_gpio_intr= pack(tmp);
			Bit#(26) plic_inputs= {1'b0, i2c.isint, lv_gpio_intr, wr_external_interrupts};
			plic.ifc_external_irq_io(plic_inputs);
		endrule


    mkConnection (cclass.debug_server ,debug_module.hart);
      
    // ------------------------------------------------------------------------------------------//
    mkConnection(debug_module.debug_master,fabric.v_from_masters[`Debug_master_num]);
   	mkConnection(cclass.master_d,	fabric.v_from_masters[`Mem_master_num]);
   	mkConnection(cclass.master_i, fabric.v_from_masters[`Fetch_master_num]);
  	mkConnection(cclass.master_io, fabric.v_from_masters[`IO_master_num]);

 	  mkConnection (fabric.v_to_slaves [`Uart_slave_num ],uart.slave);
  	mkConnection (fabric.v_to_slaves [`Clint_slave_num ],clint.slave);
    mkConnection (fabric.v_to_slaves [`Err_slave_num ] , err_slave.slave);
    mkConnection (fabric.v_to_slaves [`Debug_slave_num ] , debug_memory.slave);
   	mkConnection (fabric.v_to_slaves [`I2C_slave_num ],		i2c.slave);
		mkConnection (fabric.v_to_slaves [`PLIC_slave_num ], plic.slave);
		mkConnection (fabric.v_to_slaves [`GPIO_slave_num ], gpio.slave);

    // sideband connection
    mkConnection(cclass.sb_clint_msip,clint.sb_clint_msip);
    mkConnection(cclass.sb_clint_mtip,clint.sb_clint_mtip);
    mkConnection(cclass.sb_clint_mtime,clint.sb_clint_mtime);

    interface uart_io=uart.io;

      // ------------- JTAG IOs ----------------------//
    method Action wire_tms(Bit#(1)tms_in);                                                        
      tms <= tms_in;                                                                              
    endmethod                    

    method Action wire_tdi(Bit#(1)tdi_in);                                                        
      tdi <= tdi_in;                                                                              
    endmethod                                                                                     

    method Bit#(1)wire_tdo;                                                                       
      return tdo.crossed();                                                                       
    endmethod

      // -------------------------------------------- //
    interface mem_master = fabric.v_to_slaves[`Memory_slave_num];

		method I2C_out i2c_out= i2c.io;

		method Action interrupts(Bit#(8) inp);
			wr_external_interrupts<= inp;
		endmethod

    interface gpio_io= gpio.io;
  endmodule: mkSoc
endpackage: Soc
