onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_tg_top_2d/dut/clk
add wave -noupdate -format Logic /tb_tg_top_2d/dut/rst
add wave -noupdate -format Literal -radix hexadecimal /tb_tg_top_2d/dut/in_tg
add wave -noupdate -format Literal -radix hexadecimal /tb_tg_top_2d/dut/out_tg
add wave -noupdate -format Literal -radix decimal -expand /tb_tg_top_2d/dut/tg_logic/input
add wave -noupdate -format Literal -radix decimal -expand /tb_tg_top_2d/dut/tg_logic/output
add wave -noupdate -format Literal -radix hexadecimal -expand /tb_tg_top_2d/dut/tg_res
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/clk
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/rst
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/input
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/output
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/my
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hy
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__0/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/fsm_state
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/clk
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/rst
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/input
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/output
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/my
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hy
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__1/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/fsm_state
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/clk
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/rst
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/input
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/output
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/my
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hy
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/cycle_s3__2/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/fsm_state
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/clk
add wave -noupdate -format Logic -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/rst
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/input
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/output
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/my
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/mz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hx
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hy
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/hz
add wave -noupdate -format Literal -radix decimal /tb_tg_top_2d/dut/tg_mem/cycle_s1_mem__0/cycle_s2_mem__0/tg_mem/fsm_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
configure wave -namecolwidth 425
configure wave -valuecolwidth 171
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
WaveRestoreZoom {0 ns} {147 ns}
