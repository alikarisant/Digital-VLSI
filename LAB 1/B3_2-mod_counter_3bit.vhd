LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY mod_counter_3bit IS
    PORT (
        clk, reset_bar, count_en : IN STD_LOGIC;
        modulo : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        sum : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        cout : OUT STD_LOGIC);
END;

-- LIMIT
ARCHITECTURE rtl_limit OF mod_counter_3bit IS
    SIGNAL count : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN
    PROCESS (clk, reset_bar)
    BEGIN
        IF reset_bar = '0' THEN
            -- Asynchronous reset
            count <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF count_en = '1' THEN
                IF count /= 7 AND count < modulo - 1 THEN
                    count <= count + 1;
                ELSE
                    count <= (OTHERS => '0');
                END IF;
            END IF;
        END IF;
    END PROCESS;
    sum <= count;
    cout <= '1' WHEN count = 7 AND count_en = '1' ELSE
        '0';
END;