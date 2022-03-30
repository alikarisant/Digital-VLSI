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
  signal B3 : std_logic_vector(9 downto 0);
  signal Dp0 : std_logic_vector(8 downto 0):= "000000000";
  signal Dp1, B2 : std_logic_vector(7 downto 0);
  signal Dp2, A3 : std_logic_vector(6 downto 0);
  signal Dp3, A2, B1 : std_logic_vector(5 downto 0);
  signal Dp4 : std_logic_vector(4 downto 0);
  signal Dp5 : std_logic_vector(3 downto 0);
  signal C0,C1,C2,A1 :  std_logic_vector(4 downto 0);
  signal A0,C3, B0 :  std_logic_vector(3 downto 0);  
begin

    A3(2) <= '0'; Dp1(2) <= '0'; Dp1(3) <= '0'; Dp1(4) <= '0'; Dp1(5) <= '0'; Dp1(6) <= '0'; Dp1(7) <= '0';
    A3(1) <= '0'; A3(0) <= '0'; A2(1) <= '0'; A2(0) <= '0'; A1(0) <= '0';
    B1(1) <= '0';
    B1(0) <= '0';
    B2(3) <= '0';
    B2(2) <= '0';
    B2(1) <= '0';
    B2(0) <= '0';
    B3(5) <= '0';
    B3(4) <= '0';
    B3(3) <= '0';
    B3(2) <= '0';
    B3(1) <= '0';
    B3(0) <= '0';
    Dp2(3) <= '0'; Dp2(4) <= '0'; Dp2(5) <= '0'; Dp2(6) <= '0';
    Dp3(4) <= '0'; Dp3(5) <= '0'; Dp4(4) <= '0'; C0(4) <= '0'; C1(4) <= '0'; C2(4) <= '0'; 
  pipeline_proc: process(clk, rst)
      begin
    if(rst = '1') then
        Dp0 <= "000000000";
     elsif(clk'event and clk = '1') then
        Product(0) <= Dp0(8); Product(1) <= Dp1(7); Product(2) <= Dp2(6); Product(3) <= Dp3(5); Product(4) <= Dp4(4); Product(5) <= Dp5(3);
        FOR i IN 1 TO 8 LOOP
            Dp0(i) <= Dp0(i-1);
        END LOOP;
        
        FOR i IN 2 TO 7 LOOP
            Dp1(i) <= Dp1(i-1);
        END LOOP;
        
        FOR i IN 3 TO 6 LOOP
            Dp2(i) <= Dp2(i-1);
        END LOOP;
        
        Dp3(5) <= Dp3(4); Dp3(4) <= Dp3(3); Dp4(4) <= Dp4(3);
        A1(0) <= A(1); A2(1) <= A2(0); A2(0) <= A(2); A3(2) <= A3(1); A3(1) <= A3(0); A3(0) <= A(3);
        B1(1) <= B1(0); B1(0) <= B(1); B2(3) <= B2(2); B2(2) <= B2(1); B2(1) <= B2(0); B2(0) <= B(2);
        C0(4) <= C0(3); C1(4) <= C1(3); C2(4) <= C2(3);
        FOR i IN 1 TO 5 LOOP
            B3(i) <= B3(i-1);
        END LOOP;
        B3(0) <= B(3);
        
         
     end if;
  end process;
  
  
  Building_Block_INSTANCE_0: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => A(0),
               Bin => B(0),
               Cin => '0',
               Sout => Dp0(0),
               Cout => C0(0),
               Aout => A0(0),
               Bout => B0(0));

Building_Block_INSTANCE_1: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => A1(0),
               Bin => B0(0),
               Cin => C0(0),
               Sout => Dp1(0),
               Cout => C0(1),
               Aout => A1(1),
               Bout => B0(1));    

Building_Block_INSTANCE_2: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => A2(1),
               Bin => B0(1),
               Cin => C0(1),
               Sout => Dp2(0),
               Cout => C0(2),
               Aout => A2(2),
               Bout => B0(2));

Building_Block_INSTANCE_3: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => '0',
               Ain => A3(2),
               Bin => B0(2),
               Cin => C0(2),
               Sout => Dp3(0),
               Cout => C0(3),
               Aout => A3(3),
               Bout => B0(3));    

Building_Block_INSTANCE_4: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp1(0),
               Ain => A0(0),
               Bin => B1(1),
               Cin => '0',
               Sout => Dp1(1),
               Cout => C1(0),
               Aout => A0(1),
               Bout => B1(2));
               
Building_Block_INSTANCE_5: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp2(0),
               Ain => A1(1),
               Bin => B1(2),
               Cin => C1(0),
               Sout => Dp2(1),
               Cout => C1(1),
               Aout => A1(2),
               Bout => B1(3));

Building_Block_INSTANCE_6: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp3(0),
               Ain => A2(2),
               Bin => B1(3),
               Cin => C1(1),
               Sout => Dp3(1),
               Cout => C1(2),
               Aout => A2(3),
               Bout => B1(4));    

Building_Block_INSTANCE_7: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => C0(4),
               Ain => A3(3),
               Bin => B1(4),
               Cin => C1(2),
               Sout => Dp4(1),
               Cout => C1(3),
               Aout => A3(4),
               Bout => B1(5));
               
Building_Block_INSTANCE_8: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp2(1),
               Ain => A0(1),
               Bin => B2(3),
               Cin => '0',
               Sout => Dp2(2),
               Cout => C2(0),
               Aout => A0(2),
               Bout => B2(4));
               
Building_Block_INSTANCE_9: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp3(1),
               Ain => A1(2),
               Bin => B2(4),
               Cin => C2(0),
               Sout => Dp3(2),
               Cout => C2(1),
               Aout => A1(3),
               Bout => B2(5));

Building_Block_INSTANCE_10: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp4(1),
               Ain => A2(3),
               Bin => B2(5),
               Cin => C2(1),
               Sout => Dp4(2),
               Cout => C2(2),
               Aout => A2(4),
               Bout => B2(6));    

Building_Block_INSTANCE_11: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => C1(4),
               Ain => A3(4),
               Bin => B2(6),
               Cin => C2(2),
               Sout => Dp5(2),
               Cout => C2(3),
               Aout => A3(5),
               Bout => B2(7));

Building_Block_INSTANCE_12: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp3(2),
               Ain => A0(2),
               Bin => B3(5),
               Cin => '0',
               Sout => Dp3(3),
               Cout => C3(0),
               Aout => A0(3),
               Bout => B3(6));
               
Building_Block_INSTANCE_13: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp4(2),
               Ain => A1(3),
               Bin => B3(6),
               Cin => C3(0),
               Sout => Dp4(3),
               Cout => C3(1),
               Aout => A1(4),
               Bout => B3(7));

Building_Block_INSTANCE_14: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => Dp5(2),
               Ain => A2(4),
               Bin => B3(7),
               Cin => C3(1),
               Sout => Dp5(3),
               Cout => C3(2),
               Aout => A2(5),
               Bout => B3(8));    

Building_Block_INSTANCE_15: Building_Block
    port map ( clk => clk,
               rst => rst,
               Sin => C2(4),
               Ain => A3(5),
               Bin => B3(8),
               Cin => C3(2),
               Sout => Product(6), 
               Cout => Product(7),
               Aout => A3(6),
               Bout => B3(9));


end Structural;
