library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_path is
    port (
        clk: in STD_LOGIC;
        memToReg, regDst, pcSrc, aluSrca, IorD: in STD_LOGIC;
        branch, pcWrite, regWrite, irWrite, memWrite: in STD_LOGIC;
        aluSrcb: in STD_LOGIC_VECTOR(1 DOWNTO 0);
        aluControl: in STD_LOGIC_VECTOR(3 DOWNTO 0);
    );
end entity data_path;

architecture rtl of data_path is
    component alu is
        port (
            alucontrol: in STD_LOGIC_VECTOR(3 DOWNTO 0);
            srca, srca: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            aluresult: out STD_LOGIC_VECTOR(31 DOWNTO 0);
            overflow, zero, neg: out STD_LOGIC;
        );
    end component;

    component memory is
        port (
            clk, we, clr: in STD_LOGIC;
            addr, wd: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            rd: out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;

    component reg32 is
        port (
            we3, clk, clr: in STD_LOGIC;
            ra1, ra2, wa3: in STD_LOGIC_VECTOR(4 downto 0); --address
            wd3: in STD_LOGIC_VECTOR(31 downto 0);
            rd1, rd2: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component enable_register is
        port (
            clk, rst: in STD_LOGIC;
            --alu_flag: in STD_LOGIC_VECTOR(2 DOWNTO 0);
            en: in STD_LOGIC;
            input: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;

    component reg_dst_mux is
        port (
            d0, d1: in STD_LOGIC_VECTOR(4 DOWNTO 0);
            sel: in STD_LOGIC;
            output: out STD_LOGIC_VECTOR(4 DOWNTO 0)
        );
    end component;

    component sign_extend is
        port (
            input: in STD_LOGIC_VECTOR(15 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0);
        );
    end component;

    component left_shift2bit is
        port (
            input: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            ouput: out STD_LOGIC_VECTOR(31 DOWNTO 0)''
        );
    end component;

    component bit32way2mux is
        port (
            d0, d1: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel: in STD_LOGIC;
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0);
        );
    end component;

    component bit32way4mux is
        port (
            d0, d1, d2, d3: in STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel: in STD_LOGIC_VECTOR(1 DOWNTO 0);
            output: out STD_LOGIC_VECTOR(31 DOWNTO 0);
        );
    end component;
    
    signal srcA, srcB, instr, data, aluResult, aluOut, signImm16, signImmShift16, rd1, rd2, memAdr, memRD, memWD, regWD, regWA, pcIn, pcOut: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal pcEn, zero, neg: STD_LOGIC; 
begin
    reg32x: reg32 port map(clk=>clk, clr=>clr, rd1=>rd1, rd2=>rd2, ra1=>instr(25 DOWNTO 21), ra2=>instr(20 DOWNTO 16), wd3=>regWD, wa3=>regWA, we3=>regWrite);

    alux: alu port map(srcA=>srcA, srcB=>srcB, alucontrol=>aluControl, aluresult=>aluResult, zero=>zero, neg=>neg);
    
    memoryx: memory port map(clk=>clk, clr=>clr, we=>memWrite, addr=>memAdr, rd=>memRD, wd=>memWD);
    memWD <= rd2;
    pc: enable_register port map(clk=>clk, input=>pcIn, en=>pcEn, output=>pcOut);

    ir: enable_register port map(clk=>clk, input=>memRD, en=>irWrite, output=>instr);
    
    mdr: reg port map(clk=>clk, input=>memRD, output=>data);

    alu_reg: reg port map(clk=>clk, input=>aluResult, output=>aluOut);

    imm16SignExtend: sign_extend port map(input=>instr(15 DOWNTO 0), output=>signImm16);

    imm16SignExtendShift: left_shift2bit port map(input=>signImm16, output=>signImmShift16);


    IorDMUX: bit32way2mux port map(d0=>pcOut, d1=>aluOut, sel=>IorD, output=>memAdr);

    MemorALUToRegMUX: bit32way2mux port map(d0=>aluOut, d1=>data, sel=>memToReg, output=>regWD);

    RegDstMUX: reg_dst_mux port map(d0=>instr(20 downto 16), d1=>instr(15 downto 11), sel=>regDst, output=>regWA);

    ALUScrAMUX: bit32way2mux port map(d0=>pcOut, d1=>rd1, output=>srcA);

    ALUSrcBMUX: bit32way4mux port map(d0=>rd2, d1=>(x"00000004"), d2=>signImm16, d3=>signImmShift16, sel=>aluSrcb, output=>srcB);

    pcSrcMUX: bit32way2mux port map(d0=>aluResult, d1=>aluOut, sel=>pcSrc, output=>pcIn);

end architecture rtl;
