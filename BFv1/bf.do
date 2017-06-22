onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_bf/clock
add wave -noupdate -format Logic /tb_bf/reset
add wave -noupdate -format Literal -radix decimal -expand /tb_bf/bf_values/a
add wave -noupdate -format Literal -radix decimal -expand /tb_bf/bf_0/add_res
add wave -noupdate -format Literal -radix decimal -expand /tb_bf/bf_0/final_res
add wave -noupdate -format Literal -radix decimal -expand /tb_bf/bf_0/shift_res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {66293 ps} 0}
configure wave -namecolwidth 229
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {527440 ps}
