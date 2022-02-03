--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: mux6.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S010> <Package::256 VF>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity mux6 is
port (
    --<port_name> : <direction> <type>;
	IN0 : IN  std_logic_vector(5 downto 0); -- example
    IN1 : IN std_logic_vector(5 downto 0);  -- example
    SEL: IN std_logic;
    O:  OUT std_logic_vector(5 downto 0)
    --<other_ports>;
);
end mux6;
architecture architecture_mux6 of mux6 is


begin
    O <= IN0 WHEN(SEL='0') ELSE IN1;
   -- architecture body
end architecture_mux6;
