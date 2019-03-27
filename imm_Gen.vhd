----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 10:11:32 PM
-- Design Name: 
-- Module Name: imm_Gen - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity imm_Gen is
  Port (
    InstCode : in std_logic_vector (31 downto 0);
    ImmOut : out std_logic_vector (31 downto 0));
end imm_Gen;

architecture Behavioral of imm_Gen is

begin
    process(InstCode)
    variable tempSum: std_logic_vector(11 downto 0);
    begin
        case InstCode(6 downto 0) is
            when "0110011" => --R type instructions
                ImmOut <= x"00000000";
                
            when "0000011" => -- load instruction I type 
                if (InstCode(31)='1') then
                    ImmOut <= (x"fffff" & InstCode(31 downto 20));
                else
                    ImmOut <= (x"00000" & InstCode(31 downto 20));
                end if;
           
            when "0010011" => -- I type instructions
                if ((InstCode(14 downto 12) = "001") OR (InstCode(14 downto 12) = "101")) then                                       
                    ImmOut <= ("000000000000000000000000000" & InstCode(24 downto 20));                    
                else 
                    if (InstCode(31)='1') then
                        ImmOut <= (x"fffff" & InstCode(31 downto 20));
                    else
                        ImmOut <= (x"00000" & InstCode(31 downto 20));
                    end if;
                end if;
                
            when "0100011" => -- S type
                tempSum := InstCode(31 downto 25) & InstCode(11 downto 7);
                if (tempSum(11)='1') then
                    ImmOut <= (x"fffff" & tempSum(11 downto 0));
                else
                    ImmOut <= (x"00000" & tempSum(11 downto 0));
                end if;
            
            when "1100011" =>  --B type
                tempSum := InstCode(31 downto 25) & InstCode(11 downto 7);
                if (tempSum(11)='1') then
                    ImmOut <= (x"fffff" & tempSum(11 downto 0));
                else
                    ImmOut <= (x"00000" & tempSum(11 downto 0));
                end if;
                
            when others => 
                ImmOut <= (others=>'0');
        end case;
    
    end process;

end Behavioral;
