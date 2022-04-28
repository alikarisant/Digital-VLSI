library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;


entity FIR_Filter_tb is
--  Port ( );
end entity;

architecture Bench of FIR_Filter_tb is

    component FIR_Filter is
        Port ( 
                clk : in STD_LOGIC;
                rst : in STD_LOGIC;
                valid_in : in STD_LOGIC;
                x : in STD_LOGIC_VECTOR(7 downto 0);
                COUNTER : out STD_LOGIC_VECTOR(2 downto 0);
                y : out STD_LOGIC_VECTOR(18 downto 0);
                valid_out : out STD_LOGIC;
                ram_CHECK   : out std_logic_vector(7 downto 0);
                ram_CHECK1   : out std_logic_vector(7 downto 0);
                ram_CHECK2   : out std_logic_vector(7 downto 0);
                ram_CHECK3   : out std_logic_vector(7 downto 0);                
                ROM_CHECK: out  STD_LOGIC_VECTOR (7 downto 0);
                ram_CHECK4   : out std_logic_vector(7 downto 0);
                ram_CHECK5   : out std_logic_vector(7 downto 0);
                ram_CHECK6   : out std_logic_vector(7 downto 0);
                ram_CHECK7   : out std_logic_vector(7 downto 0);
                OUT_MAC : out std_logic;
                WRAM : out std_logic;
                BOOLEANA : out STD_LOGIC_VECTOR (18 downto 0)
               );
    end component;
    
    SIGNAL BOOLEANA : STD_LOGIC_VECTOR (18 downto 0):="0000000000000000000";
    SIGNAL WRAM : STD_LOGIC:='0';
    SIGNAL OUT_MAC : STD_LOGIC:='0';
    SIGNAL ROM_CHECK : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK1 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK2 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK3 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK4 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK5 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK6 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL ram_CHECK7 : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL x : STD_LOGIC_VECTOR(7 downto 0):="00000000";
    SIGNAL COUNTER : STD_LOGIC_VECTOR(2 downto 0):="000";
    SIGNAL y : STD_LOGIC_VECTOR(18 downto 0):="0000000000000000000";
    SIGNAL clk, valid_out, valid_in :  std_logic:='0';
    SIGNAL rst :  std_logic := '0';

    CONSTANT T : TIME := 10 ns;

    begin

    uut: FIR_Filter PORT MAP (
                                clk =>clk,
                                rst => rst,
                                valid_in => valid_in,
                                x => x,
                                COUNTER => COUNTER,
                                y => y,
                                valid_out => valid_out,
                                ram_CHECK => ram_CHECK,
                                ram_CHECK1 => ram_CHECK1,
                                ram_CHECK2 => ram_CHECK2,
                                ram_CHECK3 => ram_CHECK3,
                                ram_CHECK4 => ram_CHECK4,
                                ram_CHECK5 => ram_CHECK5,
                                ram_CHECK6 => ram_CHECK6,
                                ram_CHECK7 => ram_CHECK7,
                                ROM_CHECK=>ROM_CHECK,
                                OUT_MAC=>OUT_MAC,
                                WRAM=>WRAM,
                                BOOLEANA=>BOOLEANA
                                );

                        
    stimuli: PROCESS
    begin
        
        x <= "00000011";
        valid_in <= '1';
        WAIT FOR T;
        valid_in <= '0';
        WAIT FOR 7*T;
         FOR i IN 0 TO 7 LOOP 
            x<=x+2;  
            valid_in <= '1';
            WAIT FOR T;
            valid_in <= '0';
            WAIT FOR 7*T;
        END LOOP;
        if(x=8) then
            x<="00000000";
        end if;
    end process;

    clk_gen: process begin
        clk <= '1';
        wait for T/2;
        clk <= '0';
        wait for T/2;
     end process;

end Bench;
