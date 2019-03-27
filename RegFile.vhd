----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2019 09:03:51 PM
-- Design Name: 
-- Module Name: RegFile - Behavioral
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

entity RegFile is
  Port (
  clk, reset, rg_wrt_en : in std_logic;
  rg_wrt_addr : in std_logic_vector (4 downto 0);
  rg_rd_addr1, rg_rd_addr2 : in std_logic_vector (4 downto 0);
  rg_wrt_data : in std_logic_vector (31 downto 0);
  rg_rd_data1, rg_rd_data2 : out std_logic_vector (31 downto 0));
end RegFile;

architecture Behavioral of RegFile is
    type reg is array (0 to 31) of std_logic_vector(31 downto 0);
    signal register_file : reg := (others => (others => '0'));
begin
    process(clk, reset)
    begin
        if(reset='1') then
		    for i in 0 to 31 loop
		        register_file(i) <= (others => '0'); 
		    end loop;
        elsif(rising_edge(clk) and rg_wrt_en='1') then
            register_file(to_integer(unsigned(rg_wrt_addr))) <= rg_wrt_data;
        end if;
    end process;

    rg_rd_data1 <= register_file(to_integer(unsigned(rg_rd_addr1)));
    rg_rd_data2 <= register_file(to_integer(unsigned(rg_rd_addr2)));

end Behavioral;
