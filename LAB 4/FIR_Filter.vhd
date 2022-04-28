library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity FIR_Filter is
    Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            valid_in : in STD_LOGIC;
            x : in STD_LOGIC_VECTOR(7 downto 0);
            COUNTER : out STD_LOGIC_VECTOR(2 downto 0);
            y : out STD_LOGIC_VECTOR(18 downto 0);
            valid_out : out STD_LOGIC;
            ram_CHECK   : out std_logic_vector(7 downto 0);
            ram_CHECK1   : out std_logic_vector(7 downto 0);
            ram_CHECK2   : out std_logic_vector(7 downto 0);
            ram_CHECK3   : out std_logic_vector(7 downto 0);
            ram_CHECK4   : out std_logic_vector(7 downto 0);
            ram_CHECK5   : out std_logic_vector(7 downto 0);
            ram_CHECK6   : out std_logic_vector(7 downto 0);
            ram_CHECK7   : out std_logic_vector(7 downto 0);
            ROM_CHECK: out  STD_LOGIC_VECTOR (7 downto 0);
            OUT_MAC: out std_logic;
            WRAM : out std_logic;
            BOOLEANA : out STD_LOGIC_VECTOR (18 downto 0)
           );
end FIR_Filter;

architecture Structural of FIR_Filter is

    component Control_Unit_Behavioral is
    port(
        clk : in STD_LOGIC; --READY
        rst : in STD_LOGIC;  --READY 
        valid_in : in STD_LOGIC; --global valid_in READY
        write_to_RAM : out STD_LOGIC; --Write bit enable READY
        mac_init_out : out STD_LOGIC; --we must put delay here READY
        valid_out_CU : out STD_LOGIC; --This is connected to valid_out !!we must put delay here!! READY
        COUNTER_OUT : out STD_LOGIC_VECTOR (2 downto 0); --READY
        ROM_adress : out STD_LOGIC_VECTOR (2 downto 0); --READY
        RAM_adress : out STD_LOGIC_VECTOR (2 downto 0);  --READY
        enable_RAM : out STD_LOGIC;
        enable_ROM : out STD_LOGIC
        );
end component;
  
    component MAC_Behavioral is
    port(
      ROM_data : in  STD_LOGIC_VECTOR (7 downto 0);
      RAM_data : in  STD_LOGIC_VECTOR (7 downto 0);
      mac_initialize : in STD_LOGIC;
      --valid_in_mac : in STD_LOGIC;
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      y : out STD_LOGIC_VECTOR (18 downto 0);
      OUT_MAC: out std_logic;
      BOOLEANA : out STD_LOGIC_VECTOR (18 downto 0)
        );
end component;
  
    component RAM_Behavioral is
    port(
          clk  : in std_logic;
          rst  : in std_logic;
          we   : in std_logic;		--- memory write enable
		  en   : in std_logic;		--- operation enable
          addr : in std_logic_vector(2 downto 0);	-- memory address
          di   : in std_logic_vector(7 downto 0);    -- input data
          ram_out   : out std_logic_vector(7 downto 0);
          ram_CHECK : out std_logic_vector(7 downto 0);
          ram_CHECK1 : out std_logic_vector(7 downto 0);
          ram_CHECK2 : out std_logic_vector(7 downto 0);
          ram_CHECK3 : out std_logic_vector(7 downto 0);
          ram_CHECK4 : out std_logic_vector(7 downto 0);
          ram_CHECK5 : out std_logic_vector(7 downto 0);
          ram_CHECK6 : out std_logic_vector(7 downto 0);
          ram_CHECK7 : out std_logic_vector(7 downto 0)
        );
end component;
  
    component ROM_Behavioral is
    port(
            clk : in  STD_LOGIC;
			en : in  STD_LOGIC;				--- operation enable
            addr : in  STD_LOGIC_VECTOR (2 downto 0);			-- memory address
            rom_out : out  STD_LOGIC_VECTOR (7 downto 0);
            ROM_CHECK: out  STD_LOGIC_VECTOR (7 downto 0)
            );	
    end component;

--Transport Address to RAM and ROM   
signal to_ROM :STD_LOGIC_VECTOR (2 downto 0):="000";
signal to_RAM :STD_LOGIC_VECTOR (2 downto 0):="000";

--Transport bit to valid_out
signal to_valid_out : STD_LOGIC:='0';

--Transport bit to mac_init
signal to_mac_init : STD_LOGIC:='0';

--delays
signal delayA1,delayA2,delayA3 : std_logic:='0';

--delay ROM to MAC
signal delay_ROM_to_MAC :STD_LOGIC_VECTOR (7 downto 0):="00000000";

--Tranport data from ROM and RAM to MAC
signal ROM_to_MAC :STD_LOGIC_VECTOR (7 downto 0):="00000000";
signal RAM_to_MAC :STD_LOGIC_VECTOR (7 downto 0):="00000000";

--Enable for RAM and ROM
signal enable_RAM,enable_ROM : STD_LOGIC:='0';

--Signal to RAM is the write sequence may commence
signal write_to_RAM : STD_LOGIC:='0';

begin
--------------------------------------------------------------------------    
-------------------------------------------------------------------------- 
  Control_Unit_Behavioral_INSTANCE_0: Control_Unit_Behavioral
    port map ( 
        clk =>clk,  --DONE
        rst =>rst,  --DONE
        valid_in =>valid_in,    --DONE
        write_to_RAM=>write_to_RAM,
        valid_out_CU =>to_valid_out,
        mac_init_out =>to_mac_init,
        ROM_adress =>to_ROM,
        COUNTER_OUT=>COUNTER,
        RAM_adress =>to_RAM,
        enable_RAM=>enable_RAM,
        enable_ROM=>enable_ROM
               );
    WRAM<=  write_to_RAM;         
 delay_1:process (clk)		--1 clock cycles
begin
  if rising_edge(clk) then
    valid_out <= to_valid_out;
  end if;
end process;
--------------------------------------------------------------------------    
-------------------------------------------------------------------------- 
  RAM_Behavioral_INSTANCE_0: RAM_Behavioral
    port map ( 
          clk  =>clk,
          rst  =>rst,
          we   =>write_to_RAM,		--- memory write enable
		  en   =>enable_RAM,		--- operation enable
          addr =>to_RAM,	-- memory address
          di   =>x,    -- input data
          ram_CHECK => ram_CHECK,
          ram_CHECK1 => ram_CHECK1,
          ram_CHECK2 => ram_CHECK2,
          ram_CHECK3 => ram_CHECK3,
          ram_CHECK4 => ram_CHECK4,
          ram_CHECK5 => ram_CHECK5,
          ram_CHECK6 => ram_CHECK6,
          ram_CHECK7 => ram_CHECK7,
          ram_out   => RAM_to_MAC
         
               );
--------------------------------------------------------------------------    
--------------------------------------------------------------------------        
  ROM_Behavioral_INSTANCE_0: ROM_Behavioral
    port map ( 
            clk =>clk,
			en =>enable_ROM,				--- operation enable
            addr =>to_ROM,			-- memory address
            rom_out =>ROM_to_MAC,
            ROM_CHECK=>ROM_CHECK
               );
--------------------------------------------------------------------------    
--------------------------------------------------------------------------   
 delay_2:process (clk)		--1 clock cycles
begin
  if rising_edge(clk) then
    delay_ROM_to_MAC <= ROM_to_MAC;
  end if;
end process;
             
  MAC_Behavioral_INSTANCE_0: MAC_Behavioral
    port map ( 
      ROM_data =>ROM_to_MAC,
      RAM_data =>RAM_to_MAC,
      mac_initialize =>to_mac_init,
      --valid_in_mac =>valid_in,
      clk =>clk,
      rst =>rst,
      y =>y,
      OUT_MAC=>OUT_MAC,
      BOOLEANA =>BOOLEANA
               );
--------------------------------------------------------------------------    
-------------------------------------------------------------------------- 
end Structural;
