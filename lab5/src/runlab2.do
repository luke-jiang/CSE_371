
vlib work


vlog "./circuit2.sv"
vlog "./fifo.sv"
vlog "./fifo_ctrl.sv"
vlog "./reg_file.sv"


vsim -voptargs="+acc" -t 1ps -lib work circuit2_testbench

do circuit2_wave.do


view wave
view structure
view signals


run -all
