library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port (
        OP: in std_logic_vector(3 downto 0);
        S, R: in std_logic_vector(31 downto 0);
        Y: out std_logic_vector(31 downto 0);
        OVERFLOW: out std_logic
    );
end entity ALU;

architecture Calculation of ALU is
begin
    process(OP, S, R)
        variable temp: std_logic_vector(31 downto 0);
        variable mul: std_logic_vector(63 downto 0);
    begin
        case OP is
            when "0000" => --ADD
            temp := std_logic_vector(signed(S) + signed(R));
            OVERFLOW <= ((not S(31)) and (not S(31)) and temp(31)) and
                    ((S(31)) and (S(31)) and not temp(31));

            when "0001" => --ADD without overflow
            temp := std_logic_vector(signed(S) + signed(R));

            when "0010" => --SUB
            temp := std_logic_vector(signed(S) - signed(R));
            OVERFLOW <= ((not S(31)) and (S(31)) and temp(31)) or
                    ((S(31)) and (not S(31)) and not temp(31));

            when "0011" => --signed less than
            if(signed(S) < signed(R)) then
                temp := x"00000001";
            else
                temp := x"00000000";
            end if;

            when "0100" => --MUL
            mul := std_logic_vector(signed(S) * signed(R));
            temp := mul(31 downto 0);

            when "0101" => --bitwise AND
            temp := S and R;

            when "0110" => --LUI load upper immediate
            temp(15 downto 0) := R(15 downto 0);
            temp(31 downto 16) := x"0000";

            when "0111" => --bitwise OR
            temp := S or R;

            when "1000" => --bitwise XOR
            temp := S xor R;

            when "1001" => --shift left logically
            temp := std_logic_vector(unsigned(S) sll to_integer(unsigned(R)));

            when "1010" => --shift right arithmetically
            temp := to_stdlogicvector(to_bitvector(S) sra to_integer(unsigned(R)));

            when "1011" => --shift right logically;
            temp := std_logic_vector(unsigned(S) srl to_integer(unsigned(R))); 
            
            when others =>
            null;
        end case;
        Y <= temp;
    end process;

end architecture Calculation;