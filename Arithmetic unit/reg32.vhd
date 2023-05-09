library library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity REG32 is
    port (
        WE, CLK, CLR: in std_logic;
        WRDATA: in std_logic_vector(31 downto 0);
        WRAD, SAD, RAD: in std_logic_vector(4 downto 0); -- ADDRESS
        outS, outR: out std_logic_vector(31 downto 0); 
    );
end entity REG32;

architecture rtl of REG32 is
    type reg is array(31 downto 0) of std_logic_vector(31 downto 0);
    signal regs : reg; 
begin

    writeReg: process(CLK)
    begin
        if(CLR = '1') then
            regs(conv_integer(WRAD)) <= x"00000000";
        elsif(rising_edge(CLK)) then
            if(WE = '1') then
                regs(conv_integer(WRAD)) <= WRDATA;
            end if;
        end if;
    end process;

    readR: process(CLK)
    begin
        if(rising_edge(CLK)) then
            outR <= regs(conv_integer(RAD));
        end if;
    end process;

    readS: process(CLK)
    begin
        if(rising_edge(CLK)) then
            outS <= regs(conv_integer(SAD));
        end if;
    end process;
end architecture rtl;