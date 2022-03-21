library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end full_adder;

architecture Structural of full_adder is

SIGNAL w1 : STD_LOGIC ;
SIGNAL w2 : STD_LOGIC ;
SIGNAL w3 : STD_LOGIC ;

COMPONENT half_adder
    Port ( Ac : in STD_LOGIC;
           Bc : in STD_LOGIC;
           Sc : out STD_LOGIC;
           Cc : out STD_LOGIC);
end COMPONENT;

begin

    u1: half_adder PORT MAP (Ac => A,
                             Bc => B,
                             Sc => w1,
                             Cc => w2);
                         
    u2: half_adder PORT MAP (Ac => w1,
                             Bc => Ci,
                             Sc => S,
                             Cc => w3);
                         
    Co <= w3 OR w2;
                             
end Structural;
