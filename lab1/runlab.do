# Create work library
vlib work


# vlog "./DE1_SoC.sv"
# vlog "./counter25.sv"
# vlog "./getMotion.sv"
vlog "./seg7.sv"

# vsim -voptargs="+acc" -t 1ps -lib work getMotion_testbench
# do getMotion_wave.do


# vsim -voptargs="+acc" -t 1ps -lib work counter25_testbench
# do counter25_wave.do

vsim -voptargs="+acc" -t 1ps -lib work seg7_testbench
do seg7_wave.do

view wave
view structure
view signals


run -all


