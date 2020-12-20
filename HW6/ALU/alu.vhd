----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:03 08/14/2020 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
			  overflow : out  STD_LOGIC;
			  negative : out  STD_LOGIC;
			  zero : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is

component mux4to1
    Port ( mux_in : in  STD_LOGIC_VECTOR (3 downto 0);
           mux_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC);
end component;

component mux2to1
    Port ( mux_in : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_sel : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;

component fulladder
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;


signal mux4_out1 : STD_LOGIC_VECTOR (15 downto 0); 
signal mux2_out1 : STD_LOGIC_VECTOR (15 downto 0);
signal mux2_out2 : STD_LOGIC_VECTOR (15 downto 0); 
signal s_out : STD_LOGIC_VECTOR (15 downto 0);
signal fa_cout : STD_LOGIC_VECTOR (15 downto 0);
signal zero_port : STD_LOGIC;

begin

M1: mux4to1 port map (mux_in(3) => B(0), mux_in(2) => sel(0), mux_in(1) => '1', mux_in(0) => '0', mux_sel => sel(2 downto 1), output => mux4_out1(0));
M2: mux2to1 port map (mux_in(0) => B(0) ,mux_in(1) => not B(0), mux_sel => sel(0), output => mux2_out1(0));
FA1: fulladder port map (a => A(0), b => mux2_out1(0), cin => mux4_out1(0), s => s_out(0), cout => fa_cout(0));
M3: mux2to1 port map (mux_in(0) => s_out(0) ,mux_in(1) => fa_cout(0), mux_sel => sel(3), output => mux2_out2(0)); 
      

	       loop1: for i in 1 to 15 generate
			            M1n: mux4to1 port map (mux_in(3) => B(i), mux_in(2) => fa_cout(i-1), mux_in(1) => '1', mux_in(0) => '0', mux_sel => sel(2 downto 1), output => mux4_out1(i));
                     M2n: mux2to1 port map (mux_in(0) => B(i) ,mux_in(1) => not B(i), mux_sel => sel(0), output => mux2_out1(i));
                     FAn: fulladder port map (a => A(i), b => mux2_out1(i), cin => mux4_out1(i), s => s_out(i), cout => fa_cout(i));
                     M3n: mux2to1 port map (mux_in(0) => s_out(i) ,mux_in(1) => fa_cout(i), mux_sel => sel(3), output => mux2_out2(i));
			        end generate loop1;
					  S <= mux2_out2;
					  
					  
                 --zero <= zero_port;
          process(mux2_out2,fa_cout(15))
          begin
			      if(sel = "0101") then
                  if(mux2_out2 = "0000000000000000" and fa_cout(15) = '0') then
                      zero<='1';
							 carry_out <= fa_cout(15);
					   elsif	(mux2_out2 = "0000000000000000" and fa_cout(15) = '1') then
					       carry_out<= not fa_cout(15);
					       zero <= '1';
						else
                     zero <= '0';
                     carry_out <= fa_cout(15);							 
						end if;
						overflow <= fa_cout(15) xor fa_cout(14);
                  negative <= mux2_out2(14) xor fa_cout(15) xor fa_cout(14);
					elsif(sel = "0100") then
                    if(mux2_out2 = "0000000000000000" and fa_cout(15) = '0') then
                       zero<='1';
					     else	
					        zero <= '0';
                    end if;
                    carry_out <= fa_cout(15);						  
						  overflow <= fa_cout(15) xor fa_cout(14);
                    negative <= mux2_out2(14) xor fa_cout(15) xor fa_cout(14);	
                else
					     zero <= '0';
                    carry_out <= '0';						  
						  overflow <= '0';
                    negative <= '0';	 					 
                end if;

          end process;					 
                 					  
	 
          



end Behavioral;

