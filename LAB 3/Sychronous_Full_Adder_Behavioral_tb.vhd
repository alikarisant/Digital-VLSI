LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Sychronous_Full_Adder_Behavioral_tb IS
END Sychronous_Full_Adder_Behavioral_tb;

ARCHITECTURE behavior OF Sychronous_Full_Adder_Behavioral_tb IS 

 -- Component Declaration for the Unit Under Test (UUT)

 COMPONENT Sychronous_Full_Adder_Behavioral
 PORT(
 A : IN std_logic;
 B : IN std_logic;
 Cin : IN std_logic;
 clk : in std_logic;
 rst : in std_logic;
 Sum : OUT std_logic;
 Cout : OUT std_logic
 );
 END COMPONENT;

 --constants
 constant T : time := 10ns; --clock period
 -- Inputs
 signal A : std_logic := '0';
 signal B : std_logic := '0';
 signal Cin : std_logic := '0';
 signal clk : std_logic := '0';
 signal rst : std_logic := '0';

 -- Outputs
 signal Sum : std_logic;
 signal Cout : std_logic;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
 uut: Sychronous_Full_Adder_Behavioral PORT MAP (
 A => A,
 B => B,
 Cin => Cin,
 clk => clk,
 rst => rst,
 Sum => Sum,
 Cout => Cout
 );

 clk_gen: process begin
    clk <= '0';
    wait for T/2;
    clk <= '1';
    wait for T/2;
 end process;

 -- Stimulus process
 stim_proc: process
 begin
 -- hold reset state for 100 ns.
 wait for 30 ns; 

 -- insert stimulus here
 A <= '1';
 B <= '1';
 Cin <= '0';
 wait for 30 ns;

 A <= '0';
 B <= '1';
 Cin <= '0';
 wait for 30 ns;

 A <= '1';
 B <= '1';
 Cin <= '0';
 wait for 30 ns;

 A <= '0';
 B <= '0';
 Cin <= '1';
 wait for 30 ns;

 A <= '1';
 B <= '0';
 Cin <= '1';
 wait for 30 ns;

 A <= '0';
 B <= '1';
 Cin <= '1';
 wait for 30 ns;

 A <= '1';
 B <= '1';
 Cin <= '1';
 wait for 30 ns;

 end process;

END;
