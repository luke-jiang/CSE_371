# Create work library
vlib work


vlog "./DE1_SoC.sv"
vlog "./RAM32x4.sv"
vlog "./seg7.sv"


# vsim -voptargs=\"+acc\" -t 1ps -lib work work.DE1_SoC_testbench -Lf altera_mf_ver
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
