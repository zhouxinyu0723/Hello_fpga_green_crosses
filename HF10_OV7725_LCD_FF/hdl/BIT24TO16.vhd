--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: BIT24TO16.vhd
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

entity BIT24TO16 is
port (
    --<port_name> : <direction> <type>;
	in24 : IN  std_logic_vector(23 downto 0);
    out16 : OUT std_logic_vector(15 downto 0)
    --<other_ports>;
);
end BIT24TO16;
architecture architecture_BIT24TO16 of BIT24TO16 is
   -- signal, component etc. declarations

begin
    out16 <= in24(23 downto 19) & in24(15 downto 10) & in24(7 downto 3);
   -- architecture body
end architecture_BIT24TO16;
