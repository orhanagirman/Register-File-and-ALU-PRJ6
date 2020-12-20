----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:54:52 08/14/2020 
-- Design Name: 
-- Module Name:    hw6 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hw6 is
    Port ( clock : in STD_LOGIC;
	        --Ra : in  STD_LOGIC_VECTOR (3 downto 0);
           --Rb : in  STD_LOGIC_VECTOR (3 downto 0);
           --Rw : in  STD_LOGIC_VECTOR (3 downto 0);
           WrEn : in  STD_LOGIC;
			  --sel : in  STD_LOGIC_VECTOR (3 downto 0);
           Wdat_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Adat : out  STD_LOGIC_VECTOR (15 downto 0);
           Bdat : out  STD_LOGIC_VECTOR (15 downto 0));
end hw6;

architecture Behavioral of hw6 is

component register_file
    Port ( clk : in STD_LOGIC;
	        r_Ra : in  STD_LOGIC_VECTOR (3 downto 0);
           r_Rb : in  STD_LOGIC_VECTOR (3 downto 0);
           r_Rw : in  STD_LOGIC_VECTOR (3 downto 0);
           r_WrEn : in  STD_LOGIC;
           r_Wdat : in  STD_LOGIC_VECTOR (15 downto 0);
           r_Adat : out  STD_LOGIC_VECTOR (15 downto 0);
           r_Bdat : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component alu
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           a_sel : in  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
			  overflow : out  STD_LOGIC;
			  negative : out  STD_LOGIC;
			  zero : out  STD_LOGIC);
end component;

signal Adat_port : STD_LOGIC_VECTOR (15 downto 0);
signal Bdat_port : STD_LOGIC_VECTOR (15 downto 0);
signal A_port : STD_LOGIC_VECTOR (15 downto 0);
signal B_port : STD_LOGIC_VECTOR (15 downto 0);
signal s_port : STD_LOGIC_VECTOR (15 downto 0);
signal carry_port : STD_LOGIC;
signal overflow_port : STD_LOGIC;
signal negative_port : STD_LOGIC;
signal zero_port : STD_LOGIC;
signal Wdat : STD_LOGIC_VECTOR (15 downto 0);
signal Rw : STD_LOGIC_VECTOR (3 downto 0):="0000";
signal Ra : STD_LOGIC_VECTOR (3 downto 0);
signal Rb : STD_LOGIC_VECTOR (3 downto 0);
signal sel : STD_LOGIC_VECTOR (3 downto 0);
--signal WrEn : STD_LOGIC;
signal count : STD_LOGIC_VECTOR (4 downto 0):="00000";
signal count2 : STD_LOGIC_VECTOR (3 downto 0):="0000";
signal flag : STD_LOGIC_VECTOR (15 downto 0);


begin
rf: register_file port map (clk => clock, r_Ra => Ra, r_Rb => Rb, r_Rw => Rw, r_WrEn => WrEn, r_Wdat => Wdat, r_Adat => Adat_port, r_Bdat => Bdat_port);
al: alu port map (A => Adat_port, B => Bdat_port, a_sel => sel, S => s_port, carry_out => carry_port, overflow => overflow_port, negative => negative_port, zero => zero_port);


     process(clock)
	  begin
	       if rising_edge (clock) then
					if (count = "00000") then
					    flag(11 downto 8) <="0000";
						 flag(4 downto 3) <= "00";
						 flag(1) <= '0';
					    Wdat<= Wdat_in;
						 Rw <= Rw;
						 Ra <= "0000";
						 Adat <= Wdat_in;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
					elsif (count = "00001") then
          			 Wdat<= Wdat_in;
						 Rw <= Rw+1;
						 Rb <= "0001";
						 Bdat <= Wdat_in;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
               elsif (count = "00010") then	
                   Rw <= Rw;
                   Adat <= Wdat_in;						 
						 sel <= "0000";
						 count <= count +1;
               elsif (count = "00011") then			 
                   Rw <= Rw+1;
				       Ra <= "0001";
                   Rb <= "0010";						 
						 Wdat <= s_port;
						 Bdat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
                   count <= count +1;						 
					elsif (count = "00100") then
                   Rw <= Rw;
                   Adat <= Wdat;							 
						 sel <= "0010";
						 count <= count +1;
		 			elsif (count = "00101") then			 
                   Rw <= Rw+1;
				       Ra <= "0010";
                   Rb <= "0011";						 
						 Wdat <= s_port;
						 Bdat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
					elsif (count = "00110") then
                   Rw <= Rw;
                   Adat <= Wdat;						 
						 sel <= "1000";
						 count <= count +1;
		 			elsif (count = "00111") then			 
                   Rw <= Rw+1;
				       Ra <= "0011";
                   Rb <= "0100";						 
						 Wdat <= s_port;
						 Bdat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
               elsif (count = "01000") then
                   Rw <= Rw;
                   Adat <= Wdat;							 
						 sel <= "1010";
						 count <= count +1;
		 			elsif (count = "01001") then			 
                   Rw <= Rw+1;
				       Ra <= "0100";
                   Rb <= "0101";						 
						 Wdat <= s_port;
						 Bdat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
               elsif (count = "01010") then
                   Rw <= Rw;
                   Adat <= Wdat;						 
						 sel <= "0100";
						 count <= count +1;
               elsif (count = "01011") then			 
                   Rw <= Rw+1;
				       Ra <= "0101";
                   Rb <= "0110";						 
						 Wdat <= s_port;
						 Bdat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
               elsif (count = "01100") then
                   Rw <= Rw;			 
						 sel <= "0101";
						 count <= count +1;
               elsif (count = "01101") then			 
                   Rw <= Rw+1;
				       Ra <= "0111";					 
						 Wdat <= s_port;
						 Adat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
               elsif (count = "01110") then
                   Rw <= Rw;					
						 sel <= "0111";
						 count <= count +1;
               elsif (count = "01111") then			 
                   Rw <= Rw+1;
				       Ra <= "0111";
						 Wdat <= s_port;
						 flag(0)<=carry_port;
						 flag(5)<=overflow_port;
						 flag(6)<=zero_port;
						 flag(7)<=negative_port;
						 count <= count +1;
               elsif (count <= "10000") then
                   Rw <= Rw;	
                    count <= count +1;						 
					 
					end if;	 
					

		     end if;	 
		end process;		    
				 
				     
	       


end Behavioral;



