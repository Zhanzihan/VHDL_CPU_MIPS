library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signExtend is
    port (
        input: in STD_LOGIC_VECTOR(15 downto 0);
        en: in STD_LOGIC;
        output: out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture rtl of signExtend is
    
begin
    process
    begin
        if(en='1') then
            if(input(15) = '1') then
                output <= x"FFFF" & input;
            else
                output <= x"0000" & input;
            end if;
        end if;
    end process;
end architecture rtl;