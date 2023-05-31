library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg is
    port (
        clk, rst: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity reg;

architecture rtl of reg is

begin
    process(clk, rst) 
    begin
        if(rst = '1') then
            output <= x"00000000";
        elsif(rising_edge(clk)) then
            output <= input;
        end if;
    end process; 
end architecture rtl;