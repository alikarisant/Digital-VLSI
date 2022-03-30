library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;


entity Sychronous_Systolic_4bit_Multiplier_tb is
--  Port ( );
end entity;

architecture Bench of Sychronous_Systolic_4bit_Multiplier_tb is

COMPONENT Sychronous_Systolic_4bit_Multiplier is
    Port ( clk : in std_logic;
           rst : in std_logic;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Product : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

SIGNAL A, B : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL Product : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL Cin : STD_LOGIC := '0';
SIGNAL clk :  std_logic;
SIGNAL rst :  std_logic := '0';

CONSTANT T : TIME := 10 ns;

begin

uut: Sychronous_Systolic_4bit_Multiplier PORT MAP (
                                    clk =>clk,
                                    rst => rst,
                                    A => A,
                                    B => B,
                                    Cin => Cin,
                                    Product => Product);

                    
stimuli: PROCESS
 begin
    A <= "0000";
    B <= "0000";
    WAIT FOR T;
    
    FOR j IN 1 TO 15 LOOP
        FOR i IN 1 TO 15 LOOP
            A <= A + 1;
            WAIT FOR T;
        end LOOP;
        B <= B + 1;
        WAIT FOR T;
    END LOOP;
    
   IF Cin = '0' THEN 
    Cin <= '1';
   ELSE 
    Cin <= '0';
   END IF;
   
 end PROCESS;
 
  clk_gen: process begin
    clk <= '0';
    wait for T/2;
    clk <= '1';
    wait for T/2;
 end process;
                
 

end Bench;
