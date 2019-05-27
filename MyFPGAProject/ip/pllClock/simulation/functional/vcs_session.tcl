gui_open_window Wave
gui_sg_create pllClock_group
gui_list_add_group -id Wave.1 {pllClock_group}
gui_sg_addsignal -group pllClock_group {pllClock_tb.test_phase}
gui_set_radix -radix {ascii} -signals {pllClock_tb.test_phase}
gui_sg_addsignal -group pllClock_group {{Input_clocks}} -divider
gui_sg_addsignal -group pllClock_group {pllClock_tb.CLK_IN1}
gui_sg_addsignal -group pllClock_group {{Output_clocks}} -divider
gui_sg_addsignal -group pllClock_group {pllClock_tb.dut.clk}
gui_list_expand -id Wave.1 pllClock_tb.dut.clk
gui_sg_addsignal -group pllClock_group {{Status_control}} -divider
gui_sg_addsignal -group pllClock_group {pllClock_tb.RESET}
gui_sg_addsignal -group pllClock_group {pllClock_tb.LOCKED}
gui_sg_addsignal -group pllClock_group {{Counters}} -divider
gui_sg_addsignal -group pllClock_group {pllClock_tb.COUNT}
gui_sg_addsignal -group pllClock_group {pllClock_tb.dut.counter}
gui_list_expand -id Wave.1 pllClock_tb.dut.counter
gui_zoom -window Wave.1 -full
