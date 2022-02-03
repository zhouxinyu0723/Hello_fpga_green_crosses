--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RPOINTS.vhd
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
-- Author: xinyu zhou   https://www.linkedin.com/in/xin-zhou-3536b6198/
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RPOINTS is


port (
    --<port_name> : <direction> <type>;
	sys_clock_i : IN  std_logic; -- example
    resetn_i : in std_logic;
    v_sync_re : in std_logic;
    data_valid_i : in std_logic;
    b_addr_o : out std_logic_vector(14 downto 0);
    b_out_in : in std_logic_vector(7 downto 0);
    sel : OUT std_logic; -- example
    next_index_base: out std_logic_vector(19 downto 0)
    --<other_ports>;
);
end RPOINTS;
architecture architecture_RPOINTS of RPOINTS is
   -- signal, component etc. declarations
    signal index_base: std_logic_vector(19 downto 0) ;
    signal index_true: std_logic_vector(19 downto 0) ;
begin
    process(resetn_i,sys_clock_i)
    begin
    if(resetn_i='0')then
        next_index_base <=(others=>'0');
    elsif(rising_edge(sys_clock_i))then
        if(index_base<x"2800") then
            next_index_base <= index_base + x"25800";  --command this line if you can not do the detection in real time 
        else 
            next_index_base <= index_base - x"2800";  --command this line if you can not do the detection in real time 
        end if; 
    end if;
    end process;
    
    process(resetn_i,sys_clock_i)
    begin
    if(resetn_i='0')then
        index_base <=(others=>'0');
        index_true  <=(others=>'0');
    elsif(rising_edge(sys_clock_i))then
        if(v_sync_re) then
            index_base <= next_index_base;
            index_true <= next_index_base;
        elsif(data_valid_i='1')then
                index_true <= index_true + 1;
                if(index_true>=x"28000")then
                    index_true <= (others=>'0');
                end if;
            end if;
    end if;
    end process;
    b_addr_o <= index_true(17 downto 3);
      
    process(resetn_i,sys_clock_i)
    begin
    if(resetn_i='0')then
        sel <='0';
    elsif(rising_edge(sys_clock_i))then
        case index_true(2 downto 0) is
            when b"000" =>
                sel <= b_out_in(0);
            when b"001" =>
                sel <= b_out_in(1);
            when b"010" =>
                sel <= b_out_in(2);
            when b"011" =>
                sel <= b_out_in(3);
            when b"100" =>
                sel <= b_out_in(4);
            when b"101" =>
                sel <= b_out_in(5);
            when b"110" =>
                sel <= b_out_in(6);
            when b"111" =>
                sel <= b_out_in(7);
            when others =>
                sel <='0';
        end case;
    end if;
    end process;

end architecture_RPOINTS;
