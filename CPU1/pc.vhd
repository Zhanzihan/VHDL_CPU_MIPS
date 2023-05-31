library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc is
    port (
        clk, rst, pcplus_en: in STD_LOGIC;
        ir_in, alu_in: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        --eq_in, ne_in, gez_in, gtz_in, lez_in, ltz_in, jl_in, jr_in: in STD_LOGIC;
        jump_in: in STD_LOGIC_VECTOR(3 DOWNTO 0);
        pc_out, pcplus8_out: inout STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end entity pc;

architecture rtl of pc is
    component signExtend is
        port (
            input: in STD_LOGIC_VECTOR(15 downto 0);
            en: in STD_LOGIC;
            output: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    signal signEn: STD_LOGIC;
    signal imm16: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal imm26: STD_LOGIC_VECTOR(25 DOWNTO 0);
    signal extendImm16: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal extendImm16_t: STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    imm16 <= ir_in(15 DOWNTO 0);
    imm26 <= ir_in(25 DOWNTO 0);
    signEn <= '1';

   signExtenda: signExtend port map(input=>imm16, en=>signEn, output=>extendImm16);
    extendImm16_t <= extendImm16(13 DOWNTO 0) & "00";
    
    process(clk, rst)
        variable pc_t: STD_LOGIC_VECTOR(31 DOWNTO 0);
    begin
        if(rst='1') then
            pc_out <= X"00000000";
            pcplus8_out <= X"00000000";
        elsif(rising_edge(clk)) then
            if(pcplus_en = '1') then
                pc_t := STD_LOGIC_VECTOR(SIGNED(pc_out) + x"00000008");
            end if;
            pcplus8_out <= pc_t;

            case jump_in is  
                when "0001" => --BEQ
                if(alu_in = x"00000000") then
                    pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + SIGNED(extendImm16_t));
                end if;  

                when "0010" => --BNE
                if(alu_in /= x"00000000") then
                    pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + SIGNED(extendImm16_t));
                end if;

                when "0011" => --BGEZ
                if(SIGNED(alu_in) >= 0) then
                    pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + SIGNED(extendImm16_t));
                end if;

                when "0100" => --BLTZ
                if(SIGNED(alu_in) < 0) then
                    pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + SIGNED(extendImm16_t));
                end if;

                when "0101" => --BGTZ
                if(SIGNED(alu_in) > 0) then
                    pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + SIGNED(extendImm16_t));
                end if;

                when "0110" => --BLEZ
                if(SIGNED(alu_in) <= 0) then
                    pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + SIGNED(extendImm16_t));
                end if;
                
                when "0111" => --Jump to imm
                pc_out <= pc_out(31 DOWNTO 28) & (imm26) & "00";

                when "1000" => --Jump to rs
                pc_out <= alu_in;
                when others =>
                pc_out <= STD_LOGIC_VECTOR(SIGNED(pc_out) + x"00000004");
            end case;
        end if;
    end process;
end architecture rtl;

