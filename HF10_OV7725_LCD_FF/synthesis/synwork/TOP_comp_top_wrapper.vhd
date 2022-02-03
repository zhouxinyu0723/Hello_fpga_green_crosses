--
-- Synopsys
-- Vhdl wrapper for top level design, written on Tue Jan  4 12:40:59 2022
--
library ieee;
use ieee.std_logic_1164.all;

entity wrapper_for_mux5 is
   port (
      IN0 : in std_logic_vector(4 downto 0);
      IN1 : in std_logic_vector(4 downto 0);
      SEL : in std_logic;
      O : out std_logic_vector(4 downto 0)
   );
end wrapper_for_mux5;

architecture architecture_mux5 of wrapper_for_mux5 is

component mux5
 port (
   IN0 : in std_logic_vector (4 downto 0);
   IN1 : in std_logic_vector (4 downto 0);
   SEL : in std_logic;
   O : out std_logic_vector (4 downto 0)
 );
end component;

signal tmp_IN0 : std_logic_vector (4 downto 0);
signal tmp_IN1 : std_logic_vector (4 downto 0);
signal tmp_SEL : std_logic;
signal tmp_O : std_logic_vector (4 downto 0);

begin

tmp_IN0 <= IN0;

tmp_IN1 <= IN1;

tmp_SEL <= SEL;

O <= tmp_O;



u1:   mux5 port map (
		IN0 => tmp_IN0,
		IN1 => tmp_IN1,
		SEL => tmp_SEL,
		O => tmp_O
       );
end architecture_mux5;
