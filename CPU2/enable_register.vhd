library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity enable_register is
    port (
        clk, rst: in STD_LOGIC;
        --alu_flag: in STD_LOGIC_VECTOR(2 DOWNTO 0);
        en: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity enable_register;

architecture rtl of enable_register is
    
begin
    process(clk, rst) 
    begin
        if(rst = '1') then
            output <= x"00000000";
        elsif(rising_edge(clk)) then
            if(en = '1') then
                output <= input;
            end if;
        end if;
    end process;
end architecture rtl;
