library iEEE;
use IEEE.std_logic_1164.all;
entity exp_bus is
port(  Clk: in STD_LOGIC;
		sw_bus,r1_bus,r2_bus,r3_bus:in STD_LOGIC;
		k : in STD_LOGIC_VECTOR(7 downto 0);
		lddr : in STD_LOGIC_VECTOR(3 downto 0);
		l : inout STD_LOGIC_VECTOR(7 downto 0);
		r1_out, r3_out: out std_logic_vector(7 downto 0);
		-- r1_out, r2_out, r3_out: out std_logic_vector(7 downto 0);
		bus_out: out std_logic_vector(7 downto 0)
		);
end exp_bus;

architecture rtl of exp_bus is 
signal r1,r2,r3,bus_Reg: STD_LOGIC_VECTOR(7 downto 0);
begin
ldreg:process(Clk, lddr,bus_Reg)
		begin
		if CLK'event and Clk = '1' then 
			if lddr(1) = '1' then r1 <= bus_Reg;
			elsif lddr(2)  = '1' then r2 <= bus_Reg;
			elsif lddr(3)  = '1' then r3 <= bus_Reg;
			end if;
		end if;
		end process;
		
bus_Reg <=k when(sw_bus = '0' and r1_bus = '1' and r2_bus = '1' and r3_bus = '1') else 
		r1 when(sw_bus = '1' and r1_bus = '0' and r2_bus = '1' and r3_bus = '1') else 
		r2 when(sw_bus = '1' and r1_bus = '1' and r2_bus = '0' and r3_bus = '1') else 
		r3 when(sw_bus = '1' and r1_bus = '1' and r2_bus = '1' and r3_bus = '0') else 
		(others => '0');
		l <= bus_Reg when (sw_bus = '0' or r1_bus = '0' or r2_bus = '0' or r3_bus = '0') else 
		(others => 'Z');
		bus_out <= bus_Reg;
		r1_out <= r1;
		-- r2_out <= r2;
		r3_out <= r3;
		end rtl; 