library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    port (
        input: in STD_LOGIC_VECTOR(15 DOWNTO 0);
        output: out STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
end entity sign_extend;

architecture rtl of sign_extend is
    
begin
    output <= x"ffff" & input(15 downto 0) when input(15)='1' else x"0000" & input(15 downto 0);  
end architecture rtl;

