----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:24:07 10/09/2019 
-- Design Name: 
-- Module Name:    display - Behavioral 
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

entity display is

	port (  clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           seg1_i : in  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
			  seg2_i : in  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0) );

end display;

architecture Behavioral of display is

	signal mux_clk : STD_LOGIC := '0'; 
	signal mux_clk_cnt : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
	signal disp_select : STD_LOGIC := '0';

begin

process (clk_i) begin
	if rising_edge(clk_i) then
		mux_clk_cnt <= mux_clk_cnt + 1;
		if mux_clk_cnt = 50000 then   -- 50 MHz / 50000 = 1 kHz
			mux_clk_cnt <= X"0000";
			mux_clk <= not mux_clk;
		end if;
	end if;
end process;

process (mux_clk) begin
	if rising_edge(mux_clk) then
		if rst_i = '1' then	-- all segments lightened up
			led7_an_o <= "0000";
			led7_seg_o <= "00000000";
		else
			if disp_select = '0' then
				led7_an_o <= "1101";
				led7_seg_o <= seg1_i;
				disp_select <= '1';
			else 
				led7_an_o <= "1110";
				led7_seg_o <= seg2_i;
				disp_select <= '0';
			end if;
		end if;
	end if;
end process;

end Behavioral;

