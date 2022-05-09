library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;


entity tap_8_FIR_Filter_Behavioral_tb is
--  Port ( );
end entity;

architecture Bench of tap_8_FIR_Filter_Behavioral_tb is

    component tap_8_FIR_Filter_Behavioral is
        port (
              clk  : in std_logic;
              rst  : in std_logic;
              valid_in: in std_logic;
              di   : in std_logic_vector(7 downto 0);    -- input data
              valid_out: out std_logic;
              do   : out std_logic_vector(18 downto 0)	 -- output data
              );
    end component;

    SIGNAL clk, valid_out, valid_in, rst :  std_logic:='0';
    SIGNAL di :  std_logic_vector(7 downto 0):="00000001";
    SIGNAL do : STD_LOGIC_VECTOR(18 downto 0):="0000000000000000000";

    CONSTANT T : TIME := 10 ns;

    begin

    uut: tap_8_FIR_Filter_Behavioral PORT MAP (
                                clk =>clk,
                                rst => rst,
                                valid_in => valid_in,
                                di => di,
                                do => do,
                                valid_out => valid_out
                                );

                        
    stimuli: PROCESS
    begin  
        valid_in <= '1';
        di <= "00000001";
        WAIT FOR T;
        valid_in <= '0';
        di<=di+1;
        WAIT FOR T;
        rst<='1';
        WAIT FOR T;
        rst<='0';
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<="00000001";
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<="00000001";
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
        valid_in <= '1';
        di<=di+1;
        WAIT FOR T;
    end process;

    clk_gen: process begin
        clk <= '1';
        wait for T/2;
        clk <= '0';
        wait for T/2;
     end process;


end Bench;
