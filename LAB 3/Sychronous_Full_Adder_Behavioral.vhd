library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sychronous_Full_Adder_Behavioral is
  port(
       clk : in std_logic;
       rst : in std_logic;
       A : in  std_logic;
       B   : in  std_logic;
       Cin : in std_logic;
       Sum   : out  std_logic;
       Cout   : out  std_logic
      );
end entity; -- Synchronous Full Adder

architecture behavioral_arch of Sychronous_Full_Adder_Behavioral is
--signal S1,S2,S3 : std_logic;
begin

  FA_LOGIC : process(rst,clk)
  begin
    if(rst='1') then
        Sum <='0';
        Cout<='0';
    elsif (clk'event and clk='1') then
        Sum <= A XOR B XOR Cin ;
        Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B) ;
    end if;
  end process;

end architecture ; -- arch
