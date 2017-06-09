onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /tb_tep/tep_top0/in_tep
add wave -noupdate -format Literal /tb_tep/tep_top0/out_tep
add wave -noupdate -format Literal -radix decimal -expand /tb_tep/tep_top0/cell
add wave -noupdate -format Literal -radix decimal -expand /tb_tep/tep_top0/res
add wave -noupdate -format Literal /tb_tep/tep_top0/zero
add wave -noupdate -format Literal -radix decimal /tb_tep/tep_top0/alpha
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17 ns} 0}
configure wave -namecolwidth 264
configure wave -valuecolwidth 157
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
WaveRestoreZoom {5 ns} {93 ns}
