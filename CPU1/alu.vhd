library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port (
        op: in STD_LOGIC_VECTOR(3 downto 0);
        s, r: in STD_LOGIC_VECTOR(31 downto 0);
        y: out STD_LOGIC_VECTOR(31 downto 0);
        overflow: out STD_LOGIC
    );
end entity ALU;

architecture Calculation of ALU is
begin
    process(op, s, r)
        variable temp: STD_LOGIC_VECTOR(31 downto 0);
        variable mul: STD_LOGIC_VECTOR(63 downto 0);
    begin
        case op is
            when "0000" => --ADD
            temp := STD_LOGIC_VECTOR(signed(s) + signed(r));
            overflow <= ((not S(31)) and (not S(31)) and temp(31)) and
                    ((S(31)) and (S(31)) and not temp(31));

            when "0001" => --ADD without overflow
            temp := STD_LOGIC_VECTOR(signed(s) + signed(r));

            when "0010" => --SUB
            temp := STD_LOGIC_VECTOR(signed(s) - signed(r));
            overflow <= ((not s(31)) and (s(31)) and temp(31)) or
                    ((s(31)) and (not s(31)) and not temp(31));

            when "0011" => --signed less than
            if(signed(s) < signed(r)) then
                temp := x"00000001";
            else
                temp := x"00000000";
            end if;

            when "0100" => --MUL
            mul := STD_LOGIC_VECTOR(signed(s) * signed(r));
            temp := mul(31 downto 0);

            when "0101" => --bitwise AND
            temp := S and R;

            when "0110" => --LUI load upper immediate
            temp(15 downto 0) := r(15 downto 0);
            temp(31 downto 16) := x"0000";

            when "0111" => --bitwise OR
            temp := s or r;

            when "1000" => --bitwise XOR
            temp := s xor r;

            when "1001" => --shift left logically
            temp := STD_LOGIC_VECTOR(unsigned(s) sll to_integer(unsigned(r)));

            when "1010" => --shift right arithmetically
            temp := to_stdlogicvector(to_bitvector(s) sra to_integer(unsigned(r)));

            when "1011" => --shift right logically;
            temp := std_logic_vector(unsigned(s) srl to_integer(unsigned(r))); 
            
            when others =>
            null;
        end case;
        y <= temp;
    end process;

end architecture Calculation;