Library IEEE;
USE IEEE.Std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Control_Unit_Behavioral is 
   port(
        clk : in STD_LOGIC; --READY
        rst : in STD_LOGIC;  --READY 
        valid_in : in STD_LOGIC; --global valid_in READY
        write_to_RAM : out STD_LOGIC; --Write bit enable READY
        mac_init_out : out STD_LOGIC; --we must put delay here READY  ----->this might not need DELAY!
        valid_out_CU : out STD_LOGIC; --This is connected to valid_out !!we must put delay here!! READY
        ROM_adress : out STD_LOGIC_VECTOR (2 downto 0); --READY
        COUNTER_OUT : out STD_LOGIC_VECTOR (2 downto 0); --READY
        RAM_adress : out STD_LOGIC_VECTOR (2 downto 0);  --READY
        enable_RAM : out STD_LOGIC;
        enable_ROM : out STD_LOGIC
   );
end Control_Unit_Behavioral;

architecture Behavioral of Control_Unit_Behavioral is  

signal counter : STD_LOGIC_VECTOR (2 downto 0):= "000";
signal validator : STD_LOGIC := '0';      --signal connected to valid_out_CU
signal macer : STD_LOGIC:= '0';       --signal connected to mac_init_out
signal messenger : STD_LOGIC:= '0';       --signal connected to write_to_RAM
signal RAM_en,ROM_en : STD_LOGIC:= '0';       --signal connected to write_to_RAM

begin  
 process(clk,rst)
 begin 
    --rst implementation
    if(rst='1') then
        counter<="000";
        validator<='0';
        macer<='0';
    --------------------
    elsif clk'event and clk = '1' then
        if(counter="111") then
            if(valid_in='1') then
                macer<='0';--if macer is here it starts from 2(erasing accumulator when passing '1')
                validator<='0'; --output signal does not yet have the right value
                messenger<='1';
                RAM_en<='1';
                ROM_en<='1';
                counter<="000";
            else
                RAM_en<='0';
                ROM_en<='0';
                messenger<='0';
                macer<='0';
            end if;
        elsif(counter=0) then
                macer<='1'; --signal to MAC to re-initialize the accumulator ----->THIS SPOT FOR '1' GIVES US 7 RIGHT VALUES!
                counter<=counter+1;
                validator<='1'; --output signal does have the right value
                messenger<='0';  
        else 
            counter<=counter + 1;
            messenger<='0';
            macer<='0';
            validator<='0';
        end if;
    end if;      
enable_RAM <=RAM_en;
enable_ROM <=ROM_en;
 write_to_RAM<=messenger;
 mac_init_out<=macer;
 valid_out_CU<=validator;
 ROM_adress<=counter;
 RAM_adress<=counter; 
 COUNTER_OUT<=counter;
 end process;  

end Behavioral;
