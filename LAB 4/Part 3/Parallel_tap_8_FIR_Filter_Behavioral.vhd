library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity Parallel_tap_8_FIR_Filter_Behavioral is
    port (
          clk  : in std_logic;
          rst  : in std_logic;
          valid_in: in std_logic;
          diO   : in std_logic_vector(7 downto 0);    -- ODD input data
          diE   : in std_logic_vector(7 downto 0);    -- EVEN input data
          valid_out: out std_logic;
          doO   : out std_logic_vector(18 downto 0);	 -- ODD output data
          doE   : out std_logic_vector(18 downto 0)	 -- ODD output data
          );
end Parallel_tap_8_FIR_Filter_Behavioral;

architecture Behavioral of Parallel_tap_8_FIR_Filter_Behavioral is
---------------------------------------------------------------------------------
----------------------------STUFF SHARED BETWEEN OUTPUTS-------------------------

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

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------






----------------------------ODD OUTPUT-------------------------------------------
---------------------------------------------------------------------------------

    ------signals for ODD input-------------------------
    signal OO_X1, OO_X2, OO_X3, OO_X4 : std_logic_vector(7 downto 0);  -- the old inputs, ex: Xk = xO[n-k], left to right(from diagram)
    ----------------------------------------------------

    ------signals for EVEN input------------------------
    signal OE_X1, OE_X2, OE_X3 : std_logic_vector(7 downto 0);  -- the old inputs, ex: Xk = xE[n-k], left to right(from diagram)
    ----------------------------------------------------

    -----------------Vertical Stages--------------------
    signal ODD_A : std_logic_vector(7 downto 0); -- the register of phase A (first vertical stage)
    signal ODD_B1, ODD_B2 : std_logic_vector(7 downto 0); -- the registers of phase B (second vertical stage)
    signal ODD_C1, ODD_C2, ODD_C3 : std_logic_vector(7 downto 0); -- the registers of phase C (third vertical stage)
    signal ODD_D1, ODD_D2, ODD_D3, ODD_D4 : std_logic_vector(7 downto 0); -- the registers of phase D (fourth vertical stage)
    signal ODD_E1, ODD_E2, ODD_E3, ODD_E4, ODD_E5 : std_logic_vector(7 downto 0); -- the registers of phase E (fifth vertical stage)
    signal ODD_F1, ODD_F2, ODD_F3, ODD_F4, ODD_F5, ODD_F6 : std_logic_vector(7 downto 0); -- the registers of phase F (sixth vertical stage)
    signal ODD_G1, ODD_G2, ODD_G3, ODD_G4, ODD_G5, ODD_G6, ODD_G7 : std_logic_vector(7 downto 0); -- the registers of phase G (seventh vertical stage)
    signal ODD_H1, ODD_H2, ODD_H3, ODD_H4, ODD_H5, ODD_H6, ODD_H7, ODD_H8 : std_logic_vector(7 downto 0); -- the registers of phase H (eighth vertical stage)
    ----------------------------------------------------

   ------ODD products after the multiplications------------
   signal ODD_Pr0 : std_logic_vector(15 downto 0);
   signal ODD_Pr1 : std_logic_vector(15 downto 0);
   signal ODD_Pr2 : std_logic_vector(15 downto 0);
   signal ODD_Pr3 : std_logic_vector(15 downto 0);
   signal ODD_Pr4 : std_logic_vector(15 downto 0);
   signal ODD_Pr5 : std_logic_vector(15 downto 0);
   signal ODD_Pr6 : std_logic_vector(15 downto 0);
   signal ODD_Pr7 : std_logic_vector(15 downto 0);
   --------------------------------------------------------

    -------ODD sums afer the additions----------------------
    signal ODD_Sum0 : std_logic_vector(18 downto 0);
    signal ODD_Sum1 : std_logic_vector(18 downto 0);
    signal ODD_Sum2 : std_logic_vector(18 downto 0);
    signal ODD_Sum3 : std_logic_vector(18 downto 0);
    signal ODD_Sum4 : std_logic_vector(18 downto 0);
    signal ODD_Sum5 : std_logic_vector(18 downto 0);
    signal ODD_Sum6 : std_logic_vector(18 downto 0);
    signal ODD_Sum7 : std_logic_vector(18 downto 0);
    --------------------------------------------------------

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------








---------------------------------------------------------------------------------
----------------------------EVEN OUTPUT------------------------------------------

    ------signals for ODD input-------------------------
    signal EO_X1, EO_X2, EO_X3, EO_X4 : std_logic_vector(7 downto 0);  -- the old inputs, ex: Xk = xO[n-k], left to right(from diagram)
    ----------------------------------------------------

    ------signals for EVEN input------------------------
    signal EE_X1, EE_X2, EE_X3, EE_X4 : std_logic_vector(7 downto 0);  -- the old inputs, ex: Xk = xE[n-k], left to right(from diagram)
    ----------------------------------------------------

    -----------------Vertical Stages--------------------
    signal EVEN_A : std_logic_vector(7 downto 0); -- the register of phase A (first vertical stage)
    signal EVEN_B1, EVEN_B2 : std_logic_vector(7 downto 0); -- the registers of phase B (second vertical stage)
    signal EVEN_C1, EVEN_C2, EVEN_C3 : std_logic_vector(7 downto 0); -- the registers of phase C (third vertical stage)
    signal EVEN_D1, EVEN_D2, EVEN_D3, EVEN_D4 : std_logic_vector(7 downto 0); -- the registers of phase D (fourth vertical stage)
    signal EVEN_E1, EVEN_E2, EVEN_E3, EVEN_E4, EVEN_E5 : std_logic_vector(7 downto 0); -- the registers of phase E (fifth vertical stage)
    signal EVEN_F1, EVEN_F2, EVEN_F3, EVEN_F4, EVEN_F5, EVEN_F6 : std_logic_vector(7 downto 0); -- the registers of phase F (sixth vertical stage)
    signal EVEN_G1, EVEN_G2, EVEN_G3, EVEN_G4, EVEN_G5, EVEN_G6, EVEN_G7 : std_logic_vector(7 downto 0); -- the registers of phase G (seventh vertical stage)
    signal EVEN_H1, EVEN_H2, EVEN_H3, EVEN_H4, EVEN_H5, EVEN_H6, EVEN_H7, EVEN_H8 : std_logic_vector(7 downto 0); -- the registers of phase H (eighth vertical stage)
    ----------------------------------------------------

    ------EVEN products after the multiplications----------
    signal EVEN_Pr0 : std_logic_vector(15 downto 0);
    signal EVEN_Pr1 : std_logic_vector(15 downto 0);
    signal EVEN_Pr2 : std_logic_vector(15 downto 0);
    signal EVEN_Pr3 : std_logic_vector(15 downto 0);
    signal EVEN_Pr4 : std_logic_vector(15 downto 0);
    signal EVEN_Pr5 : std_logic_vector(15 downto 0);
    signal EVEN_Pr6 : std_logic_vector(15 downto 0);
    signal EVEN_Pr7 : std_logic_vector(15 downto 0);
    --------------------------------------------------------

    -------EVEN sums afer the additions---------------------
    signal EVEN_Sum0 : std_logic_vector(18 downto 0);
    signal EVEN_Sum1 : std_logic_vector(18 downto 0);
    signal EVEN_Sum2 : std_logic_vector(18 downto 0);
    signal EVEN_Sum3 : std_logic_vector(18 downto 0);
    signal EVEN_Sum4 : std_logic_vector(18 downto 0);
    signal EVEN_Sum5 : std_logic_vector(18 downto 0);
    signal EVEN_Sum6 : std_logic_vector(18 downto 0);
    signal EVEN_Sum7 : std_logic_vector(18 downto 0);
    --------------------------------------------------------

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

    -------counter for valid_out----------------------------
    signal counter : std_logic_vector(4 downto 0) := "00000";
    --------------------------------------------------------






    begin
        process(clk, rst)
        begin
            if(rst='1') then
                valid_out <= '0';
                counter<= "00000";
                doO <= (others => '0'); 
                
            ---------------------------------------------------------------------------------------------------------------
            ------------------------------------EVEN RESET-----------------------------------------------------------------

                ------signals for ODD input-------------------------
                EO_X1 <= (others => '0');
                EO_X2 <= (others => '0');
                EO_X3 <= (others => '0');
                EO_X4 <= (others => '0');
                ----------------------------------------------------

                ------signals for EVEN input------------------------
                EE_X1 <= (others => '0');
                EE_X2 <= (others => '0');
                EE_X3 <= (others => '0');
                EE_X4 <= (others => '0');
                ----------------------------------------------------

                -----------------Vertical Stages--------------------
                EVEN_A <= (others => '0'); 
                EVEN_B1 <= (others => '0'); EVEN_B2 <= (others => '0'); 
                EVEN_C1 <= (others => '0'); EVEN_C2 <= (others => '0'); EVEN_C3 <= (others => '0');
                EVEN_E1 <= (others => '0'); EVEN_E2 <= (others => '0'); EVEN_E3 <= (others => '0'); EVEN_E4 <= (others => '0'); EVEN_E5 <= (others => '0');
                EVEN_F1 <= (others => '0'); EVEN_F2 <= (others => '0'); EVEN_F3 <= (others => '0'); EVEN_F4 <= (others => '0'); EVEN_F5 <= (others => '0'); EVEN_F6 <= (others => '0');
                EVEN_G1 <= (others => '0'); EVEN_G2 <= (others => '0'); EVEN_G3 <= (others => '0'); EVEN_G4 <= (others => '0'); EVEN_G5 <= (others => '0'); EVEN_G6 <= (others => '0'); EVEN_G7 <= (others => '0');
                EVEN_H1 <= (others => '0'); EVEN_H2 <= (others => '0'); EVEN_H3 <= (others => '0'); EVEN_H4 <= (others => '0'); EVEN_H5 <= (others => '0'); EVEN_H6 <= (others => '0'); EVEN_H7 <= (others => '0'); EVEN_H8 <= (others => '0');
                ---------------------------------------------------- 

                ------EVEN products after the multiplications------------
                EVEN_Pr0 <= (others => '0');
                EVEN_Pr1 <= (others => '0');
                EVEN_Pr2 <= (others => '0');
                EVEN_Pr3 <= (others => '0');
                EVEN_Pr4 <= (others => '0');
                EVEN_Pr5 <= (others => '0');
                EVEN_Pr6 <= (others => '0');
                EVEN_Pr7 <= (others => '0');
                --------------------------------------------------------

                -------EVEN sums afer the additions----------------------
                EVEN_Sum0 <= (others => '0');
                EVEN_Sum1 <= (others => '0');
                EVEN_Sum2 <= (others => '0');
                EVEN_Sum3 <= (others => '0');
                EVEN_Sum4 <= (others => '0');
                EVEN_Sum5 <= (others => '0');
                EVEN_Sum6 <= (others => '0');
                EVEN_Sum7 <= (others => '0');
                --------------------------------------------------------

                -----------------output reset---------------------------
                doE <= (others => '0');
                --------------------------------------------------------

            ---------------------------------------------------------------------------------------------------------------
            ---------------------------------------------------------------------------------------------------------------

            ---------------------------------------------------------------------------------------------------------------
            -------------------------------------ODD RESET-----------------------------------------------------------------
            
                ------signals for ODD input-------------------------
                OO_X1 <= (others => '0');
                OO_X2 <= (others => '0');
                OO_X3 <= (others => '0');
                OO_X4 <= (others => '0');
                ----------------------------------------------------

                ------signals for EVEN input------------------------
                OE_X1 <= (others => '0');
                OE_X2 <= (others => '0');
                OE_X3 <= (others => '0');
                ----------------------------------------------------
                
                -----------------Vertical Stages--------------------
                ODD_A <= (others => '0'); 
                ODD_B1 <= (others => '0'); ODD_B2 <= (others => '0'); 
                ODD_C1 <= (others => '0'); ODD_C2 <= (others => '0'); ODD_C3 <= (others => '0');
                ODD_E1 <= (others => '0'); ODD_E2 <= (others => '0'); ODD_E3 <= (others => '0'); ODD_E4 <= (others => '0'); ODD_E5 <= (others => '0');
                ODD_F1 <= (others => '0'); ODD_F2 <= (others => '0'); ODD_F3 <= (others => '0'); ODD_F4 <= (others => '0'); ODD_F5 <= (others => '0'); ODD_F6 <= (others => '0');
                ODD_G1 <= (others => '0'); ODD_G2 <= (others => '0'); ODD_G3 <= (others => '0'); ODD_G4 <= (others => '0'); ODD_G5 <= (others => '0'); ODD_G6 <= (others => '0'); ODD_G7 <= (others => '0');
                ODD_H1 <= (others => '0'); ODD_H2 <= (others => '0'); ODD_H3 <= (others => '0'); ODD_H4 <= (others => '0'); ODD_H5 <= (others => '0'); ODD_H6 <= (others => '0'); ODD_H7 <= (others => '0'); ODD_H8 <= (others => '0');
                ---------------------------------------------------- 
                
                ------ODD products after the multiplications------------
                ODD_Pr0 <= (others => '0');
                ODD_Pr1 <= (others => '0');
                ODD_Pr2 <= (others => '0');
                ODD_Pr3 <= (others => '0');
                ODD_Pr4 <= (others => '0');
                ODD_Pr5 <= (others => '0');
                ODD_Pr6 <= (others => '0');
                ODD_Pr7 <= (others => '0');
                --------------------------------------------------------

                -------ODD sums afer the additions----------------------
                ODD_Sum0 <= (others => '0');
                ODD_Sum1 <= (others => '0');
                ODD_Sum2 <= (others => '0');
                ODD_Sum3 <= (others => '0');
                ODD_Sum4 <= (others => '0');
                ODD_Sum5 <= (others => '0');
                ODD_Sum6 <= (others => '0');
                ODD_Sum7 <= (others => '0');
                --------------------------------------------------------
                
            ---------------------------------------------------------------------------------------------------------------
            ---------------------------------------------------------------------------------------------------------------
           elsif(rising_edge(clk)) and (valid_in='1') then
                if(counter>13) then
                    valid_out<= '1';
                else
                    valid_out<='0';
                    counter<= counter+1;
                end if;    
        ----------------------------------------------
        ----------register shifting------------------

                ------------EVEN output---------------
                EO_X1<=diO;   
                EO_X2<=EO_X1;
                EO_X3<=EO_X2; 
                EO_X4<=EO_X3; 

                
                EE_X1<=diE;   
                EE_X2<=EE_X1;
                EE_X3<=EE_X2;  
                EE_X4<=EE_X3;
                --------------------------------------

                ------------ODD output----------------
                OE_X1<=diE;   
                OE_X2<=OE_X1;
                OE_X3<=OE_X2;

                
                OO_X1<=diO;   
                OO_X2<=OO_X1;
                OO_X3<=OO_X2;
                OO_X4<=OO_X3;
                --------------------------------------

        ----------------------------------------------
        ----------------------------------------------



        -----------------------------------------------------------------------------------------
        ---------before the multiplications delays----------------------------------------------

                ------------EVEN output---------------
                EVEN_A <= EE_X1;
                EVEN_B1 <= EO_X1; EVEN_B2 <= EVEN_B1;
                EVEN_C1 <= EE_X2; EVEN_C2 <= EVEN_C1; EVEN_C3 <= EVEN_C2;
                EVEN_D1 <= EO_X2; EVEN_D2 <= EVEN_D1; EVEN_D3 <= EVEN_D2; EVEN_D4 <= EVEN_D3;
                EVEN_E1 <= EE_X3; EVEN_E2 <= EVEN_E1; EVEN_E3 <= EVEN_E2; EVEN_E4 <= EVEN_E3; EVEN_E5 <= EVEN_E4;
                EVEN_F1 <= EO_X3; EVEN_F2 <= EVEN_F1; EVEN_F3 <= EVEN_F2; EVEN_F4 <= EVEN_F3; EVEN_F5 <= EVEN_F4; EVEN_F6 <= EVEN_F5;
                EVEN_G1 <= EE_X4; EVEN_G2 <= EVEN_G1; EVEN_G3 <= EVEN_G2; EVEN_G4 <= EVEN_G3; EVEN_G5 <= EVEN_G4; EVEN_G6 <= EVEN_G5; EVEN_G7 <= EVEN_G6;
                EVEN_H1 <= EO_X4; EVEN_H2 <= EVEN_H1; EVEN_H3 <= EVEN_H2; EVEN_H4 <= EVEN_H3; EVEN_H5 <= EVEN_H4; EVEN_H6 <= EVEN_H5; EVEN_H7 <= EVEN_H6; EVEN_H8 <= EVEN_H7;               
                --------------------------------------




                ------------ODD output----------------
                ODD_A <= OO_X1; 
                ODD_B1 <= diE; ODD_B2 <= ODD_B1;
                ODD_C1 <= OO_X2; ODD_C2 <= ODD_C1; ODD_C3 <= ODD_C2;
                ODD_D1 <= OE_X1; ODD_D2 <= ODD_D1; ODD_D3 <= ODD_D2; ODD_D4 <= ODD_D3;
                ODD_E1 <= OO_X3; ODD_E2 <= ODD_E1; ODD_E3 <= ODD_E2; ODD_E4 <= ODD_E3; ODD_E5 <= ODD_E4;
                ODD_F1 <= OE_X2; ODD_F2 <= ODD_F1; ODD_F3 <= ODD_F2; ODD_F4 <= ODD_F3; ODD_F5 <= ODD_F4; ODD_F6 <= ODD_F5;
                ODD_G1 <= OO_X4; ODD_G2 <= ODD_G1; ODD_G3 <= ODD_G2; ODD_G4 <= ODD_G3; ODD_G5 <= ODD_G4; ODD_G6 <= ODD_G5; ODD_G7 <= ODD_G6;
                ODD_H1 <= OE_X3; ODD_H2 <= ODD_H1; ODD_H3 <= ODD_H2; ODD_H4 <= ODD_H3; ODD_H5 <= ODD_H4; ODD_H6 <= ODD_H5; ODD_H7 <= ODD_H6; ODD_H8 <= ODD_H7;                 
                --------------------------------------

        -----------------------------------------------------------------------------------------
        -----------------------------------------------------------------------------------------


        ------------------------------------
        --------Products--------------------
                --We observe the factors are swapped -> that's the right sequence for parallel implementation(of y[2n])!
                ------------EVEN output---------------
                EVEN_Pr0 <= Co1 * EVEN_A;
                EVEN_Pr1 <= Co0 * EVEN_B2;
                EVEN_Pr2 <= Co3 * EVEN_C3;
                EVEN_Pr3 <= Co2 * EVEN_D4;
                EVEN_Pr4 <= Co5 * EVEN_E5;
                EVEN_Pr5 <= Co4 * EVEN_F6;
                EVEN_Pr6 <= Co7 * EVEN_G7;
                EVEN_Pr7 <= Co6 * EVEN_H8;
                --------------------------------------
                
                --We observe the factors are swapped -> that's the right sequence for parallel implementation(of y[2n+1])!
                ------------ODD output----------------
                ODD_Pr0 <= Co1 * ODD_A;
                ODD_Pr1 <= Co0 * ODD_B2;
                ODD_Pr2 <= Co3 * ODD_C3;
                ODD_Pr3 <= Co2 * ODD_D4;
                ODD_Pr4 <= Co5 * ODD_E5;
                ODD_Pr5 <= Co4 * ODD_F6;
                ODD_Pr6 <= Co7 * ODD_G7;
                ODD_Pr7 <= Co6 * ODD_H8;               
                --------------------------------------

        ------------------------------------
        ------------------------------------


        --------------------------------------------
        ----------Sums------------------------------

                ------------EVEN output---------------
                EVEN_Sum0 <= "0000000000000000000" + EVEN_Pr0;
                EVEN_Sum1 <= EVEN_Sum0 + EVEN_Pr1;
                EVEN_Sum2 <= EVEN_Sum1 + EVEN_Pr2;
                EVEN_Sum3 <= EVEN_Sum2 + EVEN_Pr3;
                EVEN_Sum4 <= EVEN_Sum3 + EVEN_Pr4;
                EVEN_Sum5 <= EVEN_Sum4 + EVEN_Pr5;
                EVEN_Sum6 <= EVEN_Sum5 + EVEN_Pr6;
                EVEN_Sum7 <= EVEN_Sum6 + EVEN_Pr7;                
                --------------------------------------

                
                ------------ODD output----------------
                ODD_Sum0 <= "0000000000000000000" + ODD_Pr0;
                ODD_Sum1 <= ODD_Sum0 + ODD_Pr1;
                ODD_Sum2 <= ODD_Sum1 + ODD_Pr2;
                ODD_Sum3 <= ODD_Sum2 + ODD_Pr3;
                ODD_Sum4 <= ODD_Sum3 + ODD_Pr4;
                ODD_Sum5 <= ODD_Sum4 + ODD_Pr5;
                ODD_Sum6 <= ODD_Sum5 + ODD_Pr6;
                ODD_Sum7 <= ODD_Sum6 + ODD_Pr7;               
                --------------------------------------

        --------------------------------------------
        --------------------------------------------

        --------------------------------------------
        -----------output---------------------------
                doO <= ODD_Sum7;
                doE <= EVEN_Sum7;
        --------------------------------------------
        --------------------------------------------

            end if;      
        end process;


    end Behavioral;
