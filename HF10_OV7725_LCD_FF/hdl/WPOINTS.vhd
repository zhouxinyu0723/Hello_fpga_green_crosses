--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: WPOINTS.vhd
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity WPOINTS is
port (
    --<port_name> : <direction> <type>;
	SYS_CLK_I : IN  std_logic; -- example
    RESETN_I :in std_logic;
    
    fifo_empty : in std_logic;
    fifo_i : in std_logic_vector(17 downto 0);
    a_i : in std_logic_vector(7 downto 0);
    next_index_base: in std_logic_vector(17 downto 0);
    
    a_addr_o : out std_logic_vector(14 downto 0);
    a_we_o: out std_logic;
    a_d_o: out std_logic_vector(7 downto 0);
    fifo_re_o : out std_logic
    
    
    --<other_ports>;
);
end WPOINTS;
architecture architecture_WPOINTS of WPOINTS is
   -- signal, component etc. declarations
   type wp_fsm is(
        idle,
        read_fifo0,
        read_fifo1,
        
        refresh,
        
        pre_write_point0,
        pre_write_point1,
        pre_write_point2,
        pre_write_point3,
        
        erase,
        pre_refresh_erase,
        
        write_point00,
        write_point01,
        write_point02,
        write_point03,
        write_point04,
        write_point05,
        
        write_pointl0,
        write_pointl1,
        write_pointl2,
        write_pointl3,
        write_pointl4,
        write_pointl5,
        
        write_pointr0,
        write_pointr1,
        write_pointr2,
        write_pointr3,
        write_pointr4,
        write_pointr5,
        
        write_pointu00,
        write_pointu01,
        write_pointu02,
        write_pointu03,
        write_pointu04,
        write_pointu05,
        write_pointu10,
        write_pointu11,
        write_pointu12,
        write_pointu13,
        write_pointu14,
        write_pointu15,
        write_pointu20,
        write_pointu21,
        write_pointu22,
        write_pointu23,
        write_pointu24,
        write_pointu25,
        
        write_pointd00,
        write_pointd01,
        write_pointd02,
        write_pointd03,
        write_pointd04,
        write_pointd05,
        write_pointd10,
        write_pointd11,
        write_pointd12,
        write_pointd13,
        write_pointd14,
        write_pointd15,
        write_pointd20,
        write_pointd21,
        write_pointd22,
        write_pointd23,
        write_pointd24,
        write_pointd25
   
   );
   signal s_state: wp_fsm;
	signal index_base : std_logic_vector(19 downto 0); -- example
	signal next_erase_virtual_index : std_logic_vector(19 downto 0) ; -- examplw
    signal next_erase_true_index : std_logic_vector(19 downto 0) ; -- examplw
    signal erase_target_virtual_index : std_logic_vector(19 downto 0) ; -- example
    signal x : std_logic_vector(8 downto 0);
    signal y : std_logic_vector(8 downto 0);
    signal xy_virtual_index : std_logic_vector(20 downto 0);
    signal xy_true_index : std_logic_vector(20 downto 0);
    signal buf8bits : std_logic_vector(7 downto 0);
begin

   -- architecture body
   process(SYS_CLK_I,RESETN_I)
   begin
       if(RESETN_I = '0')then
            fifo_re_o <= '0';
            a_addr_o <= (others=>'0');
            a_we_o <= '0';
            a_d_o <= (others=>'0');
            index_base <= (others=>'0');
            next_erase_virtual_index <= (others=>'0');
            next_erase_true_index <= (others=>'0');
            erase_target_virtual_index <= (others=>'0');
            x <= (others=>'0');
            y <= (others=>'0');
            xy_virtual_index <= (others=>'0');
            xy_true_index <= (others=>'0');
            buf8bits <= (others=>'0');
            s_state <= idle;
       elsif(rising_edge(SYS_CLK_I))then
            case s_state is
                when idle=>
                    a_addr_o <= (others=>'0');
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                    if(fifo_empty = '0') then
                        s_state <= read_fifo0;
                    else
                        s_state <= idle;
                    end if;
                when read_fifo0=>
                    fifo_re_o <='1';
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                    s_state <= read_fifo1;
                when read_fifo1=>
                    s_state <= read_fifo1;
                    if(fifo_i = x"3ffff") then
                        s_state <= pre_refresh_erase;
                    else
                        x <= fifo_i(17 downto 9);
                        y <= fifo_i(8 downto 0);
                        s_state <= pre_write_point0; 
                    end if;
                when pre_refresh_erase=>
                    a_addr_o <= next_erase_true_index(17 downto 3);
                    a_we_o <= '1';
                    a_d_o <= (others=>'0');
                    
                    next_erase_true_index <= next_erase_true_index + 8;
                    if(next_erase_true_index >= x"28000") then
                        next_erase_true_index <= (others=>'0');
                    end if;
                    next_erase_virtual_index <= next_erase_virtual_index +8;
                    
                    if(next_erase_virtual_index >=  x"257ff")then
                        s_state <= refresh;
                    else
                        s_state <= pre_refresh_erase;
                    end if;
                when refresh =>
                    next_erase_virtual_index <= (others => '0');
                    erase_target_virtual_index <= (others => '0');
                    index_base <= b"00" & next_index_base;
                    next_erase_true_index <= b"00" & next_index_base;
                    if(fifo_empty = '0') then
                        s_state <= read_fifo0;
                    else
                        s_state <= idle;
                    end if;
                when pre_write_point0=>
                    xy_virtual_index <= y * x"1e0";
                    
                    s_state <= pre_write_point1;
                when pre_write_point1=>
                    xy_virtual_index <= xy_virtual_index +x;
                    s_state <= pre_write_point2;
                when pre_write_point2=>
                    xy_true_index <= xy_virtual_index +index_base;------------------
                    erase_target_virtual_index <= xy_virtual_index(19 downto 0) + x"780";
                    --next_erase_true_index <= next_erase_virtual_index(19 downto 0) +next_index_base;-------
                    
                    s_state <= pre_write_point3;
                when pre_write_point3=>
                    if(xy_true_index>= x"28000")then
                        xy_true_index <= xy_true_index-x"28000";
                    end if;
                    --if(next_erase_true_index>= x"30D40")then-----------------------------------
                    --    next_erase_true_index <= next_erase_true_index-x"30D40";----------------------
                    --end if;----------------------
                    if (erase_target_virtual_index > x"257ff") then
                        erase_target_virtual_index <= x"257ff";
                    end if;
                    if(erase_target_virtual_index>next_erase_virtual_index)then
                        s_state <= erase; ---erase
                    else
                        s_state <= write_point00;
                    end if;
                when erase =>
                    a_addr_o <= next_erase_true_index(17 downto 3);
                    a_we_o <= '1';
                    a_d_o <= (others=>'0');
                    
                    next_erase_true_index <= next_erase_true_index + 8;
                    if(next_erase_true_index >= x"28000") then
                        next_erase_true_index <= (others=>'0');
                    end if;
                    next_erase_virtual_index <= next_erase_virtual_index +8;
                    
                    if(next_erase_virtual_index >=  erase_target_virtual_index)then
                        s_state <= write_point00;
                    else
                        s_state <= erase;
                    end if;
                ------------------------------------------
                ----      write the center byte      -----
                ------------------------------------------
                when write_point00 =>
                    a_addr_o <= xy_true_index(17 downto 3);
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                    s_state <= write_point01;
                when write_point01 =>
                    s_state <= write_point02;
                when write_point02 =>
                    s_state <= write_point03;
                when write_point03 =>
                    a_addr_o <= xy_true_index(17 downto 3);
                    a_we_o <= '0';
                    buf8bits <= a_i;
                    s_state <= write_point04;
                when write_point04 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or b"00001111";
                    when b"001" =>
                        buf8bits <= buf8bits or b"00011111";
                    when b"010" =>
                        buf8bits <= buf8bits or b"00111111";
                    when b"011" =>
                        buf8bits <= buf8bits or b"01111111";
                    when b"100" =>
                        buf8bits <= buf8bits or b"11111110";
                    when b"101" =>
                        buf8bits <= buf8bits or b"11111100";
                    when b"110" =>
                        buf8bits <= buf8bits or b"11111000";
                    when b"111" =>
                        buf8bits <= buf8bits or b"11110000";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_point05;
                when write_point05 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits; 
                    s_state <= write_pointl0;
                ------------------------------------------
                ----       write the left byte       -----
                ------------------------------------------
                when write_pointl0 =>
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                    if(xy_virtual_index(3 downto 0) < b"101" or x(8 downto 3)=x"3b")then
                        s_state <= write_pointr0;
                    else
                        s_state <= write_pointl1;
                        if(xy_true_index(17 downto 3) = x"5000") then
                            a_addr_o <= (0=>'1', others => '0');
                        else
                            a_addr_o <= xy_true_index(17 downto 3) + 1;
                        end if;
                    end if;
                when write_pointl1 =>
                    s_state <= write_pointl2;
                when write_pointl2 =>
                    s_state <= write_pointl3;
                when write_pointl3 =>
                    buf8bits <= a_i;
                    s_state <= write_pointl4;
                when write_pointl4 =>
                    case xy_true_index(2 downto 0) is
                    when b"101" =>
                        buf8bits <= buf8bits or b"00000001";
                    when b"110" =>
                        buf8bits <= buf8bits or b"00000011";
                    when b"111" =>
                        buf8bits <= buf8bits or b"00000111";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointl5;
                when write_pointl5 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointr0;
                ------------------------------------------
                ----       write the right byte       -----
                ------------------------------------------
                when write_pointr0 =>
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                    if(xy_true_index(3 downto 0) > b"010" or x(8 downto 3)=x"0")then
                        s_state <= write_pointu00;
                    else
                        s_state <= write_pointr1;
                        if(xy_true_index(17 downto 3) = x"0") then
                            a_addr_o <= b"100111111111111"; -- 4fff
                        else
                            a_addr_o <= xy_true_index(17 downto 3) - 1;
                        end if;
                    end if;
                when write_pointr1 =>
                    s_state <= write_pointr2;
                when write_pointr2 =>
                    s_state <= write_pointr3;
                when write_pointr3 =>
                    buf8bits <= a_i;
                    s_state <= write_pointr4;
                when write_pointr4 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or b"11100000";
                    when b"001" =>
                        buf8bits <= buf8bits or b"11000000";
                    when b"010" =>
                        buf8bits <= buf8bits or b"10000000";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointr5;
                when write_pointr5 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointu00;
                ------------------------------------------
                ----       write the up0 byte        -----
                ------------------------------------------ 
				when write_pointu00 =>
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                    if(xy_virtual_index(17 downto 3) < x"b4") then
                        s_state <= write_pointu10; 
                    else
                        s_state <= write_pointu01;
                        if(xy_true_index(17 downto 3) < x"b4") then
                            a_addr_o <= xy_true_index(17 downto 3) + b"100111101001100"; --x"5000" - x"b4"
                        else
                            a_addr_o <= xy_true_index(17 downto 3) - x"b4";
                        end if;
                    end if;
                when write_pointu01 =>
                    s_state <= write_pointu02;
                when write_pointu02 =>
                    s_state <= write_pointu03;
                when write_pointu03 =>
                    buf8bits <= a_i;
                    s_state <= write_pointu04;
                when write_pointu04 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or x"01";
                    when b"001" =>
                        buf8bits <= buf8bits or x"02";
                    when b"010" =>
                        buf8bits <= buf8bits or x"04";
                    when b"011" =>
                        buf8bits <= buf8bits or x"08";
                    when b"100" =>
                        buf8bits <= buf8bits or x"10";
                    when b"101" =>
                        buf8bits <= buf8bits or x"20";
                    when b"110" =>
                        buf8bits <= buf8bits or x"40";
                    when b"111" =>
                        buf8bits <= buf8bits or x"80";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointu05;
                when write_pointu05 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointu10;
                ------------------------------------------
                ----       write the up1 byte        -----
                ------------------------------------------ 
                when write_pointu10 =>
                    if(xy_virtual_index(17 downto 3) < x"78") then
                        s_state <= write_pointu20;
                    else
                        s_state <= write_pointu11;
                        if(xy_true_index(17 downto 3) < x"78") then
                            a_addr_o <= xy_true_index(17 downto 3) + b"100111110001000"; --x"5000" - x"78"
                        else
                            a_addr_o <= xy_true_index(17 downto 3) - x"78";
                        end if;
                    end if;
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                when write_pointu11 =>
                    s_state <= write_pointu12;
                when write_pointu12 =>
                    s_state <= write_pointu13;
                when write_pointu13 =>
                    buf8bits <= a_i;
                    s_state <= write_pointu14;
                when write_pointu14 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or x"01";
                    when b"001" =>
                        buf8bits <= buf8bits or x"02";
                    when b"010" =>
                        buf8bits <= buf8bits or x"04";
                    when b"011" =>
                        buf8bits <= buf8bits or x"08";
                    when b"100" =>
                        buf8bits <= buf8bits or x"10";
                    when b"101" =>
                        buf8bits <= buf8bits or x"20";
                    when b"110" =>
                        buf8bits <= buf8bits or x"40";
                    when b"111" =>
                        buf8bits <= buf8bits or x"80";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointu15;
                when write_pointu15 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointu20;
                ------------------------------------------
                ----       write the up2 byte        -----
                ------------------------------------------ 
				when write_pointu20 =>
                    if(xy_virtual_index(17 downto 3) < x"3c") then
                        s_state <= write_pointd00;
                    else
                        s_state <= write_pointu21;
                        if(xy_true_index(17 downto 3) < x"3c") then
                            a_addr_o <= xy_true_index(17 downto 3) + b"100111111000100"; --x"5000" - x"3c"
                        else
                            a_addr_o <= xy_true_index(17 downto 3) - x"3c";
                        end if;
                    end if;
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                when write_pointu21 =>
                    s_state <= write_pointu22;
                when write_pointu22 =>
                    s_state <= write_pointu23;
                when write_pointu23 =>
                    buf8bits <= a_i;
                    s_state <= write_pointu24;
                when write_pointu24 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or x"01";
                    when b"001" =>
                        buf8bits <= buf8bits or x"02";
                    when b"010" =>
                        buf8bits <= buf8bits or x"04";
                    when b"011" =>
                        buf8bits <= buf8bits or x"08";
                    when b"100" =>
                        buf8bits <= buf8bits or x"10";
                    when b"101" =>
                        buf8bits <= buf8bits or x"20";
                    when b"110" =>
                        buf8bits <= buf8bits or x"40";
                    when b"111" =>
                        buf8bits <= buf8bits or x"80";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointu25;
                when write_pointu25 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointd00;
                ------------------------------------------
                ----      write the down0 byte       -----
                ------------------------------------------ 
                when write_pointd00 =>
                    if(xy_virtual_index(17 downto 3) > x"4a4c") then
                        s_state <= write_pointd10;
                    else
                        s_state <= write_pointd01;
                        if(xy_true_index(17 downto 3) > x"4f4c") then
                            a_addr_o <= xy_true_index(17 downto 3) - b"100111101001100"; --x"5000" - x"b4"
                        else
                            a_addr_o <= xy_true_index(17 downto 3) + x"b4";
                        end if;
                    end if;
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                when write_pointd01 =>
                    s_state <= write_pointd02;
                when write_pointd02 =>
                    s_state <= write_pointd03;
                when write_pointd03 =>
                    buf8bits <= a_i;
                    s_state <= write_pointd04;
                when write_pointd04 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or x"01";
                    when b"001" =>
                        buf8bits <= buf8bits or x"02";
                    when b"010" =>
                        buf8bits <= buf8bits or x"04";
                    when b"011" =>
                        buf8bits <= buf8bits or x"08";
                    when b"100" =>
                        buf8bits <= buf8bits or x"10";
                    when b"101" =>
                        buf8bits <= buf8bits or x"20";
                    when b"110" =>
                        buf8bits <= buf8bits or x"40";
                    when b"111" =>
                        buf8bits <= buf8bits or x"80";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointd05;
                when write_pointd05 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointd10;
                ------------------------------------------
                ----      write the down1 byte       -----
                ------------------------------------------ 
                when write_pointd10 =>
                    if(xy_virtual_index(17 downto 3) > x"4a88") then
                        s_state <= write_pointd20;
                    else
                        s_state <= write_pointd11;
                        if(xy_true_index(17 downto 3) > x"4f88") then
                                a_addr_o <= xy_true_index(17 downto 3) - b"100111110001000"; --x"5000" - x"78"
                        else
                        a_addr_o <= xy_true_index(17 downto 3) + x"78";
                        end if;
                    end if;
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                when write_pointd11 =>
                    s_state <= write_pointd12;
                when write_pointd12 =>
                    s_state <= write_pointd13;
                when write_pointd13 =>
                    buf8bits <= a_i;
                    s_state <= write_pointd14;
                when write_pointd14 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or x"01";
                    when b"001" =>
                        buf8bits <= buf8bits or x"02";
                    when b"010" =>
                        buf8bits <= buf8bits or x"04";
                    when b"011" =>
                        buf8bits <= buf8bits or x"08";
                    when b"100" =>
                        buf8bits <= buf8bits or x"10";
                    when b"101" =>
                        buf8bits <= buf8bits or x"20";
                    when b"110" =>
                        buf8bits <= buf8bits or x"40";
                    when b"111" =>
                        buf8bits <= buf8bits or x"80";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointd15;
                when write_pointd15 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    s_state <= write_pointd20;
                ------------------------------------------
                ----      write the down2 byte       -----
                ------------------------------------------ 
                when write_pointd20 =>
                    if(xy_virtual_index(17 downto 3) > x"4AC4") then
                        if(fifo_empty = '0') then
                            s_state <= read_fifo0;
                        else
                            s_state <= idle;
                        end if;
                    else
                        s_state <= write_pointd21;
                        if(xy_true_index(17 downto 3) > x"4fc4") then
                            a_addr_o <= xy_true_index(17 downto 3) - b"100111111000100"; --x"5000" - x"3c"
                        else
                            a_addr_o <= xy_true_index(17 downto 3) + x"3c";
                        end if;
                    end if;
                    a_we_o <= '0';
                    a_d_o <= (others=>'0');
                when write_pointd21 =>
                    s_state <= write_pointd22;
                when write_pointd22 =>
                    s_state <= write_pointd23;
                when write_pointd23 =>
                    buf8bits <= a_i;
                    s_state <= write_pointd24;
                when write_pointd24 =>
                    case xy_true_index(2 downto 0) is
                    when b"000" =>
                        buf8bits <= buf8bits or x"01";
                    when b"001" =>
                        buf8bits <= buf8bits or x"02";
                    when b"010" =>
                        buf8bits <= buf8bits or x"04";
                    when b"011" =>
                        buf8bits <= buf8bits or x"08";
                    when b"100" =>
                        buf8bits <= buf8bits or x"10";
                    when b"101" =>
                        buf8bits <= buf8bits or x"20";
                    when b"110" =>
                        buf8bits <= buf8bits or x"40";
                    when b"111" =>
                        buf8bits <= buf8bits or x"80";
                    when others =>
                        buf8bits <= buf8bits;
                    end case;
                    s_state <= write_pointd25;
                when write_pointd25 =>                
                    a_we_o <= '1';
                    a_d_o <= buf8bits;     
                    if(fifo_empty = '0') then
                        s_state <= read_fifo0;
                    else
                        s_state <= idle;
                    end if;
                when others =>
                    s_state <= idle;
            end case;
       end if;
   end process;
end architecture_WPOINTS;
