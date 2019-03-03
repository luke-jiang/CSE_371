onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bitcounter_testbench/clk
add wave -noupdate /bitcounter_testbench/reset
add wave -noupdate /bitcounter_testbench/start
add wave -noupdate /bitcounter_testbench/A
add wave -noupdate /bitcounter_testbench/result
add wave -noupdate /bitcounter_testbench/done
add wave -noupdate /bitcounter_testbench/dut/C/Ar
add wave -noupdate /bitcounter_testbench/dut/C/incr_result
add wave -noupdate /bitcounter_testbench/dut/C/rshift_A
add wave -noupdate /bitcounter_testbench/dut/C/init_result
add wave -noupdate /bitcounter_testbench/dut/C/init_A
add wave -noupdate /bitcounter_testbench/dut/C/ps
add wave -noupdate /bitcounter_testbench/dut/C/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {87 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
