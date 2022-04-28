library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity ROM_Behavioral is
    Port ( 
        clk : in  STD_LOGIC;
			  en : in  STD_LOGIC;				--- operation enable
           addr : in  STD_LOGIC_VECTOR (2 downto 0);			-- memory address
           rom_out : out  STD_LOGIC_VECTOR (7 downto 0);
           ROM_CHECK: out  STD_LOGIC_VECTOR (7 downto 0)
           );	-- output data
end ROM_Behavioral;

architecture Behavioral of ROM_Behavioral is

    type rom_type is array (7 downto 0) of std_logic_vector (7 downto 0);                 
    signal rom : rom_type:= ("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", "00000010",
                             "00000001");      				 -- initialization of rom with user data                 

    signal rdata : std_logic_vector(7 downto 0) := (others => '0');
begin

    rdata <= rom(conv_integer(addr));

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (en = '1') then
                rom_out <= rdata;
                ROM_CHECK<=rdata;
            end if;
        end if;
    end process;			


end Behavioral;

