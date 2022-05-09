library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;


entity Parallel_tap_8_FIR_Filter_Behaviroal_tb is
--  Port ( );
end entity;

architecture Bench of Parallel_tap_8_FIR_Filter_Behaviroal_tb is

    component Parallel_tap_8_FIR_Filter_Behavioral is
    port (
          clk  : in std_logic;
          rst  : in std_logic;
          valid_in: in std_logic;
          diO   : in std_logic_vector(7 downto 0);    -- ODD input data
          diE   : in std_logic_vector(7 downto 0);    -- EVEN input data
          valid_out: out std_logic;
          doO   : out std_logic_vector(18 downto 0);	 -- ODD output data
          doE   : out std_logic_vector(18 downto 0)	 -- ODD output data

          );
    end component;

    SIGNAL clk, valid_out, valid_in, rst :  std_logic:='0';
    SIGNAL diO :  std_logic_vector(7 downto 0):="00000000";
    SIGNAL diE :  std_logic_vector(7 downto 0):="00000000";
    SIGNAL doO : STD_LOGIC_VECTOR(18 downto 0):="0000000000000000000";
    SIGNAL doE : STD_LOGIC_VECTOR(18 downto 0):="0000000000000000000";

    CONSTANT T : TIME := 10 ns;

    begin

    uut: Parallel_tap_8_FIR_Filter_Behavioral PORT MAP (
                                clk =>clk,
                                rst => rst,
                                valid_in => valid_in,
                                diE => diE,
                                diO => diO,
                                doO => doO,
                                doE => doE,
                                valid_out => valid_out                            
                                );

                        
    stimuli: PROCESS
    begin
        valid_in<='1';
        diE <= "00001000";
        diO <= "00100001";
        WAIT FOR T;
        diE <= "00100010";
        diO <= "10000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "10000101";
        WAIT FOR T;
        diE <= "01000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "01000000";
        diO <= "01000001";
        WAIT FOR T;
        diE <= "00100010";
        diO <= "01001011";
        WAIT FOR T;
        valid_in<='1';
        diE <= "00100111";
        diO <= "01110101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        valid_in<='1';
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        diE <= "00000000";
        diO <= "00000001";
        WAIT FOR T;
        diE <= "00000010";
        diO <= "00000011";
        WAIT FOR T;
        diE <= "00000100";
        diO <= "00000101";
        WAIT FOR T;
        diE <= "00000110";
        diO <= "00000111";
        WAIT FOR T;
        rst<='1';
        WAIT FOR T;
        rst<='0';
    end process;

    clk_gen: process begin
        clk <= '1';
        wait for T/2;
        clk <= '0';
        wait for T/2;
     end process;


end Bench;
