----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2022 05:51:08 PM
-- Design Name: 
-- Module Name: bcd_4_parallel_adder_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_4_parallel_adder_tb is
end entity;

architecture bench of bcd_4_parallel_adder_tb is

COMPONENT bcd_4_parallel_adder IS
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end COMPONENT;

SIGNAL A, B, Sum : STD_LOGIC_VECTOR (15 downto 0);
SIGNAL Cin, Cout : STD_LOGIC;

CONSTANT T : TIME := 10 ns;
    

begin

    uut: bcd_4_parallel_adder PORT MAP (A => A,
                                        B => B,
                                        Cin => Cin,
                                        Sum => Sum,
                                        Cout => Cout);
                                        
    stimuli: PROCESS
    BEGIN
        A <= "0001001000110100";  --1234
        B <= "0001000100010001";  --1111
        Cin <= '0';
        WAIT FOR T;
        
        A <= "1001001101110101";  --9375
        B <= "0001000100010001";  --1111
        WAIT FOR T;
        
        A <= "0001001000110100";  --1234
        B <= "1001001101010100";  --9354
        WAIT FOR T;
         
        A <= "1001001000110100";  --9234
        B <= "0001000100010001";  --1111
        Cin <= '1';
        WAIT;
    end PROCESS;

end bench;
