
vlib work


vlog "./searcher.sv"
vlog "./ram32x8.v"
vlog "./DE1_SoC.sv"

vsim -voptargs=\"+acc\" -t 1ps -lib work work.searcher_testbench -Lf altera_mf_ver

do searcher_wave.do


view wave
view structure
view signals


run -all


