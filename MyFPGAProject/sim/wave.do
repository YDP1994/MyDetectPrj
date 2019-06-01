onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/rst_n
add wave -noupdate /tb_top/addata
add wave -noupdate /tb_top/key_in
add wave -noupdate /tb_top/e_rxc
add wave -noupdate /tb_top/daclk
add wave -noupdate /tb_top/dadata
add wave -noupdate /tb_top/adclk
add wave -noupdate /tb_top/enADC
add wave -noupdate /tb_top/temp_led
add wave -noupdate /tb_top/e_reset
add wave -noupdate /tb_top/e_mdc
add wave -noupdate /tb_top/e_gtxc
add wave -noupdate /tb_top/e_txen
add wave -noupdate /tb_top/e_txer
add wave -noupdate /tb_top/e_txd
add wave -noupdate /tb_top/enTx
add wave -noupdate /tb_top/overTx
add wave -noupdate /tb_top/enRe
add wave -noupdate /tb_top/overRe
add wave -noupdate /tb_top/beginSignal
add wave -noupdate /tb_top/clk_32
add wave -noupdate /tb_top/clk_50
add wave -noupdate /tb_top/clk_100
add wave -noupdate /tb_top/fifo_data_count
add wave -noupdate /tb_top/fifo_rst
add wave -noupdate /tb_top/counter_for_rst
add wave -noupdate /tb_top/rst_flag
add wave -noupdate /tb_top/overRST
add wave -noupdate /tb_top/key_state
add wave -noupdate /tb_top/current_state
add wave -noupdate /tb_top/next_state
add wave -noupdate /tb_top/e_mdio
add wave -noupdate /glbl/GSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {15751050 ns}
