LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY updown_counter_3bit_tb IS
END ENTITY;

ARCHITECTURE bench OF updown_counter_3bit_tb IS

    -- Define component
    COMPONENT updown_counter_3bit IS
        PORT (
            clk, reset_bar, count_en, up : IN STD_LOGIC;
            sum : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            cout : OUT STD_LOGIC
        );
    END COMPONENT;
 
    -- Test signals
    SIGNAL clk, reset_bar, count_en, up : STD_LOGIC;
    SIGNAL sum : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL cout : STD_LOGIC;

    CONSTANT T : TIME := 10 ns;

BEGIN

    uut : updown_counter_3bit
    PORT MAP(
        clk => clk,
        reset_bar => reset_bar,
        count_en => count_en,
        up => up,
        sum => sum,
        cout => cout
    );

    stimulus : PROCESS
    BEGIN
        -- Start by counting up
        reset_bar <= '1';
        count_en <= '1';     
        up <= '1'; 
        WAIT FOR 10 * T;

        -- Then count down
        up <= '0';
        WAIT FOR 10 * T;

        -- Stop counting
        count_en <= '0';
        WAIT FOR 5 * T;

        -- Restart
        count_en <= '1';
        WAIT FOR 5 * T;

        -- Reset and count up
        reset_bar <= '0';
        up <= '1';
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