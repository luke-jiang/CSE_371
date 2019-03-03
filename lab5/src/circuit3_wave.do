onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /circuit3_testbench/read_ready
add wave -noupdate /circuit3_testbench/write_ready
add wave -noupdate -radix decimal /circuit3_testbench/readdata_left
add wave -noupdate -radix decimal /circuit3_testbench/readdata_right
add wave -noupdate /circuit3_testbench/clk
add wave -noupdate /circuit3_testbench/reset
add wave -noupdate /circuit3_testbench/read
add wave -noupdate /circuit3_testbench/write
add wave -noupdate -radix decimal /circuit3_testbench/writedata_left
add wave -noupdate -radix decimal /circuit3_testbench/writedata_right
add wave -noupdate /circuit3_testbench/dut/ps
add wave -noupdate /circuit3_testbench/dut/ns
add wave -noupdate /circuit3_testbench/dut/add_left
add wave -noupdate /circuit3_testbench/dut/add_right
add wave -noupdate /circuit3_testbench/dut/accum_left
add wave -noupdate /circuit3_testbench/dut/accum_right
add wave -noupdate /circuit3_testbench/dut/full
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {910 ps} 0}
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
WaveRestoreZoom {0 ps} {1889 ps}
