library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg32 is
    port (
        we3, clk, clr: in STD_LOGIC;
        ra1, ra2, wa3: in STD_LOGIC_VECTOR(4 downto 0); --address
        wd3: in STD_LOGIC_VECTOR(31 downto 0);
        rd1, rd2: out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity reg32;

architecture rtl of reg32 is
    type reg is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal regs : reg; 
begin

    writeReg: process(clk)
    begin
        if(clr = '1') then
            regs(to_integer(unsigned(wa3))) <= x"00000000";
        elsif(rising_edge(clk)) then
            if(we3 = '1') then
                regs(to_integer(unsigned(wa3))) <= wd3;
            end if; 
        end if;
    end process;

    readR: process(clk)
    begin
        if(rising_edge(clk)) then
            rd1 <= regs(to_integer(unsigned(ra1)));
        end if;
    end process;

    readS: process(clk)
    begin
        if(rising_edge(clk)) then
            rd2 <= regs(to_integer(unsigned(ra2)));
        end if;
    end process;

end architecture rtl;