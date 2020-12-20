----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:54:32 08/14/2020 
-- Design Name: 
-- Module Name:    demux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux is
    Port ( WrEn_demux : in  STD_LOGIC;
           Rw_demux : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0));
end demux;

architecture Behavioral of demux is

begin
     process(WrEn_demux,Rw_demux)
	  begin
	       if (RW_demux = "0000") then
			     output(0) <= WrEn_demux;
			 elsif (RW_demux = "0001") then
              output(1) <= WrEn_demux;
				  output(0) <= '0';
          elsif (RW_demux = "0010") then
              output(2) <= WrEn_demux;
			 elsif (RW_demux = "0011") then
              output(3) <= WrEn_demux;	
          elsif (RW_demux = "0100") then
              output(4) <= WrEn_demux;	
			 elsif (RW_demux = "0101") then
              output(5) <= WrEn_demux;	
          elsif (RW_demux = "0110") then
              output(6) <= WrEn_demux;	
			 elsif (RW_demux = "0111") then
              output(7) <= WrEn_demux;	
          elsif (RW_demux = "1000") then
              output(8) <= WrEn_demux;	
			 elsif (RW_demux = "1001") then
              output(9) <= WrEn_demux;	
          elsif (RW_demux = "1010") then
              output(10) <= WrEn_demux;	
			 elsif (RW_demux = "1011") then
              output(11) <= WrEn_demux;	
          elsif (RW_demux = "1100") then
              output(12) <= WrEn_demux;	
			 elsif (RW_demux = "1101") then
              output(13) <= WrEn_demux;	
          elsif (RW_demux = "1110") then
              output(14) <= WrEn_demux;	
			 elsif (RW_demux = "1111") then
              output(15) <= WrEn_demux;
			 end if;
      end process;			     
end Behavioral;

