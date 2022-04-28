--In the RAM definition we observe that we define 8 spots for RAM type memory,
--all of which are of 8 bits words(our inputs!)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM_Behavioral is
    port (
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
          );	-- output data
end RAM_Behavioral;

architecture Behavioral of RAM_Behavioral is

    type ram_type is array (7 downto 0) of std_logic_vector (7 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
	 
begin


    process (clk,rst)
    begin
        if (rst='1') then
            RAM<=(others => (others => '0'));     
        elsif clk'event and clk = '1' then
            if en = '1' then
                if we = '1' then				-- write operation
                    --RAM(conv_integer(addr)) <= di;
                    ram_out <= di;
                    RAM(0)<=di;
                    RAM(1)<=RAM(0);
                    RAM(2)<=RAM(1);
                    RAM(3)<=RAM(2);
                    RAM(4)<=RAM(3);
                    RAM(5)<=RAM(4);
                    RAM(6)<=RAM(5);
                    RAM(7)<=RAM(6);
                else						-- read operation
                    ram_out <= RAM( conv_integer(addr));
                    
                end if;
            end if;
        end if;
        ram_CHECK <= RAM(0);
        ram_CHECK1 <= RAM(1);
        ram_CHECK2 <= RAM(2);
        ram_CHECK3 <= RAM(3);
        ram_CHECK4 <= RAM(4);
        ram_CHECK5 <= RAM(5);
        ram_CHECK6 <= RAM(6);
        ram_CHECK7 <= RAM(7);
    end process;


end Behavioral;

