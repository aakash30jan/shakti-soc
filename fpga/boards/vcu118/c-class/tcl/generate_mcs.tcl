set curdir [ file dirname [ file normalize [ info script ] ] ]
source $curdir/env.tcl

set jobs [lindex $argv 0]
open_project $core_project_dir/$core_project.xpr

set top_module [get_property TOP [get_filesets sources_1]]

set bit $core_project_dir/$core_project.runs/core_impl_1/$top_module.bit
set mcs $core_project_dir/$top_module.mcs
set bitload "up 0x00000000 $bit"

puts "BITSTREAM: $bit  MCS: $mcs"
write_cfgmem  -format mcs -size 256 -interface SPIx8 -loadbit $bitload  -force -file $mcs;
#  write_cfgmem  -format mcs -size 128 -interface BPIx16 -loadbit {up 0x00000000
#  "/scratch/neel/saferv/vcu118mig/minimal/fpga_project/c-class/c-class.runs/core_impl_1/fpga_top.bit"
#  } -force

puts "MCS Generated !"
exit
