library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tb is

end entity alu_tb;

architecture rtl of alu_tb is
    component alu is
        port (
            op: in STD_LOGIC_VECTOR(3 DOWNTO 0);
            s, r: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            y: out STD_LOGIC_VECTOR(31 DOWNTO 0);
            overflow: out STD_LOGIC
        );
    end component;
    constant clk_period: time:= 20ns;
    signal op: STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal s, r, y: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal overflow, clk: STD_LOGIC;
begin
    alux: alu port map(op=>op, s=>s, r=>r, y=>y, overflow=>overflow);
    data-gen: process
    begin
        s <= x"00000003";
        r <= x"FFFFFFFF";
        op <= x"0000";
        wait for clk_period*3;
        op <= x"0001";
        wait for clk_period*3;
        op <= x"0010";
        wait for clk_period*3;
        op <= x"0011";
        wait for clk_period*3;
        op <= x"0100";
        wait for clk_period*3;
        op <= x"0101";
        wait for clk_period*3;
        op <= x"0110";
        wait for clk_period*3;
        op <= x"0111";
        wait for clk_period*3;
        op <= x"1000";
        wait for clk_period*3;
        op <= x"1001";
        wait for clk_period*3;
        op <= x"1010";
        wait for clk_period*3;
        op <= x"1011";
        wait for clk_period*3;
        wait ;
    end process;
    
    
end architecture rtl;