library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signExtend is
    port (
        input: in std_logic_vector(15 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of signExtend is
    
begin
    process
    begin
        if(input(15) = '1') then
            output <= x"FFFF" & input;
        else
            output <= x"0000" & input;
        end if;
    end process;
end architecture rtl;