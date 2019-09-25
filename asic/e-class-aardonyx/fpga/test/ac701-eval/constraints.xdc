create_clock -period 60.000 -name tck -waveform {0.000 30.000} -add [get_nets pin_tck]

set_multicycle_path -setup 4 -from [get_clocks tck] -to [get_clocks clk_out1_clk_divider] -end
set_multicycle_path -hold 3 -from [get_clocks tck] -to [get_clocks clk_out1_clk_divider] -end

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets sys_clk_IBUF]

#SYSCLK
set_property PACKAGE_PIN R3 [get_ports sys_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports sys_clk_p]
set_property PACKAGE_PIN P3 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports sys_clk_n]

#RESET -----------------------------------------------------------------------
set_property PACKAGE_PIN U4 [get_ports sys_rst]
set_property IOSTANDARD LVCMOS15 [get_ports sys_rst]

#UART ------------------------------------------------------------------------
set_property PACKAGE_PIN T19 [get_ports uart0_SIN]
set_property IOSTANDARD LVCMOS18 [get_ports uart0_SIN]
set_property PACKAGE_PIN U19 [get_ports uart0_SOUT]
set_property IOSTANDARD LVCMOS18 [get_ports uart0_SOUT]

#JTAG Connections-------------------------------------------------------------
set_property PACKAGE_PIN T23 [get_ports pin_tdi]
set_property IOSTANDARD LVCMOS33 [get_ports pin_tdi]

set_property PACKAGE_PIN R22 [get_ports pin_tdo]
set_property IOSTANDARD LVCMOS33 [get_ports pin_tdo]


set_property PACKAGE_PIN T22 [get_ports pin_tck]
set_property IOSTANDARD LVCMOS33 [get_ports pin_tck]

set_property PACKAGE_PIN P26 [get_ports pin_tms]
set_property IOSTANDARD LVCMOS33 [get_ports pin_tms]
set_property PULLUP true [get_ports pin_tms]

set_property PACKAGE_PIN H17 [get_ports pin_trst]
set_property IOSTANDARD LVCMOS25 [get_ports pin_trst]
set_property PULLDOWN true [get_ports pin_trst]

### SDRAM FMC constraints ---------------------------------------------------- 
set_property PACKAGE_PIN E23 [get_ports {sdram_dq[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[0]}]

#SDRAM_DQ0   c26   LA27_N

set_property PACKAGE_PIN F23 [get_ports {sdram_dq[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[1]}]

#SDRAM_DQ1   c27   LA27_P

set_property PACKAGE_PIN Y17 [get_ports {sdram_dq[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[2]}]

#SDRAM_DQ2   E18   HA20_N

set_property PACKAGE_PIN Y16 [get_ports {sdram_dq[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[3]}]

#SDRAM_DQ3   E19   HA20_P

set_property PACKAGE_PIN AF17 [get_ports {sdram_dq[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[4]}]

#SDRAM_DQ4   E16   HA16_N

set_property PACKAGE_PIN D16 [get_ports {sdram_dq[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[5]}]

#SDRAM_DQ5   D15   LA09_N

set_property PACKAGE_PIN L14 [get_ports {sdram_dq[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[6]}]

#SDRAM_DQ6   H23   LA19_N

set_property PACKAGE_PIN M14 [get_ports {sdram_dq[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[7]}]

#SDRAM_DQ7   H22   LA19_P

set_property PACKAGE_PIN E21 [get_ports {sdram_dq[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[8]}]

#SDRAM_DQ8   G18   LA16_P

set_property PACKAGE_PIN B22 [get_ports {sdram_dq[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[9]}]

#SDRAM_DQ9   H19   LA15_P

set_property PACKAGE_PIN Y18 [get_ports {sdram_dq[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[10]}]

#SDRAM_DQ10  F16   HA15_P

set_property PACKAGE_PIN D20 [get_ports {sdram_dq[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[11]}]

#SDRAM_DQ11  G16   LA12_N

set_property PACKAGE_PIN A19 [get_ports {sdram_dq[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[12]}]

#setDRAM_DQ12  H17   LA11_N

set_property PACKAGE_PIN B19 [get_ports {sdram_dq[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[13]}]

#SDRAM_DQ13  H16   LA11_P

set_property PACKAGE_PIN E20 [get_ports {sdram_dq[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[14]}]

#SDRAM_DQ14  G15   LA12_P

set_property PACKAGE_PIN G16 [get_ports {sdram_dq[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[15]}]
#SDRAM_DQ15  H14   LA07_N

set_property PACKAGE_PIN AF20 [get_ports {sdram_dq[16]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[16]}]
#SDRAM_DQ16  E10   HA09_N

set_property PACKAGE_PIN AF19 [get_ports {sdram_dq[17]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[17]}]
#SDRAM_DQ17  E9    HA09_P

set_property PACKAGE_PIN G17 [get_ports {sdram_dq[18]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[18]}]
#SDRAM_DQ18  G9    LA03_P

set_property PACKAGE_PIN AF25 [get_ports {sdram_dq[19]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[19]}]
#SDRAM_DQ19  F8    HA04_N

set_property PACKAGE_PIN H15 [get_ports {sdram_dq[20]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[20]}]
#SDRAM_DQ20  H8    LA02_N

set_property PACKAGE_PIN AF24 [get_ports {sdram_dq[21]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[21]}]
#SDRAM_DQ21  F7    HA04_P

set_property PACKAGE_PIN C18 [get_ports {sdram_dq[22]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[22]}]
#SDRAM_DQ22  G7    LA00_N_CC

set_property PACKAGE_PIN H14 [get_ports {sdram_dq[23]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[23]}]
#SDRAM_DQ23  H7    LA02_P

set_property PACKAGE_PIN H22 [get_ports {sdram_dq[24]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[24]}]
#SDRAM_DQ24  G3    CLK1_M2C_N

set_property PACKAGE_PIN AB19 [get_ports {sdram_dq[25]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[25]}]
#SDRAM_DQ25  F5    HA00_N_CC

set_property PACKAGE_PIN AA19 [get_ports {sdram_dq[26]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[26]}]
#SDRAM_DQ26  F4    HA00_P_CC

set_property PACKAGE_PIN H21 [get_ports {sdram_dq[27]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[27]}]
#SDRAM_DQ27  G2    CLK1_M2C_P

set_property PACKAGE_PIN AD25 [get_ports {sdram_dq[28]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[28]}]
#SDRAM_DQ28  E6    HA05_P

set_property PACKAGE_PIN AC21 [get_ports {sdram_dq[29]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[29]}]
#SDRAM_DQ29  E3    HA01_N_CC

set_property PACKAGE_PIN AB21 [get_ports {sdram_dq[30]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[30]}]
#SDRAM_DQ30  E2    HA01_P_CC

set_property PACKAGE_PIN AD21 [get_ports {sdram_dq[31]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_dq[31]}]

#SDRAM_DQ31  F10   HA08_P

#set_property PACKAGE_PIN G26 [get_ports {sdram_dq[32]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[32]}]
##SDRAM_DQ32  H38   LA32_N

#set_property PACKAGE_PIN H26 [get_ports {sdram_dq[33]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[33]}]
##SDRAM_DQ33  H37   LA32_P

#set_property PACKAGE_PIN F25 [get_ports {sdram_dq[34]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[34]}]
##SDRAM_DQ34  G37   LA33_N

#set_property PACKAGE_PIN G25 [get_ports {sdram_dq[35]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[35]}]
##SDRAM_DQ35  G36   LA33_P

#set_property PACKAGE_PIN D25 [get_ports {sdram_dq[36]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[36]}]
##SDRAM_DQ36  H35   LA30_N

#set_property PACKAGE_PIN E25 [get_ports {sdram_dq[37]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[37]}]
##SDRAM_DQ37  H34   LA30_P

#set_property PACKAGE_PIN D26 [get_ports {sdram_dq[38]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[38]}]
##SDRAM_DQ38  G34   LA31_N

#set_property PACKAGE_PIN E26 [get_ports {sdram_dq[39]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[39]}]
##SDRAM_DQ39  G33   LA31_P

#set_property PACKAGE_PIN J18 [get_ports {sdram_dq[40]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[40]}]
##SDRAM_DQ40  H28   LA24_P

#set_property PACKAGE_PIN F22 [get_ports {sdram_dq[41]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[41]}]
##SDRAM_DQ41  G28   LA25_N

#set_property PACKAGE_PIN G22 [get_ports {sdram_dq[42]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[42]}]
##SDRAM_DQ42  G27   LA25_P

#set_property PACKAGE_PIN H19 [get_ports {sdram_dq[43]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[43]}]
##SDRAM_DQ43  H26   LA21_N

#set_property PACKAGE_PIN J19 [get_ports {sdram_dq[44]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[44]}]
##SDRAM_DQ44  H25   LA21_P

#set_property PACKAGE_PIN L18 [get_ports {sdram_dq[45]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[45]}]
##SDRAM_DQ45  G25   LA22_N

#set_property PACKAGE_PIN L17 [get_ports {sdram_dq[46]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[46]}]
##SDRAM_DQ46  G24   LA22_P

#set_property PACKAGE_PIN W15 [get_ports {sdram_dq[47]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[47]}]
##SDRAM_DQ47  K23   HA23_N

#set_property PACKAGE_PIN AB17 [get_ports {sdram_dq[48]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[48]}]
##SDRAM_DQ48  J19   HA18_N

#set_property PACKAGE_PIN AB16 [get_ports {sdram_dq[49]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[49]}]
##SDRAM_DQ49  K19   HA21_P

#set_property PACKAGE_PIN AA17 [get_ports {sdram_dq[50]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[50]}]
##SDRAM_DQ50  J18   HA18_P

#set_property PACKAGE_PIN AB20 [get_ports {sdram_dq[51]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[51]}]
##SDRAM_DQ51  K17   HA17_N_CC

#set_property PACKAGE_PIN AA20 [get_ports {sdram_dq[52]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[52]}]
##SDRAM_DQ52  K16   HA17_P_CC

#set_property PACKAGE_PIN AF18 [get_ports {sdram_dq[53]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[53]}]
##SDRAM_DQ53  J16   HA14_N

#set_property PACKAGE_PIN AE18 [get_ports {sdram_dq[54]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[54]}]
##SDRAM_DQ54  J15   HA14_P

#set_property PACKAGE_PIN AF22 [get_ports {sdram_dq[55]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[55]}]
##SDRAM_DQ55  K14   HA10_N

#set_property PACKAGE_PIN AE21 [get_ports {sdram_dq[56]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[56]}]
##SDRAM_DQ56  F11   HA08_N

#set_property PACKAGE_PIN AE23 [get_ports {sdram_dq[57]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[57]}]
##SDRAM_DQ57  K10   HA06_P

#set_property PACKAGE_PIN AD24 [get_ports {sdram_dq[58]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[58]}]
##SDRAM_DQ58  J10   HA07_N

#set_property PACKAGE_PIN AD23 [get_ports {sdram_dq[59]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[59]}]
##SDRAM_DQ59  J9    HA07_P

#set_property PACKAGE_PIN AE26 [get_ports {sdram_dq[60]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[60]}]
##SDRAM_DQ60  K8    HA02_N

#set_property PACKAGE_PIN AE25 [get_ports {sdram_dq[61]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[61]}]
##SDRAM_DQ61  K7    HA02_P

#set_property PACKAGE_PIN AC23 [get_ports {sdram_dq[62]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[62]}]
##SDRAM_DQ62  J7    HA03_N

#set_property PACKAGE_PIN AC22 [get_ports {sdram_dq[63]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_dq[63]}]
##SDRAM_DQ63  J6    HA03_P

set_property PACKAGE_PIN AE17 [get_ports {sdram_out_osdr_dqm[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_dqm[0]}]
#SDRAM_DQM0  E15   HA16_P

#set_property PACKAGE_PIN AC17 [get_ports {sdram_out_osdr_dqm[5]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_out_osdr_dqm[5]}]
##SDRAM_DQM1  F19   HA19_P

#set_property PACKAGE_PIN AD26 [get_ports {sdram_out_osdr_dqm[6]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_out_osdr_dqm[6]}]
##SDRAM_DQM2  E7    HA05_N

#set_property PACKAGE_PIN D19 [get_ports {sdram_out_osdr_dqm[7]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_out_osdr_dqm[7]}]
##SDRAM_DQM3  H4    CLK0_M2C_P

#set_property PACKAGE_PIN K23 [get_ports {sdram_out_osdr_dqm[4]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {sdram_out_osdr_dqm[4]}]
##SDRAM_DQM4  H32   LA28_N

set_property PACKAGE_PIN K22 [get_ports {sdram_out_osdr_dqm[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_dqm[1]}]
#SDRAM_DQM5  H31   LA28_P

set_property PACKAGE_PIN AF23 [get_ports {sdram_out_osdr_dqm[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_dqm[2]}]
#SDRAM_DQM6  K11   HA06_N

set_property PACKAGE_PIN F19 [get_ports {sdram_out_osdr_dqm[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_dqm[3]}]




set_property PACKAGE_PIN AA18 [get_ports {sdram_out_osdr_addr[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[0]}]
#SDRAM_A0   F17    HA15_N

set_property PACKAGE_PIN A22 [get_ports {sdram_out_osdr_addr[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[1]}]
#SDRAM_A1   H20    LA15_N

set_property PACKAGE_PIN D21 [get_ports {sdram_out_osdr_addr[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[2]}]
#SDRAM_A2   G19    LA16_N

set_property PACKAGE_PIN F24 [get_ports {sdram_out_osdr_addr[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[3]}]
#SDRAM_A3   G31    LA29_N

set_property PACKAGE_PIN G24 [get_ports {sdram_out_osdr_addr[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[4]}]
#SDRAM_A4   G30    LA29_P

set_property PACKAGE_PIN H18 [get_ports {sdram_out_osdr_addr[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[5]}]
#SDRAM_A5   H29    LA24_N

set_property PACKAGE_PIN E18 [get_ports {sdram_out_osdr_addr[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[6]}]
#SDRAM_A6   D9     LA01_N_CC

set_property PACKAGE_PIN AE22 [get_ports {sdram_out_osdr_addr[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[7]}]
#SDRAM_A7   K13    HA10_P

set_property PACKAGE_PIN E17 [get_ports {sdram_out_osdr_addr[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[8]}]
#SDRAM_A8   D8     LA01_P_CC

set_property PACKAGE_PIN D18 [get_ports {sdram_out_osdr_addr[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[9]}]
#SDRAM_A9   G6     LA00_P_CC

set_property PACKAGE_PIN C19 [get_ports {sdram_out_osdr_addr[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[10]}]
#SDRAM_A10  H5     CLK0_M2C_N

set_property PACKAGE_PIN AD20 [get_ports {sdram_out_osdr_addr[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[11]}]
#SDRAM_A11  J12    HA11_P

set_property PACKAGE_PIN M16 [get_ports {sdram_out_osdr_addr[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_addr[12]}]
#SDRAM_A12  G21    LA20_P

set_property PACKAGE_PIN AC19 [get_ports sdram_out_osdr_ras_n]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_ras_n]
#SDRAM_RAS_N  F13   HA12_P

set_property PACKAGE_PIN W14 [get_ports sdram_out_osdr_cke1]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_cke1]
#SDRAM_CKE1   K22   HA23_P

set_property PACKAGE_PIN AA15 [get_ports sdram_out_osdr_cke0]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_cke0]
#SDRAM_CKE0   J22   HA22_N

set_property PACKAGE_PIN Y15 [get_ports sdram_out_osdr_cas_n]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_cas_n]
#SDRAM_CAS_N  J21   HA22_P

set_property PACKAGE_PIN C17 [get_ports sdram_out_osdr_we_n]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_we_n]
#SDRAM_WE_N   G12   LA08_P

set_property PACKAGE_PIN AE20 [get_ports {sdram_out_osdr_ba[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_ba[0]}]
#SDRAM_BA0    J13   HA11_N

set_property PACKAGE_PIN B17 [get_ports {sdram_out_osdr_ba[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sdram_out_osdr_ba[1]}]
#SDRAM_BA1    G13   LA08_N

set_property PACKAGE_PIN F17 [get_ports sdram_out_osdr_cs_n0]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_cs_n0]
#SDRAM_CS0_N  G10   LA03_N

set_property PACKAGE_PIN F18 [get_ports sdram_out_osdr_cs_n1]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_out_osdr_cs_n1]
#SDRAM_CS1_N  H10   LA04_P

set_property PACKAGE_PIN H16 [get_ports sdram_clk]
set_property IOSTANDARD LVCMOS25 [get_ports sdram_clk]

set_input_delay 0.2 -clock clk_out1_clk_divider [get_ports [all_inputs] -filter {NAME =~ "sdram_dq[*]"}]

