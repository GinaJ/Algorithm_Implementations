onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_dct8/clock
add wave -noupdate -format Logic /tb_dct8/reset
add wave -noupdate -format Literal /tb_dct8/x_vector
add wave -noupdate -format Literal /tb_dct8/dct_res
add wave -noupdate -format Logic /tb_dct8/dct_0/clk
add wave -noupdate -format Logic /tb_dct8/dct_0/rst
add wave -noupdate -format Literal -radix hexadecimal /tb_dct8/dct_0/in_x
add wave -noupdate -format Literal -radix hexadecimal /tb_dct8/dct_0/out_dct
add wave -noupdate -format Literal -radix decimal -expand /tb_dct8/dct_0/stage
add wave -noupdate -format Literal /tb_dct8/dct_0/cout
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
WaveRestoreZoom {10 ns} {210 ns}
