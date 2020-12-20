--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:57:26 08/14/2020
-- Design Name:   
-- Module Name:   C:/Users/TUTEL-50/Desktop/ALU/alu/test.vhd
-- Project Name:  alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         sel : IN  std_logic_vector(3 downto 0);
         carry_out : OUT  std_logic;
			overflow : OUT  std_logic;
			negative : OUT  std_logic;
			zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal sel : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal carry_out : std_logic;
	signal overflow : std_logic;
	signal negative : std_logic;
	signal zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          A => A,
          B => B,
          S => S,
          sel => sel,
          carry_out => carry_out,
			 overflow => overflow,
			 negative => negative,
			 zero => zero
			 
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		A <= x"aa55";
		B <= x"54aa";
		sel <= "0101";
      wait for 100 ns;
		A <= x"0000";
		B <= x"0000";
		sel <= "0101";
      wait for 100 ns;
		A <= x"00ff";
		B <= x"ff01";
		sel <= "1000";
      wait for 100 ns;		

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
