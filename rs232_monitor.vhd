----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:13:58 10/09/2019 
-- Design Name: 
-- Module Name:    rs232_monitor - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rs232_monitor is

	port (  clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
			  RXD_i : in  STD_LOGIC;
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0) );
			  
end rs232_monitor;

architecture Behavioral of rs232_monitor is

	component hex2seg is
		port (  clk_i : in  STD_LOGIC;
				  rst_i : in  STD_LOGIC;
				  byte_i : in  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
				  seg1_o : out  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
				  seg2_o : out  STD_LOGIC_VECTOR (7 downto 0) := X"FF"  );
	end component;
	
	component display is
		port (  clk_i : in  STD_LOGIC;
				  rst_i : in  STD_LOGIC;
				  seg1_i : in  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
				  seg2_i : in  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
				  led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
				  led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0)  );
	end component;
	
	component rs232 is
		port (  clk_i : in  STD_LOGIC;
				  rst_i : in  STD_LOGIC;
				  RXD_i : in  STD_LOGIC;
				  data_o : out  STD_LOGIC_VECTOR (7 downto 0) );
	end component;

	signal seg1 : STD_LOGIC_VECTOR (7 downto 0);
	signal seg2 : STD_LOGIC_VECTOR (7 downto 0);
	signal byte : STD_LOGIC_VECTOR (7 downto 0); 

begin
		
	hex_decoder : hex2seg PORT MAP (
       clk_i => clk_i,
       rst_i => rst_i,
       byte_i => byte,
       seg1_o => seg1,
       seg2_o => seg2
      );
		
	disp_driver : display PORT MAP (
		clk_i => clk_i,
		rst_i => rst_i,
		seg1_i => seg1,
		seg2_i => seg2,
		led7_an_o => led7_an_o,
		led7_seg_o => led7_seg_o
	  );
		  
	rs232_receiver: rs232 PORT MAP(
		clk_i => clk_i,
		rst_i => rst_i,
		RXD_i => RXD_i,
		data_o => byte
	  );

end Behavioral;

