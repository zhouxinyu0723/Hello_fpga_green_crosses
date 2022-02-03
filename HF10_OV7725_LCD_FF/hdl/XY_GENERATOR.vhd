--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: xy_generator.vhd
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

USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity xy_generator is
-- the only three things to attention and are also intuitive is
-- send x y in the oder, so y*480+x continues increasing unless refresh
-- do not send x y too fast so that it surpass the index of inputing pixels
-- and do not send refresh signal too fast so that it surpasses the camera refresh (i.e. v_sync)
-- cordinate: 
-- x 479<-------0
--              |
--              |
--              \/
-- 
--              y
-- scan direction: top to bottom and right to left !!! 
-- but you can ignore it and imagine a right to left scan direction, the program is the same
-- the only difference appears when checking the real lcd display
--  <------------ |
--  <------------ |
--  <------------ |
--                \/
-- if you can not do the prediction in real time command line 52 and 54 in RPOINTs.vhd
port (
    -- the input is eventually defined by yourself
	data_valid_i : IN  std_logic; -- example
    index_i : in std_logic_vector(17 downto 0);
    clk : in std_logic;
    resetn: in std_logic;
    -- all the outputs are necessary
    x : out std_logic_vector(8 downto 0);
    y : out std_logic_vector(8 downto 0);
    xy_valid: out std_logic;
    xy_refresh: out std_logic
    
    --<other_ports>;
);
end xy_generator;
architecture architecture_xy_generator of xy_generator is
   -- signal, component etc. declarations
    signal x_drifter: std_logic_vector(8 downto 0);
    signal y_drifter: std_logic_vector(8 downto 0);
    signal index_drifter: std_logic_vector(17 downto 0);
    signal counter: std_logic_vector(1 downto 0);
    signal index_i_delay: std_logic_vector(17 downto 0);
begin
    
   -- architecture body
   process (clk)
   begin
   if(rising_edge(clk))then
        
        if(index_i=x"0" and index_i_delay>x"0")then
            counter <= counter+1;
        end if;
        index_i_delay <= index_i;
   end if;
   end process;
   process (clk,resetn)
   begin 
        if(resetn='0') then
        x_drifter <= (others => '0');
        y_drifter <= (others => '0');
        index_drifter <= (others => '0');
        else
        if(rising_edge(clk))then
            if(index_i=x"0" and index_i_delay>x"0")then
                x_drifter <= x_drifter +4;
                
                if(x_drifter=x"1e0")then
                    x_drifter <= (others => '0');
                    y_drifter <= y_drifter +1;
                    if(y_drifter=x"140") then
                        y_drifter <= (others => '0');
                    end if;
                end if;
                index_drifter <= index_drifter +4;
                if(index_drifter=x"25800") then
                    index_drifter <= (others => '0');
                end if;
                
            end if;
        end if;
        end if;
   end process;
   
   process (clk)
   
   begin
       if(rising_edge(clk))then
            if(data_valid_i = '1' and index_i = x"25a3") then  -- test right up corner
            -- simulate that you send the x=3 y=3 when recieving the pixel with index x"2700" (approximately in row 20)
                x <= (7 downto 0 => x"03", others =>'0');
                y <= (7 downto 0 => x"03", others =>'0');
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = x"2604") then  -- test up boarder
                x <= (7 downto 0 => x"64", others =>'0');
                y <= (7 downto 0 => x"03", others =>'0');
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = x"dbe4") then  -- test a point in the middle
            -- simulate that you send the x=100 y=100 when recieving the pixel with index x"ccc4" (kind of like in row 150) and so on
                x <= (7 downto 0 => x"64", others =>'0');
                y <= (7 downto 0 => x"64", others =>'0');
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = x"f205") then  -- test right boarder  
                x <= (7 downto 0 => x"05", others =>'0'); 
                y <= (7 downto 0 => x"70", others =>'0');
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = x"f3cc") then  -- test left boarder  
                x <= b"111001100";  -- 460
                y <= (7 downto 0 => x"70", others =>'0');
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = index_drifter + x"2000") then  -- test a drifting point
                x <= x_drifter; 
                y <= y_drifter;
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = x"2544C") then  
                x <= b"111001100"; -- 460
                y <= b"100101100"; -- 300
                xy_valid <= '1';
            elsif(data_valid_i = '1' and index_i = x"f1e") then  
                x <= b"111011110"; -- 478
                y <= b"100110110"; -- 310
                xy_valid <= '1';
            -- remember to reset xy_valid after finish sending, otherweise the fifo will continue reading x y
            -- x       <??><??><??><x1><??><??><x2><??><??><??>
            -- y       <??><??><??><y1><??><??><y2><??><??><??>
            --                      ___         ___
            -- xy_valid ___________/   \_______/   \_____________
            
            -- or you can send x y pairs at a maximum speed of one pair/cycle, in that case, keep xy_valid high continuously 
            -- x       <??><??><??><x1><x2><x3><x4><??><??><??>
            -- y       <??><??><??><y1><y2><y3><y4><??><??><??>
            --                      _______________
            -- xy_valid ___________/               \_____________
            else
                x <= (others =>'0');
                y <= (others =>'0');
                xy_valid <= '0';
            end if ;
            if(data_valid_i = '1' and (index_i = x"2000" )) then
            -- simulate that you send refresh when recieving pixel in row 8 in the next frame
                xy_refresh <='1';
            else
            -- remember to reset refresh, otherweise the fifo will continue reading refresh signal
                xy_refresh <='0';
            end if;
       end if;
   end process;
end architecture_xy_generator;
