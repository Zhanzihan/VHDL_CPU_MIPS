library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bit32way2mux is
    port (
        d0, d1: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel: in STD_LOGIC;
        output: out STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
end entity bit32way2mux;

architecture rtl of bit32way2mux is
    
begin
    output <= d1 when sel='1' else d0;
end architecture rtl;

