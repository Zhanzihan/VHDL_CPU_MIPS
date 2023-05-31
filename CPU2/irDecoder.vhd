library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity irDecoder is
    port (
        instr: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        next_addr: out STD_LOGIC_VECTOR(7 DOWNTO 0);
    );
end entity irDecoder;

architecture rtl of irDecoder is
    
begin
    
    
end architecture rtl;