ISA=RV64IMAFDCSU

# User mode related settings
USERTRAPS=disable
USER=enable

# Supervisor related settings
SUPERVISOR=sv39
ITLBSIZE=4
DTLBSIZE=4
ASIDWIDTH=9

# Configuring M extension
MULSTAGES=2
DIVSTAGES=32

# Configuring the branch predictor
PREDICTOR=gshare
BPURESET=1
BTBDEPTH=32
BHTDEPTH=128
HISTLEN=8
HISTBITS=5
RASDEPTH=8

# configuring the Instruction cache
ICACHE=enable
ISETS=64
IWORDS=4
IBLOCKS=16
IWAYS=4
IFBSIZE=4
IESIZE=2
IREPL=2
IRESET=1
IDBANKS=1
ITBANKS=1
ONE_HOT_SELECT=0

# configuring the Data cache
DCACHE=enable
DESIZE=1
DSETS=64
DWORDS=8
DBLOCKS=8
DWAYS=4
DFBSIZE=8
DSBSIZE=2
DREPL=2
DRESET=1
DDBANKS=1
DTBANKS=1
D_ONE_HOT_SELECT=0

# Configuring the PMP CONFIG
PMP=enable
PMPSIZE=4
GRANULARITY=8

# Configuring Debug and Trigger Setup
TRIGGERS=0
DEBUG=enable
OPENOCD=enable
DTVEC_BASE=256

#BSV compile options
SUPPRESSWARNINGS=none

# Simulation configurations and env settings
COVERAGE=none
TRACE=disable
THREADS=1
VERILATESIM=fast
VERBOSITY=disable
RTLDUMP=disable
ASSERTIONS=disable

# miscellaneous configs
SYNTH=ASIC
ARITH_TRAP=disable
RESETPC=4096
PADDR=32
COREFABRIC=AXI4

# Do not change
CAUSESIZE=6

# Counter config for daisy-chain
CSRTYPE=daisy
CSR_LATENCY=low
COUNTERS_GRP4=7
COUNTERS_GRP5=7
COUNTERS_GRP6=7
COUNTERS_GRP7=8

# For Vivado Synthesis
FPGA=xcvu9p-flga2104-2L-e
SYNTHTOP=fpga_top
BSCAN2E=enable
JOBS=4
