library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Sychronous_Systolic_4bit_Multiplier is
    Port ( clk : in std_logic;
           rst : in std_logic;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Product : out STD_LOGIC_VECTOR (7 downto 0));
end Sychronous_Systolic_4bit_Multiplier;

architecture Structural of Sychronous_Systolic_4bit_Multiplier is

    component Building_Block is
    port(
       clk : in std_logic;
       rst : in std_logic;
       Sin : in std_logic;
       Ain : in std_logic;
       Bin : in std_logic;
       Cin : in std_logic;
       Sout: out std_logic;
       Cout: out std_logic;
       Aout: out std_logic;
       Bout: out std_logic
        );
  end component;
  
  --Signals regarding subtotals
  signal P0 : std_logic_vector(9 downto 0):="0000000000"; --ready
  signal P1 : std_logic_vector(8 downto 0):="000000000"; --ready
  signal P2 : std_logic_vector(7 downto 0):="00000000"; --ready
  signal P3 : std_logic_vector(6 downto 0):="0000000"; --ready
  signal P4 : std_logic_vector(4 downto 0):="00000"; --ready 
  signal P5 : std_logic_vector(2 downto 0):="000"; --ready
  signal P6 : std_logic:='0'; --ready
  signal P7 : std_logic:='0'; --ready
  
  --signals regarding internal transports
  signal C0 : std_logic_vector(3 downto 0):="0000"; --Cout each gate
  signal C1 : std_logic_vector(3 downto 0):="0000"; --Cout each gate
  signal C2 : std_logic_vector(3 downto 0):="0000"; --Cout each gate
  signal C3 : std_logic_vector(3 downto 0):="0000"; --Cout each gate
  signal A0 : std_logic_vector(3 downto 0):="0000"; --diagonal
  signal A1 : std_logic_vector(3 downto 0):="0000"; --diagonal
  signal A2 : std_logic_vector(3 downto 0):="0000"; --diagonal
  signal A3 : std_logic_vector(3 downto 0):="0000"; --diagonal
  signal B0 : std_logic_vector(3 downto 0):="0000"; --straight
  signal B1 : std_logic_vector(3 downto 0):="0000"; --straight
  signal B2 : std_logic_vector(3 downto 0):="0000"; --straight
  signal B3 : std_logic_vector(3 downto 0):="0000"; --straight
  
  --delays for A
  signal delayA1 : std_logic:='0';
  signal delayA2,delayA3 : std_logic:='0';
  signal delayA4,delayA5,delayA6 : std_logic:='0';
  
  --delays for B
  signal delayB1,delayB2 : std_logic:='0';
  signal delayB3,delayB4 : std_logic:='0';
  signal delayB5,delayB6,delayB7 : std_logic:='0';
  signal delayB8,delayB9,delayB10 : std_logic:='0';
  signal delayB11,delayB12,delayB13,delayB14 : std_logic:='0';
  --delays for C
  signal delayC1,delayC3 : std_logic:='0';
  signal delayC2,delayC4 : std_logic:='0';
  signal delayC5,delayC6 : std_logic:='0';
begin
  
  Building_Block_INSTANCE_0: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => A(0),
               Bin => B(0),
               Cin => '0',
               Sout => P0(0),
               Cout => C0(0),
               Aout => A0(0),
               Bout => B0(0));

 delay_P0:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(0) <= P0(9);
    P0(9) <= P0(8);
    P0(8) <= P0(7);
    P0(7) <= P0(6);
    P0(6) <= P0(5);
    P0(5) <= P0(4);
    P0(4) <= P0(3);
    P0(3) <= P0(2);
    P0(2) <= P0(1);
    P0(1) <= P0(0);
  end if;
end process;
               
 delay_1:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayA1 <= A(1);
  end if;
end process;

  Building_Block_INSTANCE_1: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => delayA1,
               Bin => B0(0),
               Cin => C0(0),
               Sout =>P1(0),
               Cout => C0(1),
               Aout => A1(0),
               Bout => B0(1));
               
 delay_2:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayA2 <= delayA3;
    delayA3 <= A(2);
  end if;
end process;

  Building_Block_INSTANCE_2: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => delayA2,
               Bin => B0(1),
               Cin => C0(1),
               Sout =>P2(0),
               Cout => C0(2),
               Aout => A2(0),
               Bout => B0(2));

 delay_3:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayA4 <= delayA5;
    delayA5 <= delayA6;
    delayA6 <= A(3);
  end if;
end process;

  Building_Block_INSTANCE_3: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => delayA4,
               Bin => B0(2),
               Cin => C0(1),
               Sout =>P3(0),
               Cout => C0(3),
               Aout => A3(0),
               Bout => B0(3));

 delay_4:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayB1 <= delayB2;
    delayB2 <= B(1);
  end if;
end process;

  Building_Block_INSTANCE_4: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P1(0),
               Ain => A0(0),
               Bin => delayB1,
               Cin => '0',
               Sout =>P1(1),
               Cout => C1(0),
               Aout => A0(1),
               Bout => B1(0));

 delay_P1:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(1) <= P1(8);
    P1(8) <= P1(7);
    P1(7) <= P1(6);
    P1(6) <= P1(5);
    P1(5) <= P1(4);
    P1(4) <= P1(3);
    P1(3) <= P1(2);
    P1(2) <= P1(1);
  end if;
end process;

  Building_Block_INSTANCE_5: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P2(0),
               Ain => A1(0),
               Bin => B1(0),
               Cin => C1(0),
               Sout =>P2(1),
               Cout => C1(1),
               Aout => A1(1),
               Bout => B1(1));

  Building_Block_INSTANCE_6: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P3(0),
               Ain => A2(0),
               Bin => B1(1),
               Cin => C1(1),
               Sout =>P3(1),
               Cout => C1(2),
               Aout => A2(1),
               Bout => B1(2));

 delay_5:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayC1 <= delayC2;
    delayC2 <= C0(3);
  end if;
end process;

  Building_Block_INSTANCE_7: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => delayC1,
               Ain => A3(0),
               Bin => B1(2),
               Cin => C1(2),
               Sout =>P4(0),
               Cout => C1(3),
               Aout => A3(1),
               Bout => B1(3));

 delay_6:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayB3 <= delayB4;
    delayB5 <= delayB6;
    delayB6 <= delayB7;
    delayB7 <= B(2);
  end if;
end process;

  Building_Block_INSTANCE_8: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P2(1),
               Ain => A0(1),
               Bin => delayB3,
               Cin => '0',
               Sout =>P2(2),
               Cout => C2(0),
               Aout => A0(2),
               Bout => B2(0));

 delay_P2:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(2) <= P2(7);
    P2(7) <= P2(6);
    P2(6) <= P2(5);
    P2(5) <= P2(4);
    P2(4) <= P2(3);
    P2(3) <= P2(2);
  end if;
end process;

  Building_Block_INSTANCE_9: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P3(1),
               Ain => A1(1),
               Bin => B2(0),
               Cin => C2(0),
               Sout =>P3(2),
               Cout => C2(1),
               Aout => A1(2),
               Bout => B2(1));

  Building_Block_INSTANCE_10: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P4(0),
               Ain => A2(1),
               Bin => B2(1),
               Cin => C2(1),
               Sout =>P4(1),
               Cout => C2(2),
               Aout => A2(2),
               Bout => B2(2));

 delay_7:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayC3 <= delayC4;
    delayC4 <= C1(3);
  end if;
end process;

  Building_Block_INSTANCE_11: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => delayC3,
               Ain => A3(1),
               Bin => B2(2),
               Cin => C2(2),
               Sout =>P5(0),
               Cout => C2(3),
               Aout => A3(2),
               Bout => B2(3));

 delay_8:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayB8 <= delayB9;
    delayB9 <= delayB10;
    delayB10 <= delayB11;
    delayB12 <= delayB13;
    delayB13 <= delayB14;
    delayB14 <= B(3);
  end if;
end process;

  Building_Block_INSTANCE_12: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P3(2),
               Ain => A0(2),
               Bin => delayB8,
               Cin => '0',
               Sout =>P3(3),
               Cout => C3(0),
               Aout => A0(3),
               Bout => B3(0));
 
 delay_P3:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(3) <= P3(6);
    P3(6) <= P3(5);
    P3(5) <= P3(4);
    P3(4) <= P3(3);    
  end if;
end process; 
               
  Building_Block_INSTANCE_13: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P4(1),
               Ain => A1(2),
               Bin => B3(0),
               Cin => C3(0),
               Sout =>P4(2),
               Cout => C3(1),
               Aout => A1(3),
               Bout => B3(1));

 delay_P4:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(4) <= P4(4);
    P4(4) <= P4(3);
    P4(3) <= P4(2);   
  end if;
end process;

  Building_Block_INSTANCE_14: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => P5(0),
               Ain => A2(2),
               Bin => B3(1),
               Cin => C3(1),
               Sout =>P5(1),
               Cout => C3(2),
               Aout => A2(3),
               Bout => B3(2));

 delay_P5:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(5) <= P5(2);
    P5(2) <= P5(1);   
  end if;
end process;

 delay_9:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    delayC5 <= delayC6;
    delayC6 <= C2(3);
  end if;
end process;

  Building_Block_INSTANCE_15: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => delayC5,
               Ain => A3(2),
               Bin => B3(2),
               Cin => C3(2),
               Sout =>P6,
               Cout => P7,
               Aout => A3(3),
               Bout => B3(3));

 delay_P6_P7:process (clk)		--5 clock cycles
begin
  if rising_edge(clk) then
    Product(7) <= P7;
    Product(6) <= P6;   
  end if;
end process;
           
end Structural;
