----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:07 10/09/2019 
-- Design Name: 
-- Module Name:    hex2seg - Behavioral 
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

entity hex2seg is

	port (  clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
			  byte_i : in  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
           seg1_o : out  STD_LOGIC_VECTOR (7 downto 0) := X"FF";
			  seg2_o : out  STD_LOGIC_VECTOR (7 downto 0) := X"FF"  );

end hex2seg;

architecture Behavioral of hex2seg is

begin

process (clk_i) begin
	case byte_i(7 downto 4) is 
		when X"0" => seg1_o <= "00000011";
		when X"1" => seg1_o <= "10011111";
		when X"2" => seg1_o <= "00100101";
		when X"3" => seg1_o <= "00001101";
		when X"4" => seg1_o <= "10011001";
		when X"5" => seg1_o <= "01001001";
		when X"6" => seg1_o <= "01000001";
		when X"7" => seg1_o <= "00011111";
		when X"8" => seg1_o <= "00000001";
		when X"9" => seg1_o <= "00001001";
		when X"a" => seg1_o <= "00010001";
		when X"b" => seg1_o <= "11000001";
		when X"c" => seg1_o <= "01100011";
		when X"d" => seg1_o <= "10000101";
		when X"e" => seg1_o <= "01100001";
		when X"f" => seg1_o <= "01110001";
		when others => seg1_o <= "11111111";
	end case;
end process;
	
process (clk_i) begin
	case byte_i(3 downto 0) is 
		when X"0" => seg2_o <= "00000011";
		when X"1" => seg2_o <= "10011111";
		when X"2" => seg2_o <= "00100101";
		when X"3" => seg2_o <= "00001101";
		when X"4" => seg2_o <= "10011001";
		when X"5" => seg2_o <= "01001001";
		when X"6" => seg2_o <= "01000001";
		when X"7" => seg2_o <= "00011111";
		when X"8" => seg2_o <= "00000001";
		when X"9" => seg2_o <= "00001001";
		when X"a" => seg2_o <= "00010001";
		when X"b" => seg2_o <= "11000001";
		when X"c" => seg2_o <= "01100011";
		when X"d" => seg2_o <= "10000101";
		when X"e" => seg2_o <= "01100001";
		when X"f" => seg2_o <= "01110001";
		when others => seg2_o <= "11111111";
	end case;
end process;

end Behavioral;

