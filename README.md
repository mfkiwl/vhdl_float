# vhdl_float
simple floating point library for synthesis in fpga coded in object oriented style
currently in progress and not yet tested with fpga

Goal is to simulate a low pass filter with floating point calculation.

Also includes float to real and real to float conversion functions for simple constant assignment like

float_number <= to_float(3.14);


run all test benches with vunit+ghdl+gtkwave using

python vunit_run_float.py -p 8 --gtkwave-fmt ghw
