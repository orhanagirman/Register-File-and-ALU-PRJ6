--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:39:16 08/14/2020
-- Design Name:   
-- Module Name:   C:/Users/TUTEL-50/Desktop/Register_File/register_file/test.vhd
-- Project Name:  register_file
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register_file
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
 
    COMPONENT register_file
    PORT(
         clock : IN  std_logic;
         Ra : IN  std_logic_vector(3 downto 0);
         Rb : IN  std_logic_vector(3 downto 0);
         Rw : IN  std_logic_vector(3 downto 0);
         WrEn : IN  std_logic;
         Wdat : IN  std_logic_vector(15 downto 0);
         Adat : OUT  std_logic_vector(15 downto 0);
         Bdat : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal Ra : std_logic_vector(3 downto 0) := (others => '0');
   signal Rb : std_logic_vector(3 downto 0) := (others => '0');
   signal Rw : std_logic_vector(3 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Wdat : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Adat : std_logic_vector(15 downto 0);
   signal Bdat : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register_file PORT MAP (
          clock => clock,
          Ra => Ra,
          Rb => Rb,
          Rw => Rw,
          WrEn => WrEn,
          Wdat => Wdat,
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
		Wdat <= "1000110101110011";
		WrEn <= '1';
		Rw <= "0000";
		Ra <= "1001";
		Rb <= "1100";
      wait for 10 ns;
		Wdat <= "1000110101111111";
		Rw <= "0001";
		Ra <= "1000";
      Rb <= "1101";		
		
	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
