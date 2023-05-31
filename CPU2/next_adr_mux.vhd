library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity next_adr_mux is
    port (
        op_next_adr: in STD_LOGIC_VECTOR(7 DOWNTO 0);
        cm_next_adr: in STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel: in STD_LOGIC;
        next_adr: out STD_LOGIC_VECTOR
    );
end entity next_adr_mux;

architecture rtl of next_adr_mux is
    
begin
    next_adr <= op_next_adr when sel = '1' else cm_next_adr;
end architecture rtl;