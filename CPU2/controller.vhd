library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port (
        clk, clr: in STD_LOGIC_VECTOR;
        cm_data_in: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        opcode, funct: in STD_LOGIC_VECTOR(5 DOWNTO 0);
        memToReg, regDst, pcSrc, aluSrca, IorD: out STD_LOGIC;
        branch, pcWrite, regWrite, irWrite, memWrite: out STD_LOGIC;
        aluSrcb: out STD_LOGIC_VECTOR(1 DOWNTO 0);
        aluControl: out STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
end entity controller;

architecture rtl of controller is
    signal currentState, nextState: STD_LOGIC_VECTOR(4 DOWNTO 0)
begin
    
    process(clk, clr) 
    begin
        if(clr = '1') then
            (opcode, funct, memToReg, regDst, pcSrc, aluSrca, IorD,
            branch, pcWrite, regWrite, irWrite, memWrite, aluSrcb, aluControl) <= (others => '0');
        elsif (rising_edge(clk)) then
            currentState <= nextState;
        end if;
    end process;
    
    process(currentState) 
    begin
        case currentState is
        when "00000" => --fetch
            pcWrite <= '1'; --pc = pc + 4
            pcSrc <= '0'; --from the aluResult
            IorD <= '0';
            irWrite <= '1';
            aluSrca <= '0' --pc = pc + 4
            aluSrcb <= "01";
            aluControl <= "0000";
            memWrite <= '0';
            regWrite <= '0';
            nextState <= "00001";
        when "00001" => --decode
            if(opcode = "100011" or opcode = "101011") then
                nextState <= "00010";
            end if;

        when "00010" => --lw or sw memAdr
            aluControl <= "0000" --add
            aluSrca <= '1'; --from rd1
            aluSrcb <= "10"; --from extended imm16
            irWrite <= '0';
            pcWrite <= '0';
            memWrite <= '0';
            regWrite <= '0';
            if(opcode = "100011") then --lw
                nextState <= "00011";
            elsif(opcode = "101011") then --sw
                nextState <= "00101";
            end if;
                
        when "00011" => --lw memRead
            irWrite <= '0';
            pcWrite <= '0';
            memWrite <= '0';
            regWrite <= '0';
            IorD <= '1';
            nextState <= "00100";
        
        when "00100" => --lw regWrite
            regWrite <= '1';
            memToReg <= '1';
            regDst <= '0';
            nextState <= "0000";
        
        when "00101" => --sw memWrite
            IorD <= '1';
            regWrite <= '0';
            memWrite <= '1';
            nextState <= "0000";

        when "00110" => --
    end process;
end architecture rtl;