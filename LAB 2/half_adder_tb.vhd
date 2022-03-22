----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2022 08:45:37 PM
-- Design Name: 
-- Module Name: half_adder_tb - Behavioral
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

entity half_adder_tb is
--  Port ( );
end half_adder_tb;

architecture Behavioral of half_adder_tb is

COMPONENT half_adder IS
    Port ( Ah : in STD_LOGIC;
           Bh : in STD_LOGIC;
           Sh : out STD_LOGIC;
           Ch : out STD_LOGIC);
end COMPONENT;

SIGNAL Ah, Bh, Sh, Ch : STD_LOGIC;

CONSTANT T : TIME := 10 ns;

begin

 uut: half_adder PORT MAP (Ah => Ah,
                           Bh => Bh,
                           Sh => Sh,
                           Ch => Ch);
                           
 stimuli: PROCESS
 begin
    Ah <= '0';
    Bh <= '0';
    WAIT FOR T;
    Ah <= '1';
    WAIT FOR T;
    Ah <= '0';
    Bh <= '1';
    WAIT FOR T;
    Ah <= '1';
    WAIT FOR T;
 end PROCESS;


end Behavioral;
