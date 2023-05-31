library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port (
        alucontrol: in STD_LOGIC_VECTOR(3 DOWNTO 0);
        srca, srca: in STD_LOGIC_VECTOR(31 DOWNTO 0);
        aluresult: out STD_LOGIC_VECTOR(31 DOWNTO 0);
        overflow, zero, neg: out STD_LOGIC;
    );
end entity ALU;
    
architecture Calculation of ALU is
begin
    process(alucontrol, srca, srca)
        variable temp: STD_LOGIC_VECTOR(31 DOWNTO 0);
        variable mul: STD_LOGIC_VECTOR(63 DOWNTO 0);
    begin
        case alucontrol is
            when "0000" => --ADD
            temp := STD_LOGIC_VECTOR(signed(srca) + signed(r));
            overflow <= ((not srca(31)) and (not srca(31)) and temp(31)) and
                    ((srca(31)) and (srca(31)) and not temp(31));

            --when "0001" => --ADD without overflow
            --temp := STD_LOGIC_VECTOR(signed(s) + signed(r));

            when "0010" => --SUB
            temp := STD_LOGIC_VECTOR(signed(srca) - signed(srca));
            overflow <= ((not srca(31)) and (srca(31)) and temp(31)) or
                    ((srca(31)) and (not srca(31)) and not temp(31));

            when "0011" => --set less than
            if(signed(srca) < signed(srca)) then
                temp := x"00000001";
            else
                temp := x"00000000";
            end if;

            when "0100" => --MUL
            mul := STD_LOGIC_VECTOR(signed(srca) * signed(srca));
            temp := mul(31 downto 0);

            when "0101" => --bitwise AND
            temp := srca and srca;

            when "0110" => --LUI load upper immediate
            temp(15 downto 0) := srca(15 downto 0);
            temp(31 downto 16) := x"0000";

            when "0111" => --bitwise OR
            temp := srca or srca;

            when "1000" => --bitwise XOR
            temp := srca xor srca;

            when "1001" => --shift left logically
            temp := STD_LOGIC_VECTOR(unsigned(srca) sll to_integer(unsigned(srca)));

            when "1010" => --shift right arithmetically
            temp := to_stdlogicvector(to_bitvector(srca) sra to_integer(unsigned(srca)));

            when "1011" => --shift right logically;
            temp := std_logic_vector(unsigned(srca) srl to_integer(unsigned(srca))); 
            
            when others =>
            null;
        end case;
        ALUResult <= temp;
        if(temp = x"00000000") then
            zero <= '1';
        else
            zero <= '0';
        end if;

        if(signed(temp) < signed(x"00000000")) then
            neg <= '1';
        else
            neg <= '0';
        end if;
    end process;

end architecture Calculation;