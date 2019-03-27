----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 08:50:31 PM
-- Design Name: 
-- Module Name: instr_mem - Behavioral
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

entity instr_mem is
  Port (
  addr : in std_logic_vector(7 downto 0);
  Data : out std_logic_vector(31 downto 0));
end instr_mem;

architecture Behavioral of instr_mem is
    type instruction_memory is array (0 to 63) of std_logic_vector(31 downto 0);
    signal memory : instruction_memory := (others => (others => '0'));
begin
   
    memory (0)  <= x"00007033"; -- and r0 ,r0 ,r0 x "0"
    memory (1)  <= x"00100093"; -- addi r1 ,r0 , 1 x "1"
    memory (2)  <= x"00200113"; -- addi r2 ,r0 , 2 x "2"
    memory (3)  <= x"00308193"; -- addi r3 ,r1 , 3 x "4"
    memory (4)  <= x"00408213"; -- addi r4 ,r1 , 4 x "5"
    memory (5)  <= x"00510293"; -- addi r5 ,r2 , 5 x "7"
    memory (6)  <= x"00610313"; -- addi r6 ,r2 , 6 x "8"
    memory (7)  <= x"00718393"; -- addi r7 ,r3 , 7 x"B"
    memory (8)  <= x"00327533"; -- and r10 = r4 & r3 x "4"
    memory (9)  <= x"00208433"; -- add r8 = r1+r2 x "3"
    memory (10) <= x"404404b3"; -- sub r9 = r8 -r4 x" fffffffe "
    memory (11) <= x"02350263"; -- beq r3 , r10 , 36 x "0"
    --jump to 20
    
    -- second jump target
    memory (12) <= x"0041e5b3"; -- or r11 = r3 | r4 x "5"
    memory (13) <= x"0041a633"; -- if r3 <r4 r12 = 1 x "1"
    memory (14) <= x"007346b3"; -- nor r13 = r6 nor r7 x" fffffff4 "
    memory (15) <= x"4d34f713"; -- andi r14 = r9 & "4 D3" x"4 D2"
    memory (16) <= x"8d35e793"; -- ori r15 = r11 | "8 d3" x" fffff8d7 "
    memory (17) <= x"4d26a813"; -- if r13 < x"4 D2" r16 = 1 x "0"
    memory (18) <= x"4d244893"; -- nori r17 = r8 nor x"4 D2" x" fffffb2C "
    memory (19) <= x"02350063"; -- beq r3 , r10 , 32 x "0"
    -- jump to end
    
    -- First jump target
    memory (20) <= x"00649933"; -- sll r18 , r9 ,r6 x" fffffe00 "
    memory (21) <= x"0074d9b3"; -- srl r19 , r9 ,r7 x "001 fffff "
    memory (22) <= x"4074da33"; -- sra r20 , r9 ,r7 x" ffffffff "
    memory (23) <= x"00749a93"; -- slli r21 , r9 ,7 x" ffffff00 "
    memory (24) <= x"0034db13"; -- srli r22 , r9 ,3 x"1 fffffff "
    memory (25) <= x"4019db93"; -- srai r23 , r19 ,1 x "000 fffff "
    memory (26) <= x"fc350463"; -- beq r3 , r10 , -56 x "0"
    --jump back to 12
    
    -- third jump target
    memory (27) <= x"00649933"; -- sll r18 , r9 ,r6 x" fffffe00 "
    memory (28) <= x"00f02823"; -- sw r15 , 16( r0) x "00000010"
    memory (29) <= x"00e02d23"; -- sw r14 , 28( r0) x "0000001 a"
    memory (30) <= x"fc430463"; -- beq r6 , r4 , -56 x "3"
    memory (31) <= x"01002083"; -- ld 11 , 16( r0) x "00000010"
    memory (32) <= x"01a02103"; -- ld r2 , 28( r0) x "0000001 a"
    memory (33) <= x"00208433"; -- add r8 = r1+r2 x" fffffda9 "
    
    
    Data <= memory ( to_integer ( unsigned ( addr (7 downto 2))));


end Behavioral;