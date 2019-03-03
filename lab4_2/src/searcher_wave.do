onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /searcher_testbench/clk
add wave -noupdate /searcher_testbench/reset
add wave -noupdate /searcher_testbench/start
add wave -noupdate -radix decimal /searcher_testbench/target
add wave -noupdate -radix unsigned /searcher_testbench/addr
add wave -noupdate /searcher_testbench/done
add wave -noupdate /searcher_testbench/found
add wave -noupdate -radix unsigned /searcher_testbench/dut/p1
add wave -noupdate -radix unsigned /searcher_testbench/dut/p2
add wave -noupdate -radix unsigned /searcher_testbench/dut/new_addr
add wave -noupdate -radix decimal /searcher_testbench/dut/curr_data
add wave -noupdate /searcher_testbench/dut/init_all
add wave -noupdate /searcher_testbench/dut/set_p1
add wave -noupdate /searcher_testbench/dut/set_p2
add wave -noupdate /searcher_testbench/dut/set_found
add wave -noupdate /searcher_testbench/dut/set_done
add wave -noupdate -expand -group RAM -radix unsigned /searcher_testbench/dut/RAM/q
add wave -noupdate -expand -group RAM -radix unsigned /searcher_testbench/dut/RAM/address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {473 ps} 0}
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
