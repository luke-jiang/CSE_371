
vlib work


vlog "./circuit3.sv"
vlog "./fifo.sv"
vlog "./fifo_ctrl.sv"
vlog "./reg_file.sv"


vsim -voptargs="+acc" -t 1ps -lib work circuit3_testbench

do circuit3_wave.do


view wave
view structure
view signals


run -all
