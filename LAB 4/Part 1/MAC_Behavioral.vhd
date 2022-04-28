Library IEEE;
USE IEEE.Std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MAC_Behavioral is 
   port(   
      ROM_data : in  STD_LOGIC_VECTOR (7 downto 0);
      RAM_data : in  STD_LOGIC_VECTOR (7 downto 0);
      mac_initialize : in STD_LOGIC;
      --valid_in_mac : in STD_LOGIC;
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      y : out STD_LOGIC_VECTOR (18 downto 0);
      OUT_MAC : out STD_LOGIC;
      BOOLEANA : out STD_LOGIC_VECTOR (18 downto 0)
   );
end MAC_Behavioral;
architecture Behavioral of MAC_Behavioral is  

signal accumulator : STD_LOGIC_VECTOR (18 downto 0):="0000000000000000000";
signal boole : STD_LOGIC_VECTOR (18 downto 0):="0000000000000000000";
signal delayer1,delayer2,transfer: STD_LOGIC_VECTOR (18 downto 0):="0000000000000000000";

begin  
 process(clk,rst)
 begin 
    if(rst='1') then
        accumulator<= (others=>'0');
    elsif(rising_edge(clk)) then
        if (mac_initialize='1') then
            accumulator<= "0000000000000000000"+ ((ROM_data * RAM_data));  --Size doesn't match
            boole<=delayer1;         --"0000000000000000000"+ ((ROM_data * RAM_data));
            y<=transfer+delayer1;
        else  
            --accumulator<= accumulator + ((ROM_data * RAM_data)+"0000000000000000000");
            delayer1<="0000000000000000000"+ ((ROM_data * RAM_data));
            accumulator<= accumulator + ((ROM_data * RAM_data)+"0000000000000000000");
            transfer<=accumulator;
            boole<="0000000000000000000";
            y<=accumulator;
        end if;
    end if;       
 end process;  
 --y <= accumulator;
 BOOLEANA<=boole;
 OUT_MAC<=mac_initialize;
