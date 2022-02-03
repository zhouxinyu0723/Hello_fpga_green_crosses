--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: mux16.vhd
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

entity mux16 is
port (
    --<port_name> : <direction> <type>;
	IN0 : IN  std_logic_vector(15 downto 0); -- example
    IN1 : IN std_logic_vector(15 downto 0);  -- example
    SEL: IN std_logic;
    O:  OUT std_logic_vector(15 downto 0)
    --<other_ports>;
);
end mux16;
architecture architecture_mux16 of mux16 is


begin
    O <= IN0 WHEN(SEL='0') ELSE IN1;
   -- architecture body
end architecture_mux16;
