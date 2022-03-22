library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_full_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC);
end bcd_full_adder;

architecture Structural of bcd_full_adder is

COMPONENT bit_4_parallel_adder
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

SIGNAL half_output : STD_LOGIC_VECTOR (3 DOWNTO 0) ;
SIGNAL D1 : STD_LOGIC;
SIGNAL D2 : STD_LOGIC;
SIGNAL D3 : STD_LOGIC;
SIGNAL ign: STD_LOGIC;
SIGNAL Y1 : STD_LOGIC;

begin

    u1: bit_4_parallel_adder PORT MAP (A => A,
                                       B => B,
                                       Cin => Cin,
                                       Cout => D1,
                                       Sum => half_output);
                                       
    D2 <= half_output(3) AND half_output(2);
    D3 <= half_output(3) AND half_output(1);
    Y1 <= D1 OR D2 OR D3;
    
    u2: bit_4_parallel_adder PORT MAP (A => half_output,
                                       B(0) => '0',
                                       B(1) => Y1,
                                       B(2) => Y1,
                                       B(3) => '0',
                                       Cin => '0',
                                       Cout => ign,
                                       Sum => Sum);
                                       
    Cout <= Y1;
    
end Structural;
