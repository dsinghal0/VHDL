----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 08:30:04 PM
-- Design Name: 
-- Module Name: FlipFlop - Behavioral
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

entity FlipFlop is
  Port (
  clk, reset : in std_logic;
  d : in  std_logic_vector( 7 downto 0);
  q : out std_logic_vector( 7 downto 0));
end FlipFlop;

architecture Behavioral of FlipFlop is

begin
    process (clk)
    begin
        if ( clk'event and clk = '1') then
            if (reset='1') then
                q <= "00000000";
            else
                q <= d;
            end if;
        end if;
    end process;

end Behavioral;
