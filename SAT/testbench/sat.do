onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_sat/clock
add wave -noupdate -format Logic /tb_sat/reset
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/data_out
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/data_sum_out
add wave -noupdate -format Logic -radix hexadecimal /tb_sat/sat_0/clk
add wave -noupdate -format Logic -radix hexadecimal /tb_sat/sat_0/rst
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/sat_0/in_a
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/sat_0/out_a
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/sat_0/aout
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/sat_0/apipe
add wave -noupdate -format Literal -radix hexadecimal /tb_sat/sat_output/din
add wave -noupdate -color Cyan -format Literal -radix hexadecimal -expand /tb_sat/sat_output/a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29920 ps} 0}
configure wave -namecolwidth 215
configure wave -valuecolwidth 304
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
configure wave -timelineunits ps
update
WaveRestoreZoom {47250 ps} {85430 ps}
