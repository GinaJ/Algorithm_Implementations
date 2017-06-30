onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_tg_top_2d/dut/clk
add wave -noupdate -format Logic /tb_tg_top_2d/dut/rst
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/in_tg
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/out_tg
add wave -noupdate -format Literal -radix decimal -expand /tb_tg_top_2d/dut/input
add wave -noupdate -format Literal -radix decimal -expand /tb_tg_top_2d/dut/output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12 ns} 0}
configure wave -namecolwidth 292
configure wave -valuecolwidth 222
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {7 ns} {25 ns}
