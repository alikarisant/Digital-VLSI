LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY lrshift_reg3 IS
    PORT (
        clk, rst, si, en, pl, sh : IN STD_LOGIC; --sh = '0' means right shift
        din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        so : OUT STD_LOGIC
    );
END lrshift_reg3;
ARCHITECTURE rtl OF lrshift_reg3 IS
    SIGNAL dff : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
    edge : PROCESS (clk, rst)
    BEGIN
        IF rst = '0' THEN
            dff <= (OTHERS => '0');
        ELSIF clk'event AND clk = '1' THEN
            IF pl = '1' THEN
                dff <= din;
            ELSIF en = '1' THEN
                IF sh = '0' THEN
                    dff <= si & dff(3 DOWNTO 1);
                ELSE
                    dff <= dff(2 DOWNTO 0) & si;
                END IF;

            END IF;
        END IF;

        CASE(sh) IS

            WHEN '0' => so <= dff(0);
            WHEN OTHERS => so <= dff(3);

        END CASE;
    END PROCESS;

END rtl;