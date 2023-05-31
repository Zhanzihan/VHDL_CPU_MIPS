library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_control is
    port (
        clk, rst, alu_r_sel: in STD_LOGIC; --R sel
        mdr_data, pcplus8: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        ir_data: in STD_LOGIC_VECTOR(15 DOWNTO 0); --immediate
        fun_sel: in STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_addr, r_addr, w_addr: in STD_LOGIC_VECTOR(4 DOWNTO 0);
        reg_sel: in STD_LOGIC_VECTOR(1 DOWNTO 0); --3wayMux
        sen, ben, oen: in STD_LOGIC;
        alu_out: out STD_LOGIC_VECTOR(31 DOWNTO 0);
        alu_flag_out: out STD_LOGIC --overflow
    );
end entity alu_control;

architecture Calculation of alu_control is
    component alu is
        port (
            op: in STD_LOGIC_VECTOR(3 downto 0);
            s, r: in STD_LOGIC_VECTOR(31 downto 0);
            y: out STD_LOGIC_VECTOR(31 downto 0);
            overflow: out STD_LOGIC
        );
    end component;

    component reg32 is 
        port (
            we, clk, clr: in STD_LOGIC;
            wrdata: in STD_LOGIC_VECTOR(31 downto 0);
            wrad, sad, rad: in STD_LOGIC_VECTOR(4 downto 0); -- ADDRESS
            outS, outR: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component signExtend is
        port (
            input: in STD_LOGIC_VECTOR(15 downto 0);
            en: in STD_LOGIC;
            output: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component way3Mux is
        port (
            a, b, c: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            s: in STD_LOGIC_VECTOR(1 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;

    component way2Mux is
        port (
            s: in STD_LOGIC;
            a, b: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    signal s, r, y: STD_LOGIC_VECTOR(31 DOWNTO 0); --alu 
    signal wrdata, outR: STD_LOGIC_VECTOR(31 DOWNTO 0); --reg32
    signal extend_mdr_data, extend_ir_data: STD_LOGIC_VECTOR(31 DOWNTO 0); 
    signal we, clr: STD_LOGIC; --reg32
begin
    signExtendx: signExtend port map(input=>mdr_data, en=>ben, output=>extend_mdr_data);
    signExtendy: signExtend port map(input=>ir_data, en=>sen, output=>extend_ir_data);
    alux: alu port map(s=>s, r=>r, op=>fun_sel, y=>alu_out, overflow=>alu_flag_out, y=>y);
    way3Muxx: way3Mux port map(a=>y, b=>pcplus8, c=>extend_mdr_data, s=>reg_sel, output=>wrdata);
    way2Muxx: way2Mux port map(a=>outR, b=>extend_ir_data, s=>alu_r_sel, output=>r);
    reg32x: reg32 port map(we=>we, clr=>clr, clk=>clk, wrdata=>wrdata, wrad=>w_addr, sad=>s_addr, rad=>r_addr, outS=>s, outR=>outR);
    
end architecture Calculation;