LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY updown_counter_3bit IS
    PORT (
        clk, reset_bar, count_en, up : IN STD_LOGIC;
        sum : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END;

-- LIMIT
ARCHITECTURE rtl_limit OF updown_counter_3bit IS
    SIGNAL count : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN
    PROCESS (clk, reset_bar)
    BEGIN
        IF reset_bar = '0' THEN
            -- Asynchronous reset
            count <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF count_en = '1' THEN
                -- Count only if count_en = 1
                IF up = '1' THEN
                    -- If up = 1 count up
                    IF count /= 7 THEN
                        -- Increment counter if it hasn't reached 7
                        count <= count + 1;
                    ELSE
                        -- else clear all
                        count <= (OTHERS => '0');
                    END IF;
                ELSIF up = '0' THEN
                    -- Count down
                    IF count /= 0 THEN
                        -- Decrement counter if it hasn't reached 0
                        count <= count - 1;
                    ELSE
                        -- else set all
                        count <= (OTHERS => '1');
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    sum <= count;
    cout <= '1' WHEN count = 7 AND count_en = '1' ELSE
        '0';
END;