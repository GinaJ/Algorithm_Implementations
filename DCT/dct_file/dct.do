onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_dct/clock
add wave -noupdate -format Logic /tb_dct/reset
add wave -noupdate -format Literal /tb_dct/dct_cosine_matrix
add wave -noupdate -format Literal /tb_dct/x_vector
add wave -noupdate -format Literal /tb_dct/dct_res
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/in_x
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/in_dct
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/out_dct
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/x_input
add wave -noupdate -color Pink -format Literal -radix hexadecimal -expand /tb_dct/dct_0/a
add wave -noupdate -format Literal -radix hexadecimal -expand /tb_dct/dct_0/pip_dct_out
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/pip_out
add wave -noupdate -format Literal -radix hexadecimal -expand /tb_dct/dct_0/mult_res
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/mult0_res
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/add_res
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/cout
add wave -noupdate -format Literal -radix hexadecimal /tb_dct/dct_0/zeros
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/a
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/b
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/res
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/out_mux
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/out_sum
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/newb
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/a_ext
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/zeros
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/cout
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/tmp_a
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/tmp_a_neg
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/tmp_a_double
add wave -noupdate -format Literal /tb_dct/dct_0/cycle0_mult__0/mult0/tmp_a_neg_double
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {236880 ps} 0}
configure wave -namecolwidth 325
configure wave -valuecolwidth 335
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
WaveRestoreZoom {206880 ps} {288010 ps}
