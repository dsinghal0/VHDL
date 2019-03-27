----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 10:25:30 PM
-- Design Name: 
-- Module Name: alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
  Port (
      a, b : in  std_logic_vector (31 downto 0);
      ALU_Operation  : in  std_logic_vector (3 downto 0);
      Result  : out std_logic_vector (31 downto 0);
      Carry_out, zero, overflow : out std_logic);
end alu;

architecture Behavioral of alu is

begin
    process(a, b, ALU_Operation)
    variable temp_Result  : std_logic_vector (32 downto 0);
    variable temp_bitvect: bit_vector(31 downto 0);
    variable temp_int: integer;
    begin
        case ALU_Operation is
            when "0000" =>          ------------- AND ------------------ 
                temp_Result := '0' & (a AND b);
                overflow <= '0';
            when "0001" =>          ------------- OR ------------------- 
                temp_Result := '0' & (a OR b);
                overflow <= '0';
            when "0010" =>          ------------- ADD ------------------ 
                temp_Result := std_logic_vector(signed('0' & a) + signed('0' & b));
                if (a(31)= '0' and b(31)='0' and temp_Result(31) ='1') then
                    overflow <= '1';
                elsif (a(31)= '1' and b(31)='1' and temp_Result(31) ='0') then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
            when "0110" =>          ------------- SUB ------------------ 
                temp_Result := std_logic_vector(signed('0' & a) - signed('0' & b));
                if (a(31)= '0' and b(31)='1' and temp_Result(31) ='1') then
                    overflow <= '1';
                elsif (a(31)= '1' and b(31)='0' and temp_Result(31) ='0') then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
            when "0111" =>          ------------- SLT ------------------
                if (a < b) then
                    temp_Result := '0' & x"00000001";
                else
                    temp_Result := '0' & x"00000000";
                end if;
                overflow <= '0';           
            when "1100" =>          ------------- NOR ------------------ 
                temp_Result := '0' & (a NOR b);
                overflow <= '0';
            when "1010" =>          ------------- SLL ------------------
                temp_Result := '0' & std_logic_vector(shift_left(unsigned(a),to_integer(unsigned(b))));
                overflow <= '0';
                
            when "1000" =>          ------------- SRL ------------------
                temp_Result := '0' & std_logic_vector(shift_right(unsigned(a),to_integer(unsigned(b))));
                overflow <= '0';
                
            when "0100" =>          ------------- SRA ------------------
                temp_Result := '0' & std_logic_vector(shift_right(signed(a),to_integer(unsigned(b))));
                overflow <= '0';
                
            when others =>          
                temp_Result := (others => 'X');
                overflow <= 'X';
        end case;
        
        if temp_Result(31 downto 0) = x"00000000" then
            zero <= '1';
        else
            zero <= '0';
        end if;
        
        Result <= temp_Result(31 downto 0);
        Carry_out <= temp_Result(32);

    end process;

end Behavioral;
