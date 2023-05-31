library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bit32way4mux is
    port (
        d0, d1, d2, d3: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel: in STD_LOGIC_VECTOR(1 DOWNTO 0);
        output: out STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
end entity bit32way4mux;

architecture rtl of bit32way4mux is
    
begin
    process
    begin
        if(sel = "00") then 
            output <= d0;
        elsif(sel = "01") then
            output <= d1;
        elsif(sel = "10") then
            output <= d2;
        elsif(sel = "11") then
            output <= d3;
        end if;
    end process;
end architecture rtl;

