library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mdr is
    port (
        clk, rst: in STD_LOGIC;
        mem_in, pc_in, alu_in: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        mdr_sel_in: in STD_LOGIC_VECTOR(1 DOWNTO 0);
        mdr_out: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity mdr;

architecture rtl of mdr is
    component way3Mux is
        port (
            a, b, c: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            s: in STD_LOGIC_VECTOR(1 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    signal output: STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    way3Muxx: way3Mux port map(a=>mem_in, b=>pc_in, c=>alu_in, s=>mdr_sel_in, output=>output);
    process(clk, rst)
    begin
        if(rst = '1') then
            mdr_out <= X"00000000";
        elsif(rising_edge(clk)) then
            mdr_out <= output;
        end if;
    end process;
end architecture rtl;

