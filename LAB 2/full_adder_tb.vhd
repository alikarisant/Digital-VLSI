----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2022 07:03:43 PM
-- Design Name: 
-- Module Name: full_adder_tb - Behavioral
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

entity full_adder_tb is
--  Port ( );
end full_adder_tb;

architecture Behavioral of full_adder_tb is

COMPONENT full_adder IS
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end COMPONENT;

SIGNAL A, B, Ci, S, Co : STD_LOGIC;

CONSTANT T : TIME := 10 ns;

begin

 uut: full_adder PORT MAP (A => A,
                           B => B,
                           Ci => Ci,
                           S => S,
                           Co => Co);
                           
 stimuli: PROCESS
 begin
    A <= '0';
    B <= '0';
    Ci <= '0';
    WAIT FOR T;
    A <= '1';
    WAIT FOR T;
    A <= '0';
    B <= '1';
    WAIT FOR T;
    A <= '1';
    WAIT FOR T;
    A <= '0';
    B <= '0';
    Ci <= '1';
    WAIT FOR T;
    A <= '1';
    WAIT FOR T;
    A <= '0';
    B <= '1';
    WAIT FOR T;
    A <= '1';
    WAIT FOR T;
 end PROCESS;
    
 


end Behavioral;
