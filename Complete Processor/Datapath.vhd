----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 07:57:15 PM
-- Design Name: 
-- Module Name: Datapath - Behavioral
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

entity Datapath is
  Port (
  clk , reset : in std_logic;
  RegWrite , MemtoReg , ALUsrc , MemWrite , MemRead, Branch : in std_logic;
  ALU_CC : in std_logic_vector(3 downto 0);
  opcode : out std_logic_vector(6 downto 0);
  Funct7 : out std_logic_vector(6 downto 0);
  Funct3 : out std_logic_vector(2 downto 0);
  Datapath_Result : out std_logic_vector(31 downto 0) );
end Datapath;

architecture Behavioral of Datapath is
--------- component declaration ---------------
    component HA is
    port (
        A, B : in  std_logic_vector(7 downto 0);
        sum  : out std_logic_vector(7 downto 0);
        Cout : out std_logic);
    end component;
    
    component FlipFlop is
    port (
        clk, reset : in std_logic;
        D : in std_logic_vector(7 downto 0);
        Q : out std_logic_vector(7 downto 0));
    end component;
    
    component instr_mem is
    port (
        addr : in std_logic_vector(7 downto 0);
        Data : out std_logic_vector(31 downto 0));
    end component;
    
    component RegFile is
    port (
        clk, reset, rg_wrt_en : in std_logic;
        rg_wrt_addr : in std_logic_vector (4 downto 0);
        rg_rd_addr1, rg_rd_addr2 : in std_logic_vector (4 downto 0);
        rg_wrt_data : in std_logic_vector (31 downto 0);
        rg_rd_data1, rg_rd_data2 : out std_logic_vector (31 downto 0));
    end component;
    
    component imm_Gen is
    port (
        InstCode : in std_logic_vector (31 downto 0);
        ImmOut : out std_logic_vector (31 downto 0));
    end component;
    
    component mux2 is
    port (
        d0, d1 : in std_logic_vector (31 downto 0);
        s : in std_logic;
        y : out std_logic_vector (31 downto 0));
    end component;

    component alu is
    port (
        a, b : in  std_logic_vector (31 downto 0);
        ALU_Operation  : in  std_logic_vector (3 downto 0);
        Result  : out std_logic_vector (31 downto 0);
        Carry_out, zero, overflow : out std_logic);
    end component;
    
    component data_mem is
    port (
        clk : in std_logic;
		MemRead , MemWrite : in std_logic;
        add : in std_logic_vector (8 downto 0);
        write_data : in std_logic_vector (31 downto 0);
        read_data  : out std_logic_vector (31 downto 0));
    end component;
    
--------- signal declaration ------------------ 
    signal PC, PCPlus4, branch_addr, next_pc : std_logic_vector(7 downto 0);
    signal Instr : std_logic_vector(31 downto 0);
    signal WriteBack_Data : std_logic_vector(31 downto 0);
    signal Reg1, Reg2 : std_logic_vector(31 downto 0);
    signal ExtImm, SrcB : std_logic_vector(31 downto 0);
    signal ALU_Result : std_logic_vector(31 downto 0);
    signal DataMem_read : std_logic_vector(31 downto 0);
    signal branch_sel, Alu_zero: std_logic;
    signal tempD0, tempD1, tempY : std_logic_vector(31 downto 0);
 begin

    branch_sel <= Branch and Alu_zero;
    -- next PC
   PCADD: HA 
   port map(
   A => PC,
   B => x"04",
   SUM => PCPlus4,
   Cout => open);

    -- Branch PC
   BADD: HA 
   port map(
   A => PC,
   B => ExtImm(7 downto 0),
   SUM => branch_addr,
   Cout => open);
   
   next_pc <= tempY(7 downto 0); 
-- PC Flip Flop
   FF: FlipFlop
   port map(
   clk => clk,
   reset => reset,
   D => next_pc,
   Q => PC);
   
-- Instruction memory
   instructionmemory: instr_mem 
   port map(
   addr => PC,
   Data => Instr);
   
   opcode <= Instr(6 downto 0);
   Funct7 <= Instr(31 downto 25);
   Funct3 <= Instr(14 downto 12);
   
-- Register File
   RegF: RegFile
   port map(
   clk => clk, 
   reset => reset,
   rg_wrt_en => RegWrite,
   rg_wrt_addr => Instr(11 downto 7), 
   rg_rd_addr1 => Instr(19 downto 15), 
   rg_rd_addr2 => Instr(24 downto 20),
   rg_wrt_data => WriteBack_Data, 
   rg_rd_data1 => Reg1, 
   rg_rd_data2 => Reg2);
   
-- sign extend
   Ext_Imm : imm_Gen  
   port map(
   InstCode => Instr,
   ImmOut => ExtImm);
     
-- srcbmux
   srcbmux : mux2
   port map(
   d0 => Reg2, 
   d1 => ExtImm, 
   s => ALUsrc,
   y => SrcB);
   
   tempD0 <= x"000000" & pcplus4; 
   tempD1 <= x"000000" & branch_addr;
   -- pcMux
   pcMux : mux2
   port map(
   d0 => tempD0, 
   d1 => tempD1, 
   s => branch_sel,
   y => tempY);
   
-- ALU
   alu_module : alu 
   port map(
   a => Reg1, 
   b => SrcB,
   ALU_Operation => ALU_CC,
   Result => ALU_Result,
   Carry_out => open, 
   zero => Alu_zero, 
   overflow => open);
   
   Datapath_Result <= ALU_Result;

-- Data memory
   datamemory: data_mem 
   port map(
   clk => clk,
   MemRead => MemRead,
   MemWrite => MemWrite,
   add => ALU_Result(8 downto 0), 
   write_data => Reg2,
   read_data => DataMem_read); 
   
-- resmux
   resultmux : mux2
   port map(
   d0 => ALU_Result, 
   d1 => DataMem_read, 
   s => MemtoReg,
   y => WriteBack_Data);

end Behavioral;
