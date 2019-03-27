----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 10:13:42 PM
-- Design Name: 
-- Module Name: mux2 - Behavioral
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

entity mux2 is
  Port (
      d0, d1 : in std_logic_vector (31 downto 0);
      s : in std_logic;
      y : out std_logic_vector (31 downto 0));
end mux2;

architecture Behavioral of mux2 is

begin
    process(d0,d1,s)
    begin
        if s='0' then
            y <= d0;
        elsif s='1' then
            y <= d1;
        end if;
    end process;

end Behavioral;
