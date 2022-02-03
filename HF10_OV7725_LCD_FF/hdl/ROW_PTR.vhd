--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: ROW_PTR.vhd
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

entity ROW_PTR is
port (
    --<port_name> : <direction> <type>;
    RESETN_I                           : in STD_LOGIC;
    SYS_CLK_I                          : in STD_LOGIC;
	DATA_VALID_I : in  std_logic; -- example
    
    V_SYNC_I: in std_logic;
    RAM_ADDR    : in std_logic_vector(9 downto 0);
    ROW_PTR_O : OUT std_logic_vector(9 downto 0);  -- example
    INDEX : OUT std_logic_vector(17 downto 0);
    --<other_ports>;
    init : out std_logic;
     v_sync_re                                    :out STD_LOGIC
);
end ROW_PTR;

architecture architecture_ROW_PTR of ROW_PTR is
   -- signal, component etc. declarations
	SIGNAL s_v_sync_dly                                   : STD_LOGIC;
    SIGNAL s_v_sync_dly1                                  : STD_LOGIC;
    
    
    SIGNAL s_already_add1                                 : STD_LOGIC; 
    signal init_finished : std_logic;
    
    

begin
    v_sync_re               <= s_v_sync_dly AND (NOT(s_v_sync_dly1));
    

    PROCESS(RESETN_I,SYS_CLK_I)
    BEGIN
        IF(RESETN_I='0') THEN
            ROW_PTR_O <= (others => '0');
            INDEX <= (others => '0');
            s_v_sync_dly <= '0';
            s_v_sync_dly1 <= '0';
            s_already_add1 <='1';
            init <= '0';
            init_finished <= '0';
        ELSIF(RISING_EDGE(sys_clk_i)) THEN 
			s_v_sync_dly      <= V_SYNC_I;
			s_v_sync_dly1     <= s_v_sync_dly;
            IF(v_sync_re='1')  THEN
                ROW_PTR_O <= (others => '0');
                INDEX <= (others => '0');
                s_already_add1 <='1';
                if(init_finished='0')then
                    init<='1';
                    init_finished<='1';
                else
                    init<='0';
                end if;
            ELSE
                IF(RAM_ADDR=x"0000") THEN
                    IF(s_already_add1='0') THEN
                        ROW_PTR_O <= ROW_PTR_O +1;
                        s_already_add1 <='1';
                        
                    END IF;
                ELSE
                    s_already_add1 <='0';
                END IF;
                IF(DATA_VALID_I='1') THEN
                    INDEX <= INDEX +1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
   -- architecture body
end architecture_ROW_PTR;
