--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:14:25 10/24/2019
-- Design Name:   
-- Module Name:   /home/lab430/RS-232_port_monitor/rs232_monitor_tb.vhd
-- Project Name:  RS-232_port_monitor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rs232_monitor
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY rs232_monitor_tb IS
END rs232_monitor_tb;
 
ARCHITECTURE behavior OF rs232_monitor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rs232_monitor
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         RXD_i : IN  std_logic;
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal RXD_i : std_logic := '0';

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rs232_monitor PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          RXD_i => RXD_i,
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		RXD_i <= '1';
		
		rst_i <= '1'; -- hold reset state for 100 ns.
      wait for 100 us;	
		rst_i <= '0'; 
      
		wait for 500 us;
		
		-- 0x39
		RXD_i <= '0'; -- start bit
		wait for 104 us;
		RXD_i <= '1';
		wait for 104 us;
		RXD_i <= '0';
		wait for 104 us;
		RXD_i <= '0';
		wait for 104 us;
		RXD_i <= '1';
		wait for 104 us;
		RXD_i <= '1';
		wait for 104 us;
		RXD_i <= '1';
		wait for 104 us;
		RXD_i <= '0';
		wait for 104 us;
		RXD_i <= '0';
		wait for 104 us;
		RXD_i <= '1'; -- stop bit
		wait for 104 us;

		wait for 5 ms;
		
		wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;



END;
