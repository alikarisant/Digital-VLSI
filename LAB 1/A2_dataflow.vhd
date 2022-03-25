LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dec3to8 IS
    PORT (
        enc : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        dec : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END dec3to8;

ARCHITECTURE dataflow OF dec3to8 IS
BEGIN
    WITH enc SELECT
        dec <=  "00000001" WHEN "000",
                "00000010" WHEN "001",
                "00000100" WHEN "010",
                "00001000" WHEN "011",
                "00010000" WHEN "100",
                "00100000" WHEN "101",
                "01000000" WHEN "110",
                "10000000" WHEN OTHERS;
END dataflow;