library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity left_shift2bit is
    port (
        input: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        ouput: out STD_LOGIC_VECTOR(31 DOWNTO 0)''
    );
end entity left_shift2bit;

architecture rtl of left_shift2bit is
    
begin
    output <= input(29 DOWNTO 0) & "00";    
end architecture rtl;