----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 10:27:44 PM
-- Design Name: 
-- Module Name: data_mem - Behavioral
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

entity data_mem is
  Port (
      clk : in std_logic;
      MemRead , MemWrite : in std_logic;
      add : in std_logic_vector (8 downto 0);
      write_data : in std_logic_vector (31 downto 0);
      read_data : out std_logic_vector (31 downto 0));
end data_mem;

architecture Behavioral of data_mem is
    type Data_memory is array (0 to 127) of std_logic_vector(31 downto 0);
    signal memory : Data_memory := (others => (others => '0'));
begin
    process(clk)
    begin
         if (MemRead = '1') then
             read_data <= memory (to_integer(unsigned(add)));
         end if;
         if (rising_edge(clk)) then
            if ( MemWrite = '1') then
               memory (to_integer(unsigned(add))) <= write_data; 
            end if;
       end if;
    end process;

end Behavioral;
