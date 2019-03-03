# Create work library
vlib work

vlog "./DE1_SoC.sv"
vlog "./seg7.sv"
vlog "./bitcounter.sv"


vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench


do DE1_SoC_wave.do


view wave
view structure
view signals


run -all

