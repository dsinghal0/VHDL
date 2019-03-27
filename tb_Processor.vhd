----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2019 05:19:10 PM
-- Design Name: 
-- Module Name: tb_Processor - Behavioral
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
USE IEEE.std_logic_textio.all;
USE std.textio.all ;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Processor is
--  Port ( );
end tb_Processor;

architecture Behavioral of tb_Processor is

--------- component declaration ---------------
component Processor is
port (clk, reset : in std_logic;
        Result : out std_logic_vector (31 downto 0) );
end component;
--------- signal declaration ------------------
signal tb_clk: std_logic := '0';
signal tb_reset : std_logic ;
signal tb_Result : std_logic_vector (31 downto 0);
signal point : integer :=0;
constant CLK_period : time := 100 ns ;

begin
uut : Processor
port map (
    clk => tb_clk ,
    reset => tb_reset ,
    Result => tb_Result );
    tb_clk <= not tb_clk after ( CLK_period /2);
    tb_reset <= '1' , '0' after 150 ns;
    
    tb1 : process
    variable my_line : line;
    begin
        wait for 100 ns ;
        if ( tb_Result = x"00000000") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000001") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000002") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000004") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000005") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000007") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000008") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"0000000b") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000004") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000003") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffffffe") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000000") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffffe00") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"001fffff") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"ffffffff") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"ffffff00") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"1fffffff") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"000fffff") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000000") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000005") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000001") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffffff4") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"000004d2") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffff8d7") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000000") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffffb2c") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000000") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffffe00") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000010") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"0000001a") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000003") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"00000010") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"0000001a") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        if ( tb_Result = x"fffffda9") then
        point <= point + 1;
        end if ;
        wait for 100 ns ;
        write ( my_line , point ); --- it should be 34
        writeline ( output , my_line );
        wait ; -- indefinitely suspend process
        
    end process;
end Behavioral;
