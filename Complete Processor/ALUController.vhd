----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 11:47:07 PM
-- Design Name: 
-- Module Name: ALUController - Behavioral
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

entity ALUController is
  Port (
      ALUOp : in std_logic_vector(1 downto 0);
      Funct7 : in std_logic_vector(6 downto 0);
      Funct3 : in std_logic_vector(2 downto 0);
      Operation : out std_logic_vector(3 downto 0));
end ALUController;

architecture Behavioral of ALUController is

begin

    Operation(0) <= '1' when ( (Funct3 = "110") or (Funct3 = "010" AND ALUOp(0)= '0') ) else '0';

    Operation(1) <= '1' when ( (Funct3 = "010") or (Funct3 = "000") or (Funct3 = "001") ) else '0';
                
    Operation(2) <= '1' when ( (Funct3 = "100") or (Funct3 = "010" and ALUOp(0) = '0')  or 
                               (Funct3 = "000" and (Funct7 /= "0000000" and (ALUOp = "10" or ALUOp = "11"))) or 
                               (Funct3 = "101" and Funct7 = "0100000") ) else '0';
                             
    Operation(3) <= '1' when (Funct3 = "100") or (Funct3 = "001") or  
                        (Funct3 = "101" and Funct7 = "0000000") else '0';

end Behavioral;
