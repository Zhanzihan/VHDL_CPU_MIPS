library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ir is
    port (
        clk, rst: in STD_LOGIC;
        mdr_in: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        ir_sel_in: in STD_LOGIC;
        ir_out: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity ir; 

architecture rtl of ir is
    
begin
    process(clk, rst)
    begin
        if(rst='1') then
            ir_out <= X"00000000";
        elsif(rising_edge(clk)) then
            if(ir_sel_in = '1') then
                ir_out <= mdr_in;
            end if;
        end if;
    end process;
end architecture rtl;