----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:23:24 10/09/2019 
-- Design Name: 
-- Module Name:    rs232 - Behavioral 
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

entity rs232 is

	port (  clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
			  RXD_i : in  STD_LOGIC;
           data_o : out  STD_LOGIC_VECTOR (7 downto 0) );

end rs232;

architecture Behavioral of rs232 is

	constant div_factor: integer := 1302;  -- 50_000_000/9600/4 (4 times oversampling)
	signal enable : STD_LOGIC;
	signal bit_cnt : integer range 0 to 63;
	signal data_buf : STD_LOGIC_VECTOR (7 downto 0);
	signal RXD_i_INT : STD_LOGIC := '1';

begin

-- generate enable signal with proper frequency
process(clk_i, rst_i)
	variable cnt: integer range 0 to 2048;
begin
	if rst_i='1' then
		enable <='0';
		cnt:=0;
	elsif Rising_Edge(clk_i) then
		if cnt = div_factor-1 then
			cnt := 0;
			enable <= '1';
		else
			cnt := cnt+1;
			enable <= '0';
		end if;
	end if;
end process;

-- main process reading RXD_i input (provided 4 times oversampling in respect to input speed)
process(clk_i, rst_i)
begin
	if rst_i='1' then
		data_o <= (others =>'0');
		data_buf <= (others =>'0');
		bit_cnt <= 0;
	elsif Rising_Edge(clk_i) then
		RXD_i_INT <= RXD_i;
		if enable = '1' then
			if (bit_cnt=0 and RXD_i_INT='1') then -- no start bit detected
				bit_cnt <= 0;
			else
				if bit_cnt=39 then
					bit_cnt <= 0;
				else
					bit_cnt <= bit_cnt+1;
				end if;
			end if;
			case bit_cnt is
				when 1|2 => if RXD_i_INT='1' then bit_cnt <=0; end if; -- start bit lasting to short
				when 6 => data_buf(0) <= RXD_i_INT;
				when 10 => data_buf(1) <= RXD_i_INT;
				when 14 => data_buf(2) <= RXD_i_INT;
				when 18 => data_buf(3) <= RXD_i_INT;
				when 22 => data_buf(4) <= RXD_i_INT;
				when 26 => data_buf(5) <= RXD_i_INT;
				when 30 => data_buf(6) <= RXD_i_INT;
				when 34 => data_buf(7) <= RXD_i_INT;
				when 38 => if RXD_i_INT='1' then data_o <= data_buf; end if; -- stop bit detected
				when others => null;
			end case;
		end if;
	end if;
end process;

end Behavioral;

