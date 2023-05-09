library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--8 bits register
-- if rising_edge(clk) and ld == 1 then q <= d
-- else q stay the same
entity REG is
    port (
        CLK: in std_logic;
        CLR: in std_logic; --async
        LD: in std_logic;
        D: in std_logic_vector(31 downto 0);
        Q: out std_logic_vector(31 downto 0)
    );
end entity REG;

architecture rtl of REG is
    
begin
    process(CLK)
    begin
        if(CLR = '1') then
            q <= x"00000000";
        elsif(rising_edge(CLK)) then
            if(LD = '1') then
                Q <= D;
            end if;
        end if;
    end process;
end architecture;