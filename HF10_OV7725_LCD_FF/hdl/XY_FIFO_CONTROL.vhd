--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: xy_fifo_control.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S010> <Package::144 TQ>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity xy_fifo_control is
port (
    --<port_name> : <direction> <type>;
    sys_clk_i : in std_logic;
    resetn_i: in std_logic;
	x : IN  std_logic_vector(8 downto 0); -- example
    y : IN  std_logic_vector(8 downto 0);
    xy_valid: in std_logic;
    xy_refresh: in std_logic;
    
    data_o : OUT std_logic_vector(17 downto 0);  -- example
    we: out std_logic
    --<other_ports>;
);
end xy_fifo_control;
architecture architecture_xy_fifo_control of xy_fifo_control is
   -- signal, component etc. declarations
	signal x_dly : std_logic_vector(8 downto 0); -- example
	signal y_dly : std_logic_vector(8 downto 0) ; -- example
    signal xy_valid_dly: std_logic;
    signal xy_refresh_dly: std_logic;

begin
    process (sys_clk_i,resetn_i)
    begin
    if (resetn_i = '0') then
        x_dly <= (others => '0');
        y_dly <= (others => '0');
        xy_valid_dly <=  '0';
        xy_refresh_dly  <= '0';
    elsif (rising_edge(sys_clk_i))then
        x_dly <= x;
        y_dly <= y;
        xy_valid_dly <= xy_valid;
        xy_refresh_dly  <= xy_refresh;
      
    end if;
    end process;

    process (sys_clk_i,resetn_i)
    begin
    if(resetn_i = '0')then
        data_o <= (others => '0');
        we <= '0';
        
    elsif (rising_edge(sys_clk_i))then
        if (xy_refresh_dly='1') then
            data_o <= (others=>'1');
            we <= '1';
        elsif(xy_valid_dly)then
                data_o <= x_dly & y_dly;
                we <= '1';
            else 
                data_o <= (others=>'0');
                we <= '0';
            end if;
        end if;
    end process;
   -- architecture body
end architecture_xy_fifo_control;
