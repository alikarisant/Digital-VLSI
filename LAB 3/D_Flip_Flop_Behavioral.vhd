Library IEEE;
USE IEEE.Std_logic_1164.all;

entity D_Flip_Flop_behavioral is 
   port(
      Q : out std_logic;    
      Clk : in std_logic;
      rst : in std_logic;   
      D :in  std_logic    
   );
end D_Flip_Flop_behavioral;
architecture Behavioral of D_Flip_Flop_behavioral is  
begin  
 process(Clk)
 begin 
    if(rst='1') then
        Q<='0';
    elsif(rising_edge(Clk)) then
        Q <= D; 
    end if;       
 end process;  
end Behavioral;
