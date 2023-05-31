library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg32 is
    port (
        we, clk, clr: in STD_LOGIC;
        wrdata: in STD_LOGIC_VECTOR(31 downto 0);
        wrad, sad, rad: in STD_LOGIC_VECTOR(4 downto 0); -- ADDRESS
        outS, outR: out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity reg32;

architecture rtl of reg32 is
    type reg is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal regs : reg; 
begin

    writeReg: process(clk)
    begin
        if(clr = '1') then
            regs(to_integer(unsigned(wrad))) <= x"00000000";
        elsif(rising_edge(clk)) then
            if(we = '1') then
                regs(to_integer(unsigned(wrad))) <= wrdata;
            end if;
        end if;
    end process;

    readR: process(clk)
    begin
        if(rising_edge(clk)) then
            outR <= regs(to_integer(unsigned(wrad)));
        end if;
    end process;

    readS: process(clk)
    begin
        if(rising_edge(CLK)) then
            outS <= regs(to_integer(unsigned(wrad)));
        end if;
    end process;
end architecture rtl;