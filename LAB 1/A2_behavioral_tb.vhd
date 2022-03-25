LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY dec3to8_tb IS
END ENTITY;

ARCHITECTURE bench OF dec3to8_tb IS

    -- Define component
    COMPONENT dec3to8 IS
        PORT (
            enc : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            dec : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Test signals
    SIGNAL enc : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL dec : STD_LOGIC_VECTOR(7 DOWNTO 0);

    CONSTANT T : TIME := 10 ns;

BEGIN

    uut : dec3to8
    PORT MAP(
        enc => enc,
        dec => dec
    );

    stimulus : PROCESS
    BEGIN
        WAIT FOR 10 ns;
        enc <= enc + 1;
    END PROCESS;


END ARCHITECTURE;