# Create work library
vlib work


vlog "./line_drawer.sv"


vsim -voptargs="+acc" -t 1ps -lib work line_drawer_testbench


do line_drawer_wave.do


view wave
view structure
view signals


run -all

