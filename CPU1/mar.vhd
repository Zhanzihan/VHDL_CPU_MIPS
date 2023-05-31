library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mar is
    port (
        clk, rst: in STD_LOGIC;
        pc_in, alu_in: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        mar_sel_in, word_en_in: in STD_LOGIC;
        mar_out: out STD_LOGIC_VECTOR(31 DOWNTO 0);
        adr_error: out STD_LOGIC
    );
end entity mar;

architecture rtl of mar is
    component way2Mux is
        port (
            s: in STD_LOGIC;
            a, b: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    signal output: STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    way2Muxx: way2Mux port map(a=>pc_in, b=>alu_in, s=>mar_sel_in, output=>output);
    process(clk, rst) 
    begin
        if(rst='1') then
            mar_out <= X"00000000";
            adr_error <= '0';
        elsif(rising_edge(clk)) then
            if(output(1 DOWNTO 0) /= "00") then
                adr_error <= '1';
            else
                mar_out <= output;
            end if;
        end if;
    end process;
end architecture rtl;