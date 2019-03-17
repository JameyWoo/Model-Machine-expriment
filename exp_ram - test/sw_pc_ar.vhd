library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity sw_pc_ar is
port(CLK_cdu,pcclr,pcld,pcen:in std_logic;
	sw_bus,pc_bus,ldar:      in std_logic;
	inputed:in     std_logic_vector(7 downto 0);
	arout: out    std_logic_vector(7 downto 0);
	d    :inout   std_logic_vector(7 downto 0));
end sw_pc_ar;
architecture rtl of sw_pc_ar is
signal pc,ar,bus_reg:std_logic_vector(7 downto 0);
begin
process(CLK_cdu,ldar,bus_reg)
begin
  if CLK_cdu'event and CLK_cdu='1' then
   if ldar='1' then  ar<=bus_reg;
   end if;
  end if;
end process;
process(CLK_cdu,pcclr,pcld,pcen,bus_reg)
begin
  if pcclr='0' then pc<= (others=>'0');
  elsif CLK_cdu'event and CLK_cdu='1' then
   if(pcld='0' and pcen='1') then pc<=bus_reg;
   elsif(pcld='1' and pcen='1') then pc<=pc+1;
   end if;
  end if;
end process;
bus_reg<=inputed when (sw_bus ='0' and pc_bus='1') else
	     pc when (sw_bus='1' and pc_bus='0') else 
	     d;
d<=bus_reg when (sw_bus='0' or pc_bus='0') else 
   (others =>'Z');
   arout<=ar;
end rtl;