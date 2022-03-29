library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sychronous_4bit_Adder_Structural is
  port(
       clk : in  std_logic;
       rst : in  std_logic;
       A   : in  std_logic_vector(3 downto 0);
       B   : in  std_logic_vector(3 downto 0);
       Cin   : in  std_logic;
       Sum    : out std_logic_vector(4 downto 0);
       Cout    : out  std_logic
      );
end entity; -- multiplexer

architecture structural_arch of Sychronous_4bit_Adder_Structural is

  -------------------------------------------
  -- Declarations of lower level components
  -- used in this level of hierarchy
  component Sychronous_Full_Adder_Behavioral is
    port(
       clk : in std_logic;
       rst : in std_logic;
       A : in  std_logic;
       B   : in  std_logic;
       Cin : in std_logic;
       Sum   : out  std_logic;
       Cout   : out  std_logic
        );
  end component;

  -------------------------------------
  -- Declarations of internal signals 
  -- used in this level of hierarchy
  --signal mux_out_instance_0, mux_out_instance_1 : std_logic_vector(3 downto 0) := (others => '0');
signal C, S : std_logic_vector(3 downto 0);
signal R01, R02, R03, R10a, R10b, R12, R13, R20a, R20b, R21a, R21b, R23, R30a, R30b, R31a, R31b, R32a, R32b: std_logic := '0'; 

begin
  -------------------------------------
  -- LEVEL 0 component instantiation --
  -------------------------------------
  Sychronous_Full_Adder_Behavioral_INSTANCE_0 : Sychronous_Full_Adder_Behavioral
    port map (
            clk => clk,
            rst => rst,
            A   => A(0),
            B   => B(0),
            Cin => Cin,
            Sum =>  S(0),
            Cout =>  C(0)
       );
  -------------------------------------
  -- LEVEL 1 component instantiation --
  -------------------------------------             


  Sychronous_Full_Adder_Behavioral_INSTANCE_1 : Sychronous_Full_Adder_Behavioral
    port map (
            clk => clk,
            rst => rst,
            A   => R10a,
            B   => R10b,
            Cin => C(0),
            Sum => S(1), 
            Cout => C(1)
             );
  -------------------------------------
  -- LEVEL 2 component instantiation --
  -------------------------------------
  Sychronous_Full_Adder_Behavioral_INSTANCE_2 : Sychronous_Full_Adder_Behavioral
    port map (
            clk => clk,
            rst => rst,
            A   => R21a,
            B   => R21b,
            Cin => C(1),
            Sum => S(2), 
            Cout => C(2)
             );
  -------------------------------------
  -- LEVEL 3 component instantiation --
  -------------------------------------
  Sychronous_Full_Adder_Behavioral_INSTANCE_3 : Sychronous_Full_Adder_Behavioral
    port map (
            clk => clk,
            rst => rst,
            A   => R32a,
            B   => R32b,
            Cin => C(2),
            Sum => S(3), 
            Cout => C(3)
             );
             
              --pipelining procedure
      pipeline_proc: process(clk, rst)
      begin
        if (rst = '1') then
            R01 <= '0'; R02 <= '0'; R03 <= '0'; 
            R10a <= '0'; R10b <= '0'; R12 <= '0'; R13 <= '0'; 
            R20a <= '0'; R20b <= '0'; R21a <= '0'; R21b <= '0'; 
            R23 <= '0'; R30a <= '0'; R30b <= '0'; 
            R31a <= '0'; R31b <= '0'; R32a <= '0'; R32b <= '0';
            
        elsif (clk'event and clk='1') then
            Sum(0) <= R03; Sum(1) <= R13; Sum(2) <= R23; Sum(3) <= S(3); Sum(4) <= C(3);
            R03 <= R02; R13 <= R12; R23 <= S(2);
            R02 <= R01; R12 <= S(1); R32a <= R31a; R32b <= R31b;
            R01 <= S(0); R21a <= R20a; R21b <= R20b; R31a <= R30a; R31b <= R30b;
            R10a <= A(1); R10b <= B(1); R20a <= A(2); R20b <= B(2); R30a <= A(3); R30b <= B(3);     
        end if;
      end process;


end architecture ; -- arch
