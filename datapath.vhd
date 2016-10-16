library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is
	port(
			clk : in std_logic;
			inst : in std_logic_vector(31 downto 0)
		);
end datapath;

architecture behavioral of datapath is
component alu
	port (
      input_a :in std_LOGIC_VECTOR(31 downto 0):= (others => '1');
	  input_b : in std_LOGIC_VECTOR(31 downto 0):= (others => '1');
	  opcode :in std_LOGIC_VECTOR(3 downto 0):= (others => '1');
	  result : out std_LOGIC_VECTOR(31 downto 0);
	  carryin : in std_LOGiC;
	  Zerof , overflowf , carryflowf , negativef:out std_LOGiC
   );
end component;

component regFile 
    port (
	
        rad1  : in std_logic_vector(3 downto 0);
     rad2  : in std_logic_vector(3 downto 0);
     wad  : in std_logic_vector(3 downto 0);
     wd : in std_logic_vector(31 downto 0);
     clk : in std_logic;
     we : in std_logic;
     rd1 : out std_logic_vector(31 downto 0);
     rd2 : out std_logic_vector(31 downto 0)
    );
end component;

component muxtwotoone  
Port (input_sig1 ,input_sig2: in std_logic_vector(31 downto 0);
			s : in std_logic ;
          output_sig : out std_logic_vector(31 downto 0));
End component;

component muxtwotoonef  
Port (input_sig1 ,input_sig2: in std_logic_vector(3 downto 0);
			s : in std_logic ;
          output_sig : out std_logic_vector(3 downto 0));
End component;

component plusfouradder 
Port (input_sig1 ,input_sig2: in std_logic_vector(31 downto 0);
			
          output_sig : out std_logic_vector(31 downto 0));
End component;

component temp_reg 
    port (writed : in std_logic_vector(31 downto 0);
     clk : in std_logic;
     we : in std_logic;
     readd : out std_logic_vector(31 downto 0)
	 );
end component;

component muxfourtoone  
Port (input_sig1 ,input_sig2,input_sig3,input_sig4: in std_logic_vector(31 downto 0);
			s : in std_logic_vector(1 downto 0) ;
          output_sig : out std_logic_vector(31 downto 0));
End component;

component rotator 
    port (input : in std_logic_vector(7 downto 0);
		s_amt : in std_logic_vector(3 downto 0);
		
     output : out std_logic_vector(31 downto 0);
	 carryout : out std_logic
	 );
end component;

component shifter
    port (input : in std_logic_vector(31 downto 0);
		s_amt : in std_logic_vector(4 downto 0);
		s_type : in std_logic_vector(1 downto 0);
     output : out std_logic_vector(31 downto 0);
	 carryout : out std_logic
	 );
end component;

component signextension 
    Port (input_sig : in std_logic_vector(23 downto 0);
          output_sig : out std_logic_vector(31 downto 0));
End component;

component extension
	port(
		clk : in std_logic;
		inp : in std_logic_vector(11 downto 0);
		outp : out std_logic_vector(31 downto 0)
	);
end component;

component program_counter
	port(
		clk : in std_logic ;
		inp : in std_logic_vector(31 downto 0);
		outp : out std_logic_vector(31 downto 0)
		);
end component;

component data_memory
	port(
		clk : in std_logic ;
		write_enable  : in std_logic;
		addr : in std_logic_vector(7 downto 0);
		wd : in std_logic_vector(31 downto 0);
		rd : out std_logic_vector(31 downto 0)
		
	);
end component;

component instruction_memory
	port(
		clk : in std_logic ;
		addr : in std_logic_vector(7 downto 0);
		rd : out std_logic_vector(31 downto 0)
		
	);
end component;

component flag
	port(
		clk : in std_logic;
		Zi,Ni,Ci,Vi : in std_logic;
		S :in std_logic;
		Zo, No ,Co ,Vo : out std_logic
	);
end component;

component ext 
	port(
		inp : in std_logic_vector(11 downto 0);
		outp : out std_logic_vector(31 downto 0)
	);
end component;

component mul 
port(
	c : out ieee.numeric_std.unsigned (31 downto 0);
	x1,x2 : in ieee.numeric_std.unsigned (31 downto 0);
	clk : in std_logic
	);
end component;

component reg1 
	port(
		clk : in std_logic;
		write_en : in std_logic;
		inp1 ,inp2 : in std_logic_vector(31 downto 0);
		outp1 ,outp2 : out std_logic_vector(31 downto 0)
	);
end component;

component reg2 
	port(
		clk : in std_logic;
		write_en : in std_logic;
		inp1 ,inp2 ,inp3,inp4,inp5: in std_logic_vector(31 downto 0);
		outp1 ,outp2 ,outp3,outp4,outp5: out std_logic_vector(31 downto 0)
	);
end component;

signal ins , pc_in , pc_out , adder1_out  ,reg1_o1 ,reg1_o2 ,reg_in ,rd1,rd2 , s2_out ,ext_out ,reg2_o1,reg2_o2,aluip1r,reg2_o4,reg2_o5,shift_out , rot_out , sr_out,aluip2r: std_logic_vector(31 downto 0);
signal rad1 , rad2 ,opcode: std_logic_vector(3 downto 0);
signal reg1_c ,mul_c ,rsrc ,we,we2 ,shift_c,rot_c ,s_r ,asrc: std_logic;
signal aluresoutr , aluresout ,reg3_or2 : std_LOGIC_VECTOR(31 downto 0); 
signal fwd_a,fwd_b: std_LOGIC_VECTOR(1 downto 0);
signal zi,zo,ci,co,vi,vo,ni,no,fcontrol : std_logic;
signal aluinp1f , aluinp2f ,dmamuxr,dmbmuxr ,aluresoutr2,reg2_o3: std_LOGIC_VECTOR(31 downto 0);
signal m2R , mw ,mr,reg3_c,reg4_c ,fwd_c:std_LOGiC ;
signal dmaddr : std_LOGIC_VECTOR( 7 downto 0);
signal mwd , mrd ,mrdr: std_LOGIC_VECTOR(31 downto 0);
begin
	ins(31 downto 0) <= inst(31 downto 0);
	pc1 : program_counter port map
			(
				clk => clk ,
				inp => pc_in, 
				outp => pc_out
			);
	four_adder_1 : plusfouradder port map
					(
						input_sig1 => pc_out,
						input_sig2 => X"00000000",
						output_sig => adder1_out
					);
	ins_mem : instruction_memory port map
					(
						clk => clk,
						addr => pc_out(7 downto 0),
						rd => ins
					);
	reg1_comp : reg1 port map
					(
						clk => clk,
						write_en => reg1_c,
						inp1 => adder1_out,
						inp2 => ins ,
						outp1 => reg1_o1,
						outp2 => reg1_o2
					);
	mux1 : muxtwotoonef port map
						(
							input_sig1 => reg1_o2(19 downto 16),
							input_sig2 => reg1_o2(11 downto 8) ,
							s => mul_c,
							output_sig => rad1
						);
	mux2 : muxtwotoonef port map
						(
							input_sig1 => reg1_o2(3 downto 0),
							input_sig2 => reg1_o2(15 downto 12) ,
							s => rsrc,
							output_sig => rad2
						);		
	reg_file : regFile port map 
						(
							rad1 => rad1 ,
							rad2 => rad2 , 
							wad  => reg1_o2(15 downto 12) ,
							wd  => reg_in ,
							clk => clk ,
							we => we,
							rd1 => rd1 ,
							rd2 => rd2
						);
	s2 : signextension port map
						(
							input_sig => reg1_o2(23 downto 0),
							output_sig => s2_out
						);
	extn : ext port map 
				(
					inp => reg1_o2(11 downto 0),
					outp => ext_out
				);	
	reg2_comp : reg2 port map
						(
							clk => clk ,
							write_en => we2,
							inp1 => reg1_o1,
							inp2 => s2_out,
							inp3 => rd1,
							inp4 => rd2,
							inp5 => ext_out,
							outp1 => reg2_o1,
							outp2 => reg2_o2,
							outp3 => reg2_o3,
							outp4 => reg2_o4,
							outp5 => reg2_o5
						);
	shift1 : shifter port map
						( 
							s_amt => reg1_o2(11 downto 7 ),
							s_type =>reg1_o2(6 downto 5) , 
							input => reg2_o4 ,
							output => shift_out ,
							carryout => shift_c
						);
	rot1 : rotator port map
						(
							input => reg1_o2(7 downto 0) ,
							s_amt => reg1_o2(11 downto 8),
							output => rot_out ,
							carryout => rot_c
						);
	mux3 : muxtwotoone port map
							(
								input_sig1 => shift_out ,
								input_sig2 => rot_out,
								s =>s_r , 
								output_sig => sr_out
							);
	mux4 : muxtwotoone port map
							(
								input_sig1 => sr_out ,
								input_sig2 => ext_out,
								s =>asrc , 
								output_sig => aluip2r
							);
	alumux1f : muxfourtoone port map
							(
							
								input_sig1 => aluip1r,
								input_sig2 => aluresoutr ,
								input_sig3 => dmamuxr ,
								input_sig4 => X"00000000" ,
								s => fwd_a,
								output_sig => aluinp1f
							);	
	alumux2f : muxfourtoone port map
							(
							
								input_sig1 => aluip2r,
								input_sig2 => aluresoutr ,
								input_sig3 => dmamuxr ,
								input_sig4 => X"00000000" ,
								s => fwd_b,
								output_sig => aluinp2f
							);	
	reg_3comp :reg1 port map 
							(
								clk => clk,
								write_en => reg3_c,
								inp1 => aluresout,
								inp2 => reg2_o4 ,
								outp1 => aluresoutr,
								outp2 => reg3_or2
							);
	
	aluins : alu port map 
							(
							input_a => aluinp1f,
							input_b => aluinp2f,
							opcode => opcode ,
							result => aluresout,
							carryin => co ,
							Zerof =>zi,
							carryflowf => ci,
							negativef =>ni,
							overflowf => vi
							
							);
							
    flagins : flag port map
							(
							clk => clk ,
							zi => zi,
							zo => zo,
							ci => ci,
							co => co,
							vi => vi,
							vo => vo,
							ni => ni,
							no => no,
							s => fcontrol		
							);	
	dmamux : muxtwotoone port map
							(
								input_sig1 => mrdr ,
								input_sig2 => aluresoutr2,
								s =>m2R , 
								output_sig => dmamuxr
							);
	datamemory : data_memory port map 
							(
								clk => clk,
								write_enable => mr,
								addr => dmaddr,
								wd => dmbmuxr ,
								rd => mrd
							);	
	dmbmux : muxtwotoone port map 
							(
								input_sig1 => reg3_or2 ,
								input_sig2 => dmamuxr,
								s =>fwd_c , 
								output_sig => dmbmuxr
							);	
	reg_4comp : reg1 port map
							(
								clk => clk,
								write_en => reg4_c,
								inp1 => mrd,
								inp2 => aluresoutr ,
								outp1 => mrdr,
								outp2 =>aluresoutr2					
							);							
	dmaddr <= aluresoutr( 7 downto 0);						
end behavioral;




















