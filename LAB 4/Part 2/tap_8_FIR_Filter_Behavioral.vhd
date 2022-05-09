library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity tap_8_FIR_Filter_Behavioral is
    port (
          clk  : in std_logic;
          rst  : in std_logic;
          valid_in: in std_logic;
          di   : in std_logic_vector(7 downto 0);    -- input data
          valid_out: out std_logic;
          do   : out std_logic_vector(18 downto 0)	 -- output data
          );
end tap_8_FIR_Filter_Behavioral;

architecture Behavioral of tap_8_FIR_Filter_Behavioral is

    signal X1, X2, X3, X4, X5, X6, X7 : std_logic_vector(7 downto 0):= "00000000";  -- the old inputs, ex: X1 = x[n-1]
    
    signal A : std_logic_vector(7 downto 0):= "00000000";  -- the register of phase A (first vertical stage)
    signal B1, B2 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase B (second vertical stage)
    signal C1, C2, C3 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase C (third vertical stage)
    signal D1, D2, D3, D4 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase D (fourth vertical stage)
    signal E1, E2, E3, E4, E5 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase E (fifth vertical stage)
    signal F1, F2, F3, F4, F5, F6 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase F (sixth vertical stage)
    signal G1, G2, G3, G4, G5, G6, G7 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase G (seventh vertical stage)
    signal H1, H2, H3, H4, H5, H6, H7, H8 : std_logic_vector(7 downto 0):= "00000000";  -- the registers of phase H (eighth vertical stage)

    ------- coefficients -----------------------------------
    signal Co0 : std_logic_vector(7 downto 0) := "00000001";
    signal Co1 : std_logic_vector(7 downto 0) := "00000010";
    signal Co2 : std_logic_vector(7 downto 0) := "00000011";
    signal Co3 : std_logic_vector(7 downto 0) := "00000100";
    signal Co4 : std_logic_vector(7 downto 0) := "00000101";
    signal Co5 : std_logic_vector(7 downto 0) := "00000110";
    signal Co6 : std_logic_vector(7 downto 0) := "00000111";
    signal Co7 : std_logic_vector(7 downto 0) := "00001000";
    --------------------------------------------------------

    ------the products after the multiplications------------
    signal Pr0 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr1 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr2 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr3 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr4 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr5 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr6 : std_logic_vector(15 downto 0):= "0000000000000000";
    signal Pr7 : std_logic_vector(15 downto 0):= "0000000000000000";
    --------------------------------------------------------

    -------the sums afer the additions----------------------
    signal Sum0 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum1 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum2 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum3 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum4 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum5 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum6 : std_logic_vector(18 downto 0):= "0000000000000000000";
    signal Sum7 : std_logic_vector(18 downto 0):= "0000000000000000000";
    --------------------------------------------------------

    -------counter for valid_out----------------------------
    signal counter : std_logic_vector(4 downto 0) := "00000";
    --------------------------------------------------------

    begin
        process(clk, rst)
        begin
            if(rst='1') then
                
                counter<= "00000";
                ----------------------------------------------------------------------------------------------------------
                -------------------------------------------RESET EVERYTHING----------------------------------------------- 
                
                -----------------Vertical Stages--------------------
                A <= (others => '0'); 
                B1 <= (others => '0'); B2 <= (others => '0'); 
                C1 <= (others => '0'); C2 <= (others => '0'); C3 <= (others => '0');
                E1 <= (others => '0'); E2 <= (others => '0'); E3 <= (others => '0'); E4 <= (others => '0'); E5 <= (others => '0');
                F1 <= (others => '0'); F2 <= (others => '0'); F3 <= (others => '0'); F4 <= (others => '0'); F5 <= (others => '0'); F6 <= (others => '0');
                G1 <= (others => '0'); G2 <= (others => '0'); G3 <= (others => '0'); G4 <= (others => '0'); G5 <= (others => '0'); G6 <= (others => '0'); G7 <= (others => '0');
                H1 <= (others => '0'); H2 <= (others => '0'); H3 <= (others => '0'); H4 <= (others => '0'); H5 <= (others => '0'); H6 <= (others => '0'); H7 <= (others => '0'); H8 <= (others => '0');
                ----------------------------------------------------

                ----------------Horizontal Stages-------------------
                X1 <= (others => '0');
                X2 <= (others => '0');
                X3 <= (others => '0');
                X4 <= (others => '0');
                X5 <= (others => '0');
                X6 <= (others => '0');
                X7 <= (others => '0');
                --------------------------------------------------------

                ------the products after the multiplications------------
                Pr0 <= (others => '0');
                Pr1 <= (others => '0');
                Pr2 <= (others => '0');
                Pr3 <= (others => '0');
                Pr4 <= (others => '0');
                Pr5 <= (others => '0');
                Pr6 <= (others => '0');
                Pr7 <= (others => '0');
                --------------------------------------------------------

                -------the sums afer the additions----------------------
                Sum0 <= (others => '0');
                Sum1 <= (others => '0');
                Sum2 <= (others => '0');
                Sum3 <= (others => '0');
                Sum4 <= (others => '0');
                Sum5 <= (others => '0');
                Sum6 <= (others => '0');
                Sum7 <= (others => '0');
                --------------------------------------------------------

                ------------------------Output--------------------------
                do <= (others => '0');
                valid_out <= '0';
                --------------------------------------------------------

                ----------------------------------------------------------------------------------------------------------
                ----------------------------------------------------------------------------------------------------------
           elsif(rising_edge(clk)) then
                if(valid_in = '1') then
                    if(counter>16) then
                        valid_out<= '1';
                    else
                        valid_out<='0';
                        counter<= counter+1;
                    end if;      
            
            ----------register shifting------------------
                    X1 <= di;
                    X2 <= X1;
                    X3 <= X2;
                    X4 <= X3;
                    X5 <= X4;
                    X6 <= X5;
                    X7 <= X6;
            ------------------------------------------
            
            ---------before the multiplications delays----------------------------------------------
                    A <= di;
                    B1 <= X1; B2 <= B1;
                    C1 <= X2; C2 <= C1; C3 <= C2;
                    D1 <= X3; D2 <= D1; D3 <= D2; D4 <= D3;
                    E1 <= X4; E2 <= E1; E3 <= E2; E4 <= E3; E5 <= E4;
                    F1 <= X5; F2 <= F1; F3 <= F2; F4 <= F3; F5 <= F4; F6 <= F5;
                    G1 <= X6; G2 <= G1; G3 <= G2; G4 <= G3; G5 <= G4; G6 <= G5; G7 <= G6;
                    H1 <= X7; H2 <= H1; H3 <= H2; H4 <= H3; H5 <= H4; H6 <= H5; H7 <= H6; H8 <= H7;
            -----------------------------------------------------------------------------------------
            
            --------Products--------------------
                    Pr0 <= Co0 * A;
                    Pr1 <= Co1 * B2;
                    Pr2 <= Co2 * C3;
                    Pr3 <= Co3 * D4;
                    Pr4 <= Co4 * E5;
                    Pr5 <= Co5 * F6;
                    Pr6 <= Co6 * G7;
                    Pr7 <= Co7 * H8;
            ------------------------------------

            ----------Sums------------------------------
                    Sum0 <= "0000000000000000000" + Pr0;
                    Sum1 <= Sum0 + Pr1;
                    Sum2 <= Sum1 + Pr2;
                    Sum3 <= Sum2 + Pr3;
                    Sum4 <= Sum3 + Pr4;
                    Sum5 <= Sum4 + Pr5;
                    Sum6 <= Sum5 + Pr6;
                    Sum7 <= Sum6 + Pr7;
            --------------------------------------------

                    do <= Sum7; --output
                end if;
            end if;
        end process;
    

    end Behavioral;
