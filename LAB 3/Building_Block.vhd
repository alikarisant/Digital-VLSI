library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Building_Block is
  port(
       clk : in std_logic;
       rst : in std_logic;
       Sin : in std_logic;
       Ain   : in std_logic;
       Bin   : in std_logic;
       Cin : in std_logic;
       Sout: out std_logic;
       Cout: out std_logic;
       Aout: out std_logic;
       Bout: out std_logic
      );
end entity; -- Building Block

architecture structural_arch of Building_Block is

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

  component D_Flip_Flop_behavioral is
    port(
      Q : out std_logic;    
      Clk : in std_logic;
      rst : in std_logic;   
      D :in  std_logic 
        );
  end component;
  -------------------------------------
  -- Declarations of internal signals 
  -- used in this level of hierarchy
signal C1,C3 : std_logic;  -- || C1 ->  input FA || C3 -> between D's || 
begin
  C1<=Ain AND Bin;
  -------------------------------------
  -- LEVEL 0 component instantiation --
  -------------------------------------
  Sychronous_Full_Adder_Behavioral_INSTANCE_0 : Sychronous_Full_Adder_Behavioral
    port map (
            clk => clk,
            rst => rst,
            A   => C1,  --result of AND
            B   => Sin, --result of above addition
            Cin => Cin,
            Sum =>  Sout,
            Cout =>  Cout
       );
  -------------------------------------
  -- LEVEL 1 component instantiation --
  -------------------------------------
  D_Flip_Flop_behavioral_INSTANCE_0 : D_Flip_Flop_behavioral
    port map (
      Q => Bout,   
      Clk => clk,
      rst => rst,  
      D => Bin
       );
  -------------------------------------
  -- LEVEL 2 component instantiation --
  -------------------------------------
  -------------------------------------
  -- LEVEL 3 component instantiation --
  -------------------------------------
  D_Flip_Flop_behavioral_INSTANCE_1 : D_Flip_Flop_behavioral
    port map (
      Q => C3,   
      Clk => clk,
      rst => rst,  
      D => Ain
       );
  -------------------------------------
  -- LEVEL 4 component instantiation --
  -------------------------------------
  D_Flip_Flop_behavioral_INSTANCE_2 : D_Flip_Flop_behavioral
    port map (
      Q => Aout,   
      Clk => clk,
      rst => rst,  
      D => C3
       );
  
end architecture ; -- arch
