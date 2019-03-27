----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 08:19:43 PM
-- Design Name: 
-- Module Name: Processor - Behavioral
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

entity Processor is
  Port (
  clk, reset : in std_logic;
  Result : out std_logic_vector(31 downto 0));
end Processor;

architecture Behavioral of Processor is
--------- component declaration ---------------
    component Datapath 
    port(
        clk , reset : in std_logic;
        RegWrite , MemtoReg , ALUsrc , MemWrite , MemRead, Branch : in std_logic;
        ALU_CC : in std_logic_vector(3 downto 0);
        opcode : out std_logic_vector(6 downto 0);
        Funct7 : out std_logic_vector(6 downto 0);
        Funct3 : out std_logic_vector(2 downto 0);
        Datapath_Result : out std_logic_vector(31 downto 0));
    end component;

    component Controller
    port (
        Opcode : in std_logic_vector (6 downto 0);
        ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite: out std_logic;
        Branch: out std_logic;
        ALUOp : out std_logic_vector(1 downto 0));
    end component;

    component ALUController
    port (
        ALUOp : in std_logic_vector(1 downto 0);
        Funct7 : in std_logic_vector(6 downto 0);
        Funct3 : in std_logic_vector(2 downto 0);
        Operation : out std_logic_vector(3 downto 0));
    end component;

--------- signal declaration ------------------     
    signal RegWrite, MemtoReg, ALUSrc, MemWrite, MemRead : std_logic;
    signal opcode : std_logic_vector(6 downto 0);
    signal Funct7 : std_logic_vector(6 downto 0);
    signal Funct3 : std_logic_vector(2 downto 0);
    signal Operation : std_logic_vector(3 downto 0); 
    signal ALUop : std_logic_vector(1 downto 0);
    signal Branch: std_logic;
    
begin
    Dpath : Datapath
    port map (clk => clk,
              reset => reset,
              RegWrite => RegWrite,
              MemtoReg => MemtoReg,
              ALUSrc => ALUSrc,
              MemWrite => MemWrite,
              MemRead => MemRead,
              Branch => Branch,
              ALU_CC => Operation,
              opcode => opcode,
              Funct7 => Funct7,
              Funct3 => Funct3,
              Datapath_Result => Result);
              
    cntrl : Controller
    port map (Opcode => opcode, 
              ALUSrc => ALUSrc, 
              MemtoReg => MemtoReg, 
              RegWrite => RegWrite, 
              MemRead => MemRead, 
              MemWrite => MemWrite,
              Branch => Branch,
              ALUop => ALUop);

    ALUcntrl : ALUController
    port map (ALUop => ALUop,
              Funct7 => Funct7,
              Funct3 => Funct3,
              Operation => Operation);

end Behavioral;
