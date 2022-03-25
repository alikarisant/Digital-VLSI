LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dec3to8 IS
    PORT (
        enc : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        dec : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END dec3to8;

ARCHITECTURE behavior OF dec3to8 IS
BEGIN
    PROCESS (enc)
    BEGIN
        CASE(enc) IS

            WHEN "000" => dec <= "00000001";
            WHEN "001" => dec <= "00000010";
            WHEN "010" => dec <= "00000100";
            WHEN "011" => dec <= "00001000";
            WHEN "100" => dec <= "00010000";
            WHEN "101" => dec <= "00100000";
            WHEN "110" => dec <= "01000000";
            WHEN OTHERS => dec <= "10000000";

        END CASE;
    END PROCESS;
END behavior;