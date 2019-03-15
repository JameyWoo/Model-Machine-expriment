library ieee;
use ieee.std_logic_1164.all;

entity tube is
port( 
	a: in std_logic_vector(6 downto 0);
	ao: out std_logic_vector(6 downto 0);
	bit1: out std_logic
	);
end tube;

architecture solve of tube is
begin
	ao <= a;
	bit1 <= '0';
end solve;