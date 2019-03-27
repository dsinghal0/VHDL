----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 08:30:04 PM
-- Design Name: 
-- Module Name: HA - Behavioral
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

entity HA is
  Port (
  A, B : in  std_logic_vector (7 downto 0);
  SUM  : out std_logic_vector (7 downto 0);
  Cout : out std_logic);
end HA;

architecture Behavioral of HA is

SIGNAL temp : STD_LOGIC_VECTOR (8 downto 0);

begin

    temp <= std_logic_vector ( signed ( '0' & A ) + signed ( '0' & B ) );
    Sum  <= temp (7 downto 0);
    Cout <= temp (8);

end Behavioral;
