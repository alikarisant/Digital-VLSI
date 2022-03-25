LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY lrshift_reg3_tb IS
END ENTITY;

ARCHITECTURE bench OF lrshift_reg3_tb IS

    -- Define component
    COMPONENT lrshift_reg3 IS
        PORT (
            clk, rst, si, en, pl, sh  : IN STD_LOGIC;
            din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            so : OUT STD_LOGIC
        );
    END COMPONENT;
 
    -- Test signals
    SIGNAL clk, rst, si, en, pl, sh : STD_LOGIC;
    SIGNAL din : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL so : STD_LOGIC;

    CONSTANT T : TIME := 10 ns;

BEGIN

    uut : lrshift_reg3
    PORT MAP(
        clk => clk,
        rst => rst,
        si => si,
        en => en,
        pl => pl,
        sh => sh,
        din => din,
        so => so
    );

    stimuli : PROCESS
    BEGIN
        -- read din, so = LSB
        
        en <= '0';
        si <= '0';
        rst <= '1';
        sh <= '0';
        pl <= '1';
        WAIT FOR T;
        
        -- s0 = reverse din with input 0
        en <= '1';
        pl <= '0';
        WAIT FOR 4 * T;

        -- input = 1
        si <= '1';
        WAIT FOR 8 * T;
        
        
        --read din, s0 = MSB
        si <= '1';
        sh <= '1';
        en <= '0';
        pl <= '1';
        WAIT FOR T;
        
        -- s0 = din with input 1
        en <= '1';
        pl <= '0';
        WAIT FOR 4 * T;

        --input = 0
        si <= '0';
        WAIT FOR 8 * T;
        
        din <= din + 1;


    END PROCESS;

    generate_clock : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR T/2;
        clk <= '1';
        WAIT FOR T/2;
    END PROCESS;


END ARCHITECTURE;