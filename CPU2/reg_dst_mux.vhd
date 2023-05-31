library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_dst_mux is
    port (
        d0, d1: in STD_LOGIC_VECTOR(4 DOWNTO 0);
        sel: in STD_LOGIC;
        output: out STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
end entity reg_dst_mux;

architecture rtl of reg_dst_mux is
    
begin
    output <= d0 when sel = '0' else d1;
end architecture rtl;