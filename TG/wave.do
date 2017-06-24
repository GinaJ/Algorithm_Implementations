onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_tg_cell/clock
add wave -noupdate -format Logic /tb_tg_cell/reset
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/input
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/output
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/mx
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/my
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/mz
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgxx
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgxy
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgxz
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgyx
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgyy
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgyz
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgzx
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgzy
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/tgzz
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/op1
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/op2
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/hx
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/hy
add wave -noupdate -format Literal -radix decimal /tb_tg_cell/dut/hz
add wave -noupdate -format Literal /tb_tg_cell/dut/fsm_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19000 ps} 0}
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
WaveRestoreZoom {0 ps} {210 ns}
