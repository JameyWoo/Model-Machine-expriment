library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity exp_r_alu is
port (
	CLK: in std_logic;
	sw_bus, r4_bus, r5_bus, alu_bus: in std_logic;
	lddr1, lddr2, ldr4, ldr5: in std_logic;
	m, cn