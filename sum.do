onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_tg_top_2d/dut/tg_logic/clk
add wave -noupdate -format Logic /tb_tg_top_2d/dut/tg_logic/rst
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_logic/in_tg
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_logic/out_tg
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_logic/input
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_logic/output
add wave -noupdate -format Logic /tb_tg_top_2d/dut/tg_sum/clk
add wave -noupdate -format Logic /tb_tg_top_2d/dut/tg_sum/rst
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/input
add wave -noupdate -format Logic /tb_tg_top_2d/dut/tg_sum/finished
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/output_hx
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/output_hy
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/output_hz
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/hx
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/hy
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/hz
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/fsm_state
add wave -noupdate -format Literal /tb_tg_top_2d/dut/tg_sum/tg_input
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {10887 ns}
