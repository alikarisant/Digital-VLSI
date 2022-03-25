LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mod_counter_3bit_tb IS
END ENTITY;

ARCHITECTURE bench OF mod_counter_3bit_tb IS

    -- Define component
    COMPONENT mod_counter_3bit IS
        PORT (
            clk, reset_bar, count_en : IN STD_LOGIC;
            modulo : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            sum : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Test signals
    SIGNAL clk, reset_bar, count_en : STD_LOGIC;
    SIGNAL sum, modulo : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL cout : STD_LOGIC;

    CONSTANT T : TIME := 10 ns;

BEGIN

    uut : mod_counter_3bit
    PORT MAP(
        clk => clk,
        reset_bar => reset_bar,
        count_en => count_en,
        modulo => modulo,
        sum => sum,
        cout => cout
    );

    stimulus : PROCESS
    BEGIN
        -- Start by enabling counting 
        reset_bar <= '1';
        count_en <= '1';

        -- Check all possible modulos
        FOR i IN 1 TO 7 LOOP
            modulo <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
            WAIT FOR 8 * T;
        END LOOP;

        -- Pause
        count_en <= '0';
        WAIT FOR 5 * T;

        -- Restart
        count_en <= '1';
        WAIT FOR 5 * T;

        -- Reset 
        reset_bar <= '0';
        WAIT FOR 5 * T;
        WAIT;
    END PROCESS;

    generate_clock : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR T/2;
        clk <= '1';
        WAIT FOR T/2;
    END PROCESS;

END ARCHITECTURE;