library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
    port (
        clk, we, clr: in STD_LOGIC;
        addr, wd: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        rd: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity memory;

architecture rtl of memory is
    
begin
    process(clk, clr)
    begin
        if(clr = '1') then

        elsif(rising_edge(clk)) then
            
        end if;
    end process;
    
end architecture rtl;

