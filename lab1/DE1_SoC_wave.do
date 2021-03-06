onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX1
add wave -noupdate /DE1_SoC_testbench/HEX2
add wave -noupdate /DE1_SoC_testbench/HEX3
add wave -noupdate /DE1_SoC_testbench/HEX4
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate {/DE1_SoC_testbench/GPIO_0[1]}
add wave -noupdate {/DE1_SoC_testbench/GPIO_0[0]}
add wave -noupdate {/DE1_SoC_testbench/KEY[1]}
add wave -noupdate {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate {/DE1_SoC_testbench/SW[0]}
add wave -noupdate /DE1_SoC_testbench/clk
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/counter_out
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/digit0
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/digit1
add wave -noupdate /DE1_SoC_testbench/dut/exit
add wave -noupdate /DE1_SoC_testbench/dut/enter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {237 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1276 ps}
