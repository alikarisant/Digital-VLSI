----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2022 10:33:35 PM
-- Design Name: 
-- Module Name: bcd_full_adder_tb - Bench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_full_adder_tb is
--  Port ( );
end bcd_full_adder_tb;

architecture Bench of bcd_full_adder_tb is

    COMPONENT bcd_full_adder is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Sum : out STD_LOGIC_VECTOR (3 downto 0);
               Cin : in STD_LOGIC;
               Cout : out STD_LOGIC);
    end COMPONENT;
    
    SIGNAL A, B, Sum : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL Cin : STD_LOGIC := '0';
    SIGNAL Cout : STD_LOGIC;
    
    
    CONSTANT T : TIME := 10 ns;

begin

    uut: bcd_full_adder PORT MAP (A => A,
                                  B => B,
                                  Cin => Cin,
                                  Cout => Cout,
                                  Sum => Sum);
                                        
    stimuli: PROCESS
     begin
        A <= "0000";
        B <= "0000";
        
        
        FOR j IN 1 TO 9 LOOP
        WAIT FOR T;
            FOR i IN 1 TO 9 LOOP
                A <= A + 1;
                WAIT FOR T;
            end LOOP;
            A <= "0000";
            B <= B + 1;
        END LOOP;
        
       IF Cin = '0' THEN 
        Cin <= '1';
       ELSE 
        Cin <= '0';
       END IF;
       
     end PROCESS;

end Bench;
