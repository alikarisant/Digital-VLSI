library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit_4_parallel_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0));
end bit_4_parallel_adder;

architecture Structural of bit_4_parallel_adder is


SIGNAL Carry : STD_LOGIC_VECTOR (4 DOWNTO 0) ;

COMPONENT full_adder
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end COMPONENT;

begin

    Carry(0) <= Cin;

    G1: FOR i IN 0 TO 3 GENERATE
        Adders: full_adder PORT MAP (A => A(i),
                                 B => B(i),
                                 Ci => Carry(i),
                                 S => Sum(i),
                                 Co => Carry(i+1));
        end GENERATE;
    Cout <= Carry(4);

end Structural;
