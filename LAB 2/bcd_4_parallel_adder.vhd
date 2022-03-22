library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_4_parallel_adder is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end bcd_4_parallel_adder;

architecture Structural of bcd_4_parallel_adder is

 COMPONENT bcd_full_adder
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC);
end COMPONENT;

SIGNAL Carry : STD_LOGIC_VECTOR (4 DOWNTO 0) ;


begin

Carry(0) <= Cin;

G1: FOR i IN 0 TO 3 GENERATE
    Bcd: bcd_full_adder PORT MAP (A => A(4*i + 3 DOWNTO 4*i),
                                  B => B(4*i + 3 DOWNTO 4*i),
                                  Sum => Sum(4*i + 3 DOWNTO 4*i),
                                  Cin => Carry(i),
                                  Cout => Carry(i+1));
    
   end GENERATE;

Cout <= Carry(4);

end Structural;
