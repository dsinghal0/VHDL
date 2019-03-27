----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 11:45:21 PM
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
  Port ( 
      Opcode : in std_logic_vector (6 downto 0);
      ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite : out std_logic;
      Branch: OUT std_logic;
      ALUOp : out std_logic_vector( 1 downto 0));
end Controller;

architecture Behavioral of Controller is
    constant Reg_TYPE : std_logic_vector (6 downto 0) := "0110011"; -- Add, Sub, Slt, Nor, Or, And
    constant Imm_TYPE : std_logic_vector (6 downto 0) := "0010011"; -- Addi, Slti, Nori, Ori, Andi
begin

    ALUSrc   <= '0' when (Opcode = "0110011" or Opcode = "1100011") else '1';
    MemtoReg <= '1' when (Opcode = "0000011") else '0';
    RegWrite <= '0' when (Opcode = "1100011" or Opcode = "0100011") else '1';
    MemRead  <= '1' when (Opcode = "0000011") else '0';
    MemWrite <= '1' when (Opcode = "0100011") else '0';
    Branch <= '1' when (Opcode = "1100011") else '0';
    
    
    ALUOp(0) <= '0' when (Opcode = "0110011" or Opcode = "0010011") else '1';
    ALUOp(1) <= '1' when (Opcode = "0110011" or Opcode = "1100011") else '0';

end Behavioral;
