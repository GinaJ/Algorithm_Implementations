onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_fir/clock
add wave -noupdate -format Logic /tb_fir/reset
add wave -noupdate -format Literal -radix decimal /tb_fir/fir_constants_value/fir_array
add wave -noupdate -format Literal -radix decimal /tb_fir/input_x
add wave -noupdate -format Literal -radix decimal /tb_fir/fir_res
add wave -noupdate -format Logic /tb_fir/fir_constants_value/rst
add wave -noupdate -format Logic /tb_fir/fir_0/clk
add wave -noupdate -format Logic /tb_fir/fir_0/rst
add wave -noupdate -format Literal -radix decimal /tb_fir/fir_0/in_x
add wave -noupdate -format Literal -radix decimal /tb_fir/fir_0/out_fir
add wave -noupdate -format Literal -radix decimal -expand /tb_fir/fir_0/x_input
add wave -noupdate -format Literal -radix decimal -expand /tb_fir/fir_0/m_res
add wave -noupdate -format Literal -radix decimal -expand /tb_fir/fir_0/a_res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38123730 fs} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 170
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
WaveRestoreZoom {0 fs} {195091280 fs}
