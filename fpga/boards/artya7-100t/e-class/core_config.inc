ISA=RV64IMAC
MUL=fpga
SYNTH=FPGA
VERBOSITY=0
USERTRAPS=enable
USER=enable
COREFABRIC=AXI4
MULSTAGES=6
DIVSTAGES=64
PADDR=32
RESETPC=16
ARITHTRAP=disable

CAUSESIZE=6
DEBUG=enable
OPENOCD=disable

# Verilator options
COVERAGE=none
TRACE=disable
THREADS=1
VERILATESIM=fast

# DebugOptions
RTLDUMP=disable
ASSERTIONS=disable

# Trigger Setup
TRIGGERS=2

# performance counters
COUNTERS=4

# pmp
PMP=enable
PMPSIZE=4

# For Vivado Synthesis
FPGA=xc7a100tcsg324-1
SYNTHTOP=fpga_top
JOBS=4