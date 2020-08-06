# C-Class on VCU118 Board

This repo contains the flow for porting an instance of the C-class on the [VCU118](https://www.xilinx.com/products/boards-and-kits/vcu118.html) board from Xilinx. 

## Features Available
Please see Soc.defines for the memory-map. Given below are the default configs that have been used.
* __C-class Config__:
    1. RV64IMAFDC
    2. 16KiB I-Cache and 16KiB D-cache
    3. sv39 supervisor mode supported with 4 entry I-TLB and 4 entry D-TLB
    4. 29 performance counters
* __UART__: Refer [here](https://gitlab.com/shaktiproject/uncore/devices/blob/master/uart/uart_driver.c) for more info on the uart.
* __DEBUGGER__: Connects with riscv-openocd.
* __CLINT__: Refer [here](https://gitlab.com/shaktiproject/uncore/devices/blob/master/clint/clint.defines) for more info.
* __MIG-DDR4__: 2GB accessible.
* __PLIC__: Refer [here](https://gitlab.com/shaktiproject/uncore/devices/blob/master/plic) for more info.
* __OnChipBRAM__: 64KiB

## Requirements
1. __Vivado 2017__ or above should be used
2. `vivado` command should be available in your `$PATH` variable.
3. `bsc` command should be available in your `$PATH` variable.
5. `miniterm` should be installed.

## Memory map of SoC

| Config  | base-address| bound-address|
|---------|-------------|--------------|
|Debug    | 'h0000_0000 | 'h0000_000F|
|BootRom  | 'h0000_1000 | 'h0000_1FFF|
|TCMe     | 'h1000_0000 | 'h1000_FFFF|
|DDR4     | 'h8000_0000 | 'hFFFF_FFFF|
|Uart     | 'h0001_1300 | 'h0001_1340|                                                                     
|Clint    | 'h0200_0000 | 'h020B_FFFF|                                                                     
|PLIC     | 'h020D_0000 | 'h020D_00FF|


## Quick Start (default Config) :: Get started with an VCU118 

### Building the mcs file
``` bash
cd saferv/vcu118_singlecore
make
```

### Programming the board with the mcs file

Please note you will need sudo access to perform the following op:

``` bash
cd saferv/vcu118_singlecore
make program_mcs
```
Once programming is done you will need to power-off and power-on the board for proper bring-up.

### Connecting host to board
In a new terminal window connect the uart through `miniterm`. 

Note: vcu118 uses a dual-usb-uart chip. So your host should see 2 ttyUSB ports. From experience its
always the highest numeral USB that is used by our design. You can also use a different serial comm
application with a baudrate of 115200 instead of miniterm. 

``` bash
cd saferv/vcu118_singlecore/gdb_setup/
sudo miniterm /dev/ttyUSB2 115200
```
On pressing the `cpu_reset` pin on the board the following should be prompted on the miniterm:

```bash
                                       ./((*
                                   ,(((((,
                               *((((((,
                          ./(((((((,
                      ./((((((((*
                   *(((((((((/
               .(((((((((((,
            ,((((((((((((/
          ((((((((((((((/
         .((((((((((((((/
             *(((((((((((.
                  /(((((((.
                ,.     *(((/
                    *((,     ,/.
                      ((((((/.
                       ((((((((((/
                        (((((((((((((/
                        ((((((((((((((.
                       ((((((((((((/
                     *((((((((((*
                   ((((((((((.
                /((((((((*
             *(((((((,
          *((((((.
      .(((((.
  ./(((*
  .

                    SHAKTI PROCESSORS
                    C-Class on VCU118

```

In a New Terminal window connect the openocd
``` bash
cd saferv/vcu118_singlecore/gdb_setup/
sudo ./openocd_vcu118 -f shakti-bscane.cfg
```
In yet Another Terminal window
``` bash
cd saferv/vcu118_singlecore/gdb_setup/
riscv64-unknown-elf-gdb -x gdb_script.txt
```
You can now load programs into the DDR/TCM using the gdb file/load commands.

## Running applications:
Sample tests are provided in the `tests` folder. You can run them onthe FPGA using the following
commands:

### Compiling Hello world:
``` bash
cd saferv/vcu118_singlecore/tests/benchmarks
make hello-shakti
```
In the gdb terminal do the following:
``` bash
file saferv/vcu118_singlecore/tests/benchmarks/output/hello.riscv
load
continue
```
You should see the following output on miniterm:
``` bash
Hello World from SHAKTI
```

### Compiling Dhrystone:
``` bash
cd saferv/vcu118_singlecore/tests/benchmarks
make dhrystone
```
In the gdb terminal do the following:
``` bash
file saferv/vcu118_singlecore/tests/benchmarks/output/dhry.riscv
load
continue
```
You should see the following output on miniterm:
``` bash
Microseconds for one run through Dhrystone:     10.0 
Dhrystones per Second:                       96676.0
```

### Other tests
performance counter tests can be compiled similarly:
``` bash
cd saferv/vcu118_singlecore/tests/performance_tests
make
```
The folder will have multiple `*.riscv` elfs available which can loaded through gdb similar to the
above examples
