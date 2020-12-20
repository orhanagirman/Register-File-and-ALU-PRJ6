--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:10:45 08/18/2020
-- Design Name:   
-- Module Name:   C:/Users/TUTEL-50/Desktop/HW6/HW6/test.vhd
-- Project Name:  HW6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: hw6
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
 
    COMPONENT hw6
    PORT(
         clock : IN  std_logic;
         --Rw : IN  std_logic_vector(3 downto 0);
         WrEn : IN  std_logic;
         Wdat_in : IN  std_logic_vector(15 downto 0);
         Adat : OUT  std_logic_vector(15 downto 0);
         Bdat : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   --signal Rw : std_logic_vector(3 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Wdat_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Adat : std_logic_vector(15 downto 0);
   signal Bdat : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hw6 PORT MAP (
          clock => clock,
          --Rw => Rw,
          WrEn => WrEn,
          Wdat_in => Wdat_in,
          Adat => Adat,
          Bdat => Bdat
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		--Rw <= "0000";
		WrEn <= '1';
		Wdat_in<= x"55AA";
      wait for 10 ns;
		--Rw <= "0001";
		WrEn <= '1';
		Wdat_in<= x"AA55";		

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
