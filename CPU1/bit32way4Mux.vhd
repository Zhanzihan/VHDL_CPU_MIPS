library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bit32way4Mux is
    port (
        s: in STD_LOGIC_VECTOR(1 DOWNTO 0);
        a, b, c, d: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity bit32way4Mux;

architecture rtl of bit32way4Mux is
    
begin
    process
    begin
        if(s="00") then
            output <= a;
        elsif(s="01") then
            output <= b;
        elsif(s="10") then
            output <= c;
        elsif(s="11") then
            output <= d;
        end if;
    end process;
end architecture rtl;