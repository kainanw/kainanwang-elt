clear;
clc;
close all;


Compute_type='Dynamic'; % 1: Modal analysis 2: Superelement
Model_number=10;

Comupte_Samcef=1;
Result_Samcef=1;
Compute_System=1;

if(Comupte_Samcef==1)
    evalc(['!rm *.dat* *.log* *.dia* *.run* *.adb* *.sdb* *.sam *.spy *base* *#* *.asv* *.u18* *.in* *.out* *.res*  *.des* *.fac*']);%% Problem independents for central patch actuation test
end

% Hypothesis
Hypothesis='MINDLIN';

% SAMCEF file
samcef_file_name='ELT';
h_elt=fopen([samcef_file_name,'.dat'],'wt');

% Cross section

BPR(1)=struct('ID',1,'Name','Support_Beam_0_1','Type','CIRCLE0','R1',0.48,'R2',0.46);
BPR(length(BPR)+1)= struct('ID',2,'Name','Support_Beam_1_2','Type','CIRCLE0','R1',0.48,'R2',0.46);
BPR(length(BPR)+1)= struct('ID',3,'Name','Ring','Type','CIRCLE0','R1',0.4,'R2',0.37);
BPR(length(BPR)+1)= struct('ID',4,'Name','MMS_structure_1','Type','CIRCLE0','R1',0.16,'R2',0.14);
BPR(length(BPR)+1)= struct('ID',5,'Name','MMS_structure_2','Type','CIRCLE0','R1',0.15,'R2',0.13);
BPR(length(BPR)+1)= struct('ID',6,'Name','M1_truss','Type','CIRCLE0','R1',0.09,'R2',0.082);
BPR(length(BPR)+1)= struct('ID',7,'Name','M1_truss_middle','Type','CIRCLE0','R1',0.09,'R2',0.082);
BPR(length(BPR)+1)= struct('ID',8,'Name','Sp_structure_1','Type','CIRCLE0','R1',0.3,'R2',0.285);
BPR(length(BPR)+1)= struct('ID',9,'Name','M2_structure','Type','CIRCLE0','R1',0.15,'R2',0.13);
BPR(length(BPR)+1)= struct('ID',10,'Name','Sp_structure_2','Type','CIRCLE0','R1',0.28,'R2',0.255);
BPR(length(BPR)+1)= struct('ID',11,'Name','Tower','Type','CIRCLE0','R1',0.08,'R2',0.06);
BPR(length(BPR)+1)= struct('ID',12,'Name','MMS_structure_3','Type','CIRCLE0','R1',0.25,'R2',0.24);
BPR(length(BPR)+1)= struct('ID',13,'Name','MMS_structure_4','Type','CIRCLE0','R1',0.2,'R2',0.19);

%% Figure property

node_label=0;
element_label=0;

%% Parameters

D_Bin=35;
D_Bout=55;

Theta_B1=8;
Theta_B2=30;
Theta_B3=15;
Theta_B4=40;
Theta_B5=5;

S_L1in=40;
S_L1out=55;
H_L1out=15;

Theta_ear1=15;
Theta_ear2=30;

R_ear=14;
Theta_ear=90;

H_Rad=21;

H_Nas=18;

S_L2in=42;
S_L2out=68;
H_L2out=27;

Nas_Sin=40;
Nas_Sout=75;
Nas_H=30;

Ring_seg=33;
Ring_cover=250;
Ring_L1=3.7;

M1ring_outer=42;
M1_theta1=45;
M1_theta2=80;

% Mass
M1mseg=300;
M2m=12*1e3;
M3m=12*1e3;
M4m=2*1e3;
M5m=500;

% Diameter (for optical amplification)
Dm1=40;
Dm2=4;
Dm3=4;
Dm4=2.5;
Dm5=2.5;

% % M1 suspension system



%% FE

Node_index=1;
Element_index=1;
Point_index=1;
Line_index=1;

% Node define

% Bottom (Level0: Sub1)

Sub1=0;

Node(Node_index)=struct('ID',Sub1+1,'Coord',[D_Bin/2*cos(-Theta_B2*pi/180),D_Bin/2*sin(-Theta_B2*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+2,'Coord',[D_Bin/2*cos(-Theta_B1*pi/180),D_Bin/2*sin(-Theta_B1*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+3,'Coord',[D_Bin/2*cos(Theta_B1*pi/180),D_Bin/2*sin(Theta_B1*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+4,'Coord',[D_Bin/2*cos(Theta_B2*pi/180),D_Bin/2*sin(Theta_B2*pi/180),0],'Group','Fix_Bottom');

Node(length(Node)+1)=struct('ID',Sub1+5,'Coord',[D_Bout/2*cos(-Theta_B4*pi/180),D_Bout/2*sin(-Theta_B4*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+6,'Coord',[D_Bout/2*cos(-Theta_B3*pi/180),D_Bout/2*sin(-Theta_B3*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+7,'Coord',[D_Bout/2*cos(Theta_B3*pi/180),D_Bout/2*sin(Theta_B3*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+8,'Coord',[D_Bout/2*cos(Theta_B4*pi/180),D_Bout/2*sin(Theta_B4*pi/180),0],'Group','Fix_Bottom');

Node(length(Node)+1)=struct('ID',Sub1+9,'Coord',[-D_Bin/2*cos(-Theta_B2*pi/180),D_Bin/2*sin(-Theta_B2*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+10,'Coord',[-D_Bin/2*cos(-Theta_B1*pi/180),D_Bin/2*sin(-Theta_B1*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+11,'Coord',[-D_Bin/2*cos(Theta_B1*pi/180),D_Bin/2*sin(Theta_B1*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+12,'Coord',[-D_Bin/2*cos(Theta_B2*pi/180),D_Bin/2*sin(Theta_B2*pi/180),0],'Group','Fix_Bottom');

Node(length(Node)+1)=struct('ID',Sub1+13,'Coord',[-D_Bout/2*cos(-Theta_B4*pi/180),D_Bout/2*sin(-Theta_B4*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+14,'Coord',[-D_Bout/2*cos(-Theta_B3*pi/180),D_Bout/2*sin(-Theta_B3*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+15,'Coord',[-D_Bout/2*cos(Theta_B3*pi/180),D_Bout/2*sin(Theta_B3*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+16,'Coord',[-D_Bout/2*cos(Theta_B4*pi/180),D_Bout/2*sin(Theta_B4*pi/180),0],'Group','Fix_Bottom');

% 

Node(length(Node)+1)=struct('ID',Sub1+17,'Coord',[S_L1in/2,-R_ear*sin((Theta_ear/2)*pi/180),H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+18,'Coord',[S_L1in/2,-R_ear*sin((Theta_ear2)*pi/180),H_Rad-R_ear*cos((Theta_ear2)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+19,'Coord',[S_L1in/2,-R_ear*sin((Theta_ear1)*pi/180),H_Rad-R_ear*cos((Theta_ear1)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+20,'Coord',[S_L1in/2,0,H_Rad-R_ear],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+21,'Coord',[S_L1in/2,R_ear*sin((Theta_ear1)*pi/180),H_Rad-R_ear*cos((Theta_ear1)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+22,'Coord',[S_L1in/2,R_ear*sin((Theta_ear2)*pi/180),H_Rad-R_ear*cos((Theta_ear2)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+23,'Coord',[S_L1in/2,R_ear*sin((Theta_ear/2)*pi/180),H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group','Ear_Support_Beam');

Node(length(Node)+1)=struct('ID',Sub1+24,'Coord',[S_L1out/2,-H_L1out/2,H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub1+25,'Coord',[S_L1out/2,H_L1out/2,H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group',[]);

Node(length(Node)+1)=struct('ID',Sub1+26,'Coord',[-S_L1in/2,R_ear*sin((Theta_ear/2)*pi/180),H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+27,'Coord',[-S_L1in/2,R_ear*sin((Theta_ear2)*pi/180),H_Rad-R_ear*cos((Theta_ear2)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+28,'Coord',[-S_L1in/2,R_ear*sin((Theta_ear1)*pi/180),H_Rad-R_ear*cos((Theta_ear1)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+29,'Coord',[-S_L1in/2,0,H_Rad-R_ear],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+30,'Coord',[-S_L1in/2,-R_ear*sin((Theta_ear1)*pi/180),H_Rad-R_ear*cos((Theta_ear1)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+31,'Coord',[-S_L1in/2,-R_ear*sin((Theta_ear2)*pi/180),H_Rad-R_ear*cos((Theta_ear2)*pi/180)],'Group','Ear_Support_Beam');
Node(length(Node)+1)=struct('ID',Sub1+32,'Coord',[-S_L1in/2,-R_ear*sin((Theta_ear/2)*pi/180),H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group','Ear_Support_Beam');

Node(length(Node)+1)=struct('ID',Sub1+33,'Coord',[-S_L1out/2,H_L1out/2,H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub1+34,'Coord',[-S_L1out/2,-H_L1out/2,H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group',[]);

Node(length(Node)+1)=struct('ID',Sub1+35,'Coord',[D_Bout/2*cos(-Theta_B5*pi/180),D_Bout/2*sin(-Theta_B5*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+36,'Coord',[D_Bout/2*cos(Theta_B5*pi/180),D_Bout/2*sin(Theta_B5*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+37,'Coord',[-D_Bout/2*cos(-Theta_B5*pi/180),D_Bout/2*sin(-Theta_B5*pi/180),0],'Group','Fix_Bottom');
Node(length(Node)+1)=struct('ID',Sub1+38,'Coord',[-D_Bout/2*cos(Theta_B5*pi/180),D_Bout/2*sin(Theta_B5*pi/180),0],'Group','Fix_Bottom');

% Element define

Element(Element_index)=struct('ID',Sub1+1,'Node',[1,18],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+2,'Node',[2,19],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+3,'Node',[2,20],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+4,'Node',[3,20],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+5,'Node',[3,21],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+6,'Node',[4,22],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+7,'Node',[5,17],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+8,'Node',[5,18],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+9,'Node',[5,24],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+10,'Node',[6,24],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+11,'Node',[8,23],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+12,'Node',[8,22],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+13,'Node',[8,25],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+14,'Node',[7,25],'Group','Support_Beam_0_1');

Element(length(Element)+1)=struct('ID',Sub1+15,'Node',[12,27],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+16,'Node',[11,28],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+17,'Node',[11,29],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+18,'Node',[10,29],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+19,'Node',[10,30],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+20,'Node',[9,31],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+21,'Node',[16,26],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+22,'Node',[16,27],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+23,'Node',[16,33],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+24,'Node',[15,33],'Group','Support_Beam_0_1');

Element(length(Element)+1)=struct('ID',Sub1+25,'Node',[13,32],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+26,'Node',[13,31],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+27,'Node',[13,34],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+28,'Node',[14,34],'Group','Support_Beam_0_1');

Element(length(Element)+1)=struct('ID',Sub1+29,'Node',[6,18],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+30,'Node',[19,35],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+31,'Node',[24,35],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+32,'Node',[7,22],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+33,'Node',[21,36],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+34,'Node',[25,36],'Group','Support_Beam_0_1');

Element(length(Element)+1)=struct('ID',Sub1+35,'Node',[15,27],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+36,'Node',[28,38],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+37,'Node',[33,38],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+38,'Node',[14,31],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+39,'Node',[30,37],'Group','Support_Beam_0_1');
Element(length(Element)+1)=struct('ID',Sub1+40,'Node',[34,37],'Group','Support_Beam_0_1');

% Level1 (Sub2)

Sub2=100;

Node(length(Node)+1)=struct('ID',Sub2+1,'Coord',[S_L1out/2,0,H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+2,'Coord',[S_L2in/2,H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+3,'Coord',[S_L2in/2,H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+4,'Coord',[S_L2in/2,-H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+5,'Coord',[S_L2in/2,-H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+6,'Coord',[(S_L2out+S_L2in)/4,H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+7,'Coord',[(S_L2out+S_L2in)/4,H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+8,'Coord',[(S_L2out+S_L2in)/4,-H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+9,'Coord',[(S_L2out+S_L2in)/4,-H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+10,'Coord',[S_L2out/2,H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+11,'Coord',[S_L2out/2,H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+12,'Coord',[S_L2out/2,-H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+13,'Coord',[S_L2out/2,-H_L2out/2,H_Nas],'Group',[]);

Node(length(Node)+1)=struct('ID',Sub2+14,'Coord',[-S_L1out/2,0,H_Rad-R_ear*cos((Theta_ear/2)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+15,'Coord',[-S_L2in/2,-H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+16,'Coord',[-S_L2in/2,-H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+17,'Coord',[-S_L2in/2,H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+18,'Coord',[-S_L2in/2,H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+19,'Coord',[-(S_L2out+S_L2in)/4,-H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+20,'Coord',[-(S_L2out+S_L2in)/4,-H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+21,'Coord',[-(S_L2out+S_L2in)/4,H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+22,'Coord',[-(S_L2out+S_L2in)/4,H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+23,'Coord',[-S_L2out/2,-H_L2out/2,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+24,'Coord',[-S_L2out/2,-H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+25,'Coord',[-S_L2out/2,H_L2out/6,H_Nas],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub2+26,'Coord',[-S_L2out/2,H_L2out/2,H_Nas],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub2+1,'Node',[23,25],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+2,'Node',[25,21],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+3,'Node',[21,101],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+4,'Node',[101,19],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+5,'Node',[19,24],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+6,'Node',[24,17],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+7,'Node',[25,101],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+8,'Node',[101,24],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+9,'Node',[25,102],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+10,'Node',[25,103],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+11,'Node',[25,106],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+12,'Node',[25,107],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+13,'Node',[25,110],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+14,'Node',[25,111],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+15,'Node',[24,104],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+16,'Node',[24,105],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+17,'Node',[24,108],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+18,'Node',[24,109],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+19,'Node',[24,112],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+20,'Node',[24,113],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+21,'Node',[101,111],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+22,'Node',[101,112],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+23,'Node',[20,103],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+24,'Node',[20,104],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+25,'Node',[102,23],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+26,'Node',[102,22],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+27,'Node',[103,22],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+28,'Node',[105,17],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+29,'Node',[105,18],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+30,'Node',[104,18],'Group','Support_Beam_1_2');

Element(length(Element)+1)=struct('ID',Sub2+31,'Node',[32,34],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+32,'Node',[34,30],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+33,'Node',[30,114],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+34,'Node',[114,28],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+35,'Node',[28,33],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+36,'Node',[33,26],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+37,'Node',[34,114],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+38,'Node',[114,33],'Group','Support_Beam_1_2');

Element(length(Element)+1)=struct('ID',Sub2+39,'Node',[34,115],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+40,'Node',[34,116],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+41,'Node',[34,119],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+42,'Node',[34,120],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+43,'Node',[34,123],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+44,'Node',[34,124],'Group','Support_Beam_1_2');

Element(length(Element)+1)=struct('ID',Sub2+45,'Node',[33,117],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+46,'Node',[33,118],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+47,'Node',[33,121],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+48,'Node',[33,122],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+49,'Node',[33,125],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+50,'Node',[33,126],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+51,'Node',[114,124],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+52,'Node',[114,125],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+53,'Node',[29,116],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+54,'Node',[29,117],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+55,'Node',[115,32],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+56,'Node',[115,31],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+57,'Node',[116,31],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+58,'Node',[118,26],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+59,'Node',[118,27],'Group','Support_Beam_1_2');
Element(length(Element)+1)=struct('ID',Sub2+60,'Node',[117,27],'Group','Support_Beam_1_2');

% Nasmyth platform 

Sub3=1000;

Point(Point_index)=struct('ID',Sub3+1,'Coord',[Nas_Sin/2,-Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+2,'Coord',[Nas_Sout/2,-Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+3,'Coord',[Nas_Sout/2,Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+4,'Coord',[Nas_Sin/2,Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+5,'Coord',[-Nas_Sin/2,-Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+6,'Coord',[-Nas_Sout/2,-Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+7,'Coord',[-Nas_Sout/2,Nas_H/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+8,'Coord',[-Nas_Sin/2,Nas_H/2,H_Nas],'Group',[]);

Point(length(Point)+1)=struct('ID',Sub3+9,'Coord',[S_L2in/2,H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+10,'Coord',[S_L2in/2,H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+11,'Coord',[S_L2in/2,-H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+12,'Coord',[S_L2in/2,-H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+13,'Coord',[(S_L2out+S_L2in)/4,H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+14,'Coord',[(S_L2out+S_L2in)/4,H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+15,'Coord',[(S_L2out+S_L2in)/4,-H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+16,'Coord',[(S_L2out+S_L2in)/4,-H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+17,'Coord',[S_L2out/2,H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+18,'Coord',[S_L2out/2,H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+19,'Coord',[S_L2out/2,-H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+20,'Coord',[S_L2out/2,-H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+21,'Coord',[-S_L2in/2,-H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+22,'Coord',[-S_L2in/2,-H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+23,'Coord',[-S_L2in/2,H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+24,'Coord',[-S_L2in/2,H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+25,'Coord',[-(S_L2out+S_L2in)/4,-H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+26,'Coord',[-(S_L2out+S_L2in)/4,-H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+27,'Coord',[-(S_L2out+S_L2in)/4,H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+28,'Coord',[-(S_L2out+S_L2in)/4,H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+29,'Coord',[-S_L2out/2,-H_L2out/2,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+30,'Coord',[-S_L2out/2,-H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+31,'Coord',[-S_L2out/2,H_L2out/6,H_Nas],'Group',[]);
Point(length(Point)+1)=struct('ID',Sub3+32,'Coord',[-S_L2out/2,H_L2out/2,H_Nas],'Group',[]);

Line(Line_index)=struct('ID',Sub3+1,'Point',[1001,1002],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+2,'Point',[1002,1003],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+3,'Point',[1003,1004],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+4,'Point',[1004,1001],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+5,'Point',[1005,1006],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+6,'Point',[1006,1007],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+7,'Point',[1007,1008],'Group',[]);
Line(length(Line)+1)=struct('ID',Sub3+8,'Point',[1008,1005],'Group',[]);

% Ring

% Left

Sub4=5000;

start_angle=180-(360-(360-Ring_cover)/2);
end_angle=180-(90-(Ring_cover-180)/2);

angle_group=linspace(start_angle,end_angle,Ring_seg);

for ii=1:Ring_seg
    Node(length(Node)+1)=struct('ID',Sub4+ii,'Coord',[-S_L1in/2,R_ear*sin(angle_group(ii)*pi/180),H_Rad-R_ear*cos(angle_group(ii)*pi/180)],'Group',[]);
end

node_label_seq=[[Sub4+1:Sub4+Ring_seg],[32,31,30,29,28,27,26]];
angle_seq=[angle_group,[-(Theta_ear/2),-(Theta_ear2),-(Theta_ear1),0,(Theta_ear1),(Theta_ear2),(Theta_ear/2)]];  

[angle_seq_sort,index]=sort(angle_seq);
node_label_seq=node_label_seq(index);

for ii=1:length(node_label_seq)-1
    Element(length(Element)+1)=struct('ID',Sub4+ii,'Node',[node_label_seq(ii),node_label_seq(ii+1)],'Group','Ring');
end
Ring_seg_fe=length(node_label_seq)-1;

Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+1,'Coord',[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(1)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+2,'Coord',[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180),H_Rad-R_ear*cos(angle_group(3)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+3,'Coord',[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(4)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+4,'Coord',[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180),H_Rad-R_ear*cos(angle_group(5)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+5,'Coord',[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+6,'Coord',[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+7,'Coord',[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1,H_Rad-R_ear*cos(angle_group(33)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+8,'Coord',[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180),H_Rad-R_ear*cos(angle_group(31)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+9,'Coord',[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1,H_Rad-R_ear*cos(angle_group(30)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+10,'Coord',[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180),H_Rad-R_ear*cos(angle_group(29)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+11,'Coord',[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1,H_Rad-R_ear*cos(angle_group(27)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+12,'Coord',[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180),H_Rad-R_ear*cos(angle_group(27)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+13,'Coord',[-S_L1in/2,0,H_Rad-R_ear*cos(angle_group(4)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+14,'Coord',[-S_L1in/2,0,H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);

% Location tuning
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+15,'Coord',[-S_L1in/2,(R_ear*sin(angle_group(1)*pi/180)+Ring_L1),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+16,'Coord',[-S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+17,'Coord',[-S_L1in/2,(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+18,'Coord',[-S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+19,'Coord',[-S_L1in/2,(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+20,'Coord',[-S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
LR_temp=0.4;
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+21,'Coord',[-S_L1in/2,((R_ear*sin(angle_group(1)*pi/180)+Ring_L1)*LR_temp+(R_ear*sin(angle_group(9)*pi/180))*(1-LR_temp)),...
    ((H_Rad-R_ear*cos(angle_group(8)*pi/180))*LR_temp+(H_Rad-R_ear*cos(angle_group(9)*pi/180))*(1-LR_temp))],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+22,'Coord',[-S_L1in/2,((-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1))*LR_temp+(R_ear*sin(angle_group(25)*pi/180))*(1-LR_temp)),...
    ((H_Rad-R_ear*cos(angle_group(8)*pi/180))*LR_temp+(H_Rad-R_ear*cos(angle_group(25)*pi/180))*(1-LR_temp))],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+23,'Coord',[-S_L1in/2,0,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+24,'Coord',[-S_L1in/2,-5,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+25,'Coord',[-S_L1in/2,5,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+26,'Coord',[-S_L1in/2,-8,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+27,'Coord',[-S_L1in/2,8,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
L_temp=2.5;
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+28,'Coord',[-S_L1in/2,(R_ear-L_temp)*sin(angle_group(13)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(13)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+29,'Coord',[-S_L1in/2,(R_ear-L_temp)*sin(angle_group(15)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(15)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+30,'Coord',[-S_L1in/2,(R_ear-L_temp)*sin(angle_group(17)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(17)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+31,'Coord',[-S_L1in/2,(R_ear-L_temp)*sin(angle_group(19)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(19)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub4+Ring_seg+32,'Coord',[-S_L1in/2,(R_ear-L_temp)*sin(angle_group(21)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(21)*pi/180)],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+1,'Node',[1,34]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+2,'Node',[33,40]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+3,'Node',[34,35]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+4,'Node',[40,41]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+5,'Node',[35,36]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+6,'Node',[41,42]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+7,'Node',[34,36]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+8,'Node',[40,42]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+9,'Node',[1,35]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+10,'Node',[33,41]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+11,'Node',[2,35]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+12,'Node',[32,41]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+13,'Node',[3,35]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+14,'Node',[31,41]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+15,'Node',[4,35]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+16,'Node',[30,41]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+17,'Node',[35,37]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+18,'Node',[41,43]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+19,'Node',[36,37]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+20,'Node',[42,43]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+21,'Node',[4,37]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+22,'Node',[30,43]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+23,'Node',[5,37]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+24,'Node',[29,43]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+25,'Node',[6,37]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+26,'Node',[28,43]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+27,'Node',[37,39]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+28,'Node',[43,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+29,'Node',[6,39]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+30,'Node',[28,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+31,'Node',[7,39]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+32,'Node',[27,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+33,'Node',[39,38]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+34,'Node',[38,52]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+35,'Node',[52,47]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+36,'Node',[47,53]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+37,'Node',[53,44]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+38,'Node',[44,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+39,'Node',[36,38]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+40,'Node',[42,44]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+41,'Node',[37,38]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+42,'Node',[43,44]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+43,'Node',[48,50]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+44,'Node',[50,51]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+45,'Node',[51,49]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+46,'Node',[8,54]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+47,'Node',[54,48]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+48,'Node',[26,55]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+49,'Node',[55,49]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+50,'Node',[8,39]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+51,'Node',[26,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+52,'Node',[54,39]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+53,'Node',[55,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+54,'Node',[48,39]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+55,'Node',[49,45]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+56,'Node',[38,48]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+57,'Node',[44,49]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+58,'Node',[38,50]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+59,'Node',[44,51]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+60,'Node',[52,50]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+61,'Node',[53,51]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+62,'Node',[47,50]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+63,'Node',[47,51]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+64,'Node',[46,34]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+65,'Node',[46,36]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+66,'Node',[46,38]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+67,'Node',[46,40]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+68,'Node',[46,42]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+69,'Node',[46,44]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+70,'Node',[10,59]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+71,'Node',[59,57]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+72,'Node',[57,56]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+73,'Node',[56,58]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+74,'Node',[58,60]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+75,'Node',[60,24]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+76,'Node',[54,59]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+77,'Node',[59,61]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+78,'Node',[61,62]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+79,'Node',[62,63]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+80,'Node',[63,64]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+81,'Node',[64,65]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+82,'Node',[65,60]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+83,'Node',[60,55]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+84,'Node',[59,48]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+85,'Node',[60,49]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+86,'Node',[48,57]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+87,'Node',[49,58]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+88,'Node',[57,50]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+89,'Node',[58,51]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+90,'Node',[50,56]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+91,'Node',[51,56]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+92,'Node',[57,61]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+93,'Node',[58,65]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+94,'Node',[57,62]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+95,'Node',[58,64]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+96,'Node',[56,62]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+97,'Node',[56,63]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+98,'Node',[56,64]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+99,'Node',[54,9]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+100,'Node',[54,10]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+101,'Node',[55,25]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+102,'Node',[55,24]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+103,'Node',[59,11]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+104,'Node',[59,12]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+105,'Node',[60,23]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+106,'Node',[60,22]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+107,'Node',[61,12]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+108,'Node',[61,13]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+109,'Node',[61,14]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+110,'Node',[65,22]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+111,'Node',[65,21]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+112,'Node',[65,20]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+113,'Node',[62,14]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+114,'Node',[62,15]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+115,'Node',[62,16]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+116,'Node',[64,20]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+117,'Node',[64,19]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+118,'Node',[64,18]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+119,'Node',[63,16]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+120,'Node',[63,17]+Sub4,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub4+Ring_seg_fe+121,'Node',[63,18]+Sub4,'Group','MMS_structure_1');

% Right

Sub5=7000;

start_angle=180-(360-(360-Ring_cover)/2);
end_angle=180-(90-(Ring_cover-180)/2);

angle_group=linspace(start_angle,end_angle,Ring_seg);

for ii=1:Ring_seg
    Node(length(Node)+1)=struct('ID',Sub5+ii,'Coord',[S_L1in/2,R_ear*sin(angle_group(ii)*pi/180),H_Rad-R_ear*cos(angle_group(ii)*pi/180)],'Group',[]);
end

node_label_seq=[[Sub5+1:Sub5+Ring_seg],[17,18,19,20,21,22,23]];
angle_seq=[angle_group,[-(Theta_ear/2),-(Theta_ear2),-(Theta_ear1),0,(Theta_ear1),(Theta_ear2),(Theta_ear/2)]];  

[angle_seq_sort,index]=sort(angle_seq);
node_label_seq=node_label_seq(index);

for ii=1:length(node_label_seq)-1
    Element(length(Element)+1)=struct('ID',Sub5+ii,'Node',[node_label_seq(ii),node_label_seq(ii+1)],'Group','Ring');
end
Ring_seg_fe=length(node_label_seq)-1;

Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+1,'Coord',[S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(1)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+2,'Coord',[S_L1in/2,R_ear*sin(angle_group(1)*pi/180),H_Rad-R_ear*cos(angle_group(3)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+3,'Coord',[S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(4)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+4,'Coord',[S_L1in/2,R_ear*sin(angle_group(1)*pi/180),H_Rad-R_ear*cos(angle_group(5)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+5,'Coord',[S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+6,'Coord',[S_L1in/2,R_ear*sin(angle_group(1)*pi/180),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+7,'Coord',[S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1,H_Rad-R_ear*cos(angle_group(33)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+8,'Coord',[S_L1in/2,R_ear*sin(angle_group(33)*pi/180),H_Rad-R_ear*cos(angle_group(31)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+9,'Coord',[S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1,H_Rad-R_ear*cos(angle_group(30)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+10,'Coord',[S_L1in/2,R_ear*sin(angle_group(33)*pi/180),H_Rad-R_ear*cos(angle_group(29)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+11,'Coord',[S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1,H_Rad-R_ear*cos(angle_group(27)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+12,'Coord',[S_L1in/2,R_ear*sin(angle_group(33)*pi/180),H_Rad-R_ear*cos(angle_group(27)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+13,'Coord',[S_L1in/2,0,H_Rad-R_ear*cos(angle_group(4)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+14,'Coord',[S_L1in/2,0,H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);

% Location tuning
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+15,'Coord',[S_L1in/2,(R_ear*sin(angle_group(1)*pi/180)+Ring_L1),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+16,'Coord',[S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+17,'Coord',[S_L1in/2,(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+18,'Coord',[S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+19,'Coord',[S_L1in/2,(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+20,'Coord',[S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1+4.5),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
LR_temp=0.4;
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+21,'Coord',[S_L1in/2,((R_ear*sin(angle_group(1)*pi/180)+Ring_L1)*LR_temp+(R_ear*sin(angle_group(9)*pi/180))*(1-LR_temp)),...
    ((H_Rad-R_ear*cos(angle_group(8)*pi/180))*LR_temp+(H_Rad-R_ear*cos(angle_group(9)*pi/180))*(1-LR_temp))],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+22,'Coord',[S_L1in/2,((-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1))*LR_temp+(R_ear*sin(angle_group(25)*pi/180))*(1-LR_temp)),...
    ((H_Rad-R_ear*cos(angle_group(8)*pi/180))*LR_temp+(H_Rad-R_ear*cos(angle_group(25)*pi/180))*(1-LR_temp))],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+23,'Coord',[S_L1in/2,0,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+24,'Coord',[S_L1in/2,-5,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+25,'Coord',[S_L1in/2,5,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+26,'Coord',[S_L1in/2,-8,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+27,'Coord',[S_L1in/2,8,H_Rad-R_ear*cos(angle_group(10)*pi/180)],'Group',[]);
L_temp=2.5;
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+28,'Coord',[S_L1in/2,(R_ear-L_temp)*sin(angle_group(13)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(13)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+29,'Coord',[S_L1in/2,(R_ear-L_temp)*sin(angle_group(15)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(15)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+30,'Coord',[S_L1in/2,(R_ear-L_temp)*sin(angle_group(17)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(17)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+31,'Coord',[S_L1in/2,(R_ear-L_temp)*sin(angle_group(19)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(19)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub5+Ring_seg+32,'Coord',[S_L1in/2,(R_ear-L_temp)*sin(angle_group(21)*pi/180),H_Rad-(R_ear-L_temp)*cos(angle_group(21)*pi/180)],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+1,'Node',[1,34]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+2,'Node',[33,40]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+3,'Node',[34,35]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+4,'Node',[40,41]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+5,'Node',[35,36]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+6,'Node',[41,42]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+7,'Node',[34,36]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+8,'Node',[40,42]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+9,'Node',[1,35]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+10,'Node',[33,41]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+11,'Node',[2,35]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+12,'Node',[32,41]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+13,'Node',[3,35]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+14,'Node',[31,41]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+15,'Node',[4,35]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+16,'Node',[30,41]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+17,'Node',[35,37]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+18,'Node',[41,43]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+19,'Node',[36,37]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+20,'Node',[42,43]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+21,'Node',[4,37]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+22,'Node',[30,43]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+23,'Node',[5,37]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+24,'Node',[29,43]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+25,'Node',[6,37]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+26,'Node',[28,43]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+27,'Node',[37,39]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+28,'Node',[43,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+29,'Node',[6,39]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+30,'Node',[28,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+31,'Node',[7,39]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+32,'Node',[27,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+33,'Node',[39,38]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+34,'Node',[38,52]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+35,'Node',[52,47]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+36,'Node',[47,53]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+37,'Node',[53,44]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+38,'Node',[44,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+39,'Node',[36,38]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+40,'Node',[42,44]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+41,'Node',[37,38]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+42,'Node',[43,44]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+43,'Node',[48,50]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+44,'Node',[50,51]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+45,'Node',[51,49]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+46,'Node',[8,54]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+47,'Node',[54,48]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+48,'Node',[26,55]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+49,'Node',[55,49]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+50,'Node',[8,39]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+51,'Node',[26,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+52,'Node',[54,39]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+53,'Node',[55,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+54,'Node',[48,39]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+55,'Node',[49,45]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+56,'Node',[38,48]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+57,'Node',[44,49]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+58,'Node',[38,50]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+59,'Node',[44,51]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+60,'Node',[52,50]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+61,'Node',[53,51]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+62,'Node',[47,50]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+63,'Node',[47,51]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+64,'Node',[46,34]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+65,'Node',[46,36]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+66,'Node',[46,38]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+67,'Node',[46,40]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+68,'Node',[46,42]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+69,'Node',[46,44]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+70,'Node',[10,59]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+71,'Node',[59,57]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+72,'Node',[57,56]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+73,'Node',[56,58]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+74,'Node',[58,60]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+75,'Node',[60,24]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+76,'Node',[54,59]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+77,'Node',[59,61]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+78,'Node',[61,62]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+79,'Node',[62,63]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+80,'Node',[63,64]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+81,'Node',[64,65]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+82,'Node',[65,60]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+83,'Node',[60,55]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+84,'Node',[59,48]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+85,'Node',[60,49]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+86,'Node',[48,57]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+87,'Node',[49,58]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+88,'Node',[57,50]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+89,'Node',[58,51]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+90,'Node',[50,56]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+91,'Node',[51,56]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+92,'Node',[57,61]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+93,'Node',[58,65]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+94,'Node',[57,62]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+95,'Node',[58,64]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+96,'Node',[56,62]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+97,'Node',[56,63]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+98,'Node',[56,64]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+99,'Node',[54,9]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+100,'Node',[54,10]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+101,'Node',[55,25]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+102,'Node',[55,24]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+103,'Node',[59,11]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+104,'Node',[59,12]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+105,'Node',[60,23]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+106,'Node',[60,22]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+107,'Node',[61,12]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+108,'Node',[61,13]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+109,'Node',[61,14]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+110,'Node',[65,22]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+111,'Node',[65,21]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+112,'Node',[65,20]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+113,'Node',[62,14]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+114,'Node',[62,15]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+115,'Node',[62,16]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+116,'Node',[64,20]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+117,'Node',[64,19]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+118,'Node',[64,18]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+119,'Node',[63,16]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+120,'Node',[63,17]+Sub5,'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub5+Ring_seg_fe+121,'Node',[63,18]+Sub5,'Group','MMS_structure_1');

% M1 Ring

Sub6=10000;
Sub6_diff=1000;

M1ring_p1=M1ring_outer/2*[cos(pi/180*(-M1_theta1)),sin(pi/180*(-M1_theta1))];
M1ring_p2=M1ring_outer/2*[cos(pi/180*(-M1_theta2)),sin(pi/180*(-M1_theta2))];
M1ring_p3=M1ring_outer/2*[cos(pi/180*(180+M1_theta2)),sin(pi/180*(180+M1_theta2))];
M1ring_p4=M1ring_outer/2*[cos(pi/180*(180+M1_theta1)),sin(pi/180*(180+M1_theta1))];
M1ring_p5=M1ring_outer/2*[cos(pi/180*(180-M1_theta1)),sin(pi/180*(180-M1_theta1))];
M1ring_p6=M1ring_outer/2*[cos(pi/180*(180-M1_theta2)),sin(pi/180*(180-M1_theta2))];
M1ring_p7=M1ring_outer/2*[cos(pi/180*(M1_theta2)),sin(pi/180*(M1_theta2))];
M1ring_p8=M1ring_outer/2*[cos(pi/180*(M1_theta1)),sin(pi/180*(M1_theta1))];
M1ring_pA=[S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1];
M1ring_pB=[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1];
M1ring_pC=[-S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1)];
M1ring_pD=[S_L1in/2,-(R_ear*sin(angle_group(1)*pi/180)+Ring_L1)];

% S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1,H_Rad-R_ear*cos(angle_group(7)*pi/180)

M1ring_p9=M1ring_p1*1/2+M1ring_pA*1/2;
M1ring_p10=M1ring_p1*2/3+M1ring_p2*1/3;
M1ring_p11=M1ring_p1*1/3+M1ring_p2*2/3;
M1ring_p12=M1ring_p2*1/2+M1ring_p3*1/2;
M1ring_p13=M1ring_p3*2/3+M1ring_p4*1/3;
M1ring_p14=M1ring_p3*1/3+M1ring_p4*2/3;
M1ring_p15=M1ring_p4*1/2+M1ring_pB*1/2;

M1ring_p16=M1ring_p5*1/2+M1ring_pC*1/2;
M1ring_p17=M1ring_p5*2/3+M1ring_p6*1/3;
M1ring_p18=M1ring_p5*1/3+M1ring_p6*2/3;
M1ring_p19=M1ring_p6*1/2+M1ring_p7*1/2;
M1ring_p20=M1ring_p7*2/3+M1ring_p8*1/3;
M1ring_p21=M1ring_p7*1/3+M1ring_p8*2/3;
M1ring_p22=M1ring_p8*1/2+M1ring_pD*1/2;

Node(length(Node)+1)=struct('ID',Sub6+1,'Coord',[M1ring_p1(1),M1ring_p1(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+2,'Coord',[M1ring_p2(1),M1ring_p2(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+3,'Coord',[M1ring_p3(1),M1ring_p3(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+4,'Coord',[M1ring_p4(1),M1ring_p4(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+5,'Coord',[M1ring_p5(1),M1ring_p5(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+6,'Coord',[M1ring_p6(1),M1ring_p6(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+7,'Coord',[M1ring_p7(1),M1ring_p7(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+8,'Coord',[M1ring_p8(1),M1ring_p8(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+9,'Coord',[M1ring_p9(1),M1ring_p9(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+10,'Coord',[M1ring_p10(1),M1ring_p10(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+11,'Coord',[M1ring_p11(1),M1ring_p11(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+12,'Coord',[M1ring_p12(1),M1ring_p12(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+13,'Coord',[M1ring_p13(1),M1ring_p13(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+14,'Coord',[M1ring_p14(1),M1ring_p14(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+15,'Coord',[M1ring_p15(1),M1ring_p15(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+16,'Coord',[M1ring_p16(1),M1ring_p16(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+17,'Coord',[M1ring_p17(1),M1ring_p17(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+18,'Coord',[M1ring_p18(1),M1ring_p18(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+19,'Coord',[M1ring_p19(1),M1ring_p19(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+20,'Coord',[M1ring_p20(1),M1ring_p20(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+21,'Coord',[M1ring_p21(1),M1ring_p21(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+22,'Coord',[M1ring_p22(1),M1ring_p22(2),H_Rad-R_ear*cos(angle_group(7)*pi/180)],'Group',[]);

Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+1,'Coord',[M1ring_p1(1),M1ring_p1(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+2,'Coord',[M1ring_p2(1),M1ring_p2(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+3,'Coord',[M1ring_p3(1),M1ring_p3(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+4,'Coord',[M1ring_p4(1),M1ring_p4(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+5,'Coord',[M1ring_p5(1),M1ring_p5(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+6,'Coord',[M1ring_p6(1),M1ring_p6(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+7,'Coord',[M1ring_p7(1),M1ring_p7(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+8,'Coord',[M1ring_p8(1),M1ring_p8(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+9,'Coord',[M1ring_p9(1),M1ring_p9(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+10,'Coord',[M1ring_p10(1),M1ring_p10(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+11,'Coord',[M1ring_p11(1),M1ring_p11(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+12,'Coord',[M1ring_p12(1),M1ring_p12(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+13,'Coord',[M1ring_p13(1),M1ring_p13(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+14,'Coord',[M1ring_p14(1),M1ring_p14(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+15,'Coord',[M1ring_p15(1),M1ring_p15(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+16,'Coord',[M1ring_p16(1),M1ring_p16(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+17,'Coord',[M1ring_p17(1),M1ring_p17(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+18,'Coord',[M1ring_p18(1),M1ring_p18(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+19,'Coord',[M1ring_p19(1),M1ring_p19(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+20,'Coord',[M1ring_p20(1),M1ring_p20(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+21,'Coord',[M1ring_p21(1),M1ring_p21(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub6+Sub6_diff+22,'Coord',[M1ring_p22(1),M1ring_p22(2),H_Rad-R_ear*cos(angle_group(8)*pi/180)],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub6+1,'Node',[7038,10009],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+2,'Node',[10009,10001],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+3,'Node',[10001,10010],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+4,'Node',[10010,10011],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+5,'Node',[10011,10002],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+6,'Node',[10002,10012],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+7,'Node',[10012,10003],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+8,'Node',[10003,10013],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+9,'Node',[10013,10014],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+10,'Node',[10014,10004],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+11,'Node',[10004,10015],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+12,'Node',[10015,5038],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+13,'Node',[5044,10016],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+14,'Node',[10016,10005],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+15,'Node',[10005,10017],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+16,'Node',[10017,10018],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+17,'Node',[10018,10006],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+18,'Node',[10006,10019],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+19,'Node',[10019,10007],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+20,'Node',[10007,10020],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+21,'Node',[10020,10021],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+22,'Node',[10021,10008],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+23,'Node',[10008,10022],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+24,'Node',[10022,7044],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+1+24,'Node',[7048,11009],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+2+24,'Node',[11009,11001],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+3+24,'Node',[11001,11010],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+4+24,'Node',[11010,11011],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+5+24,'Node',[11011,11002],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+6+24,'Node',[11002,11012],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+7+24,'Node',[11012,11003],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+8+24,'Node',[11003,11013],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+9+24,'Node',[11013,11014],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+10+24,'Node',[11014,11004],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+11+24,'Node',[11004,11015],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+12+24,'Node',[11015,5048],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+13+24,'Node',[5049,11016],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+14+24,'Node',[11016,11005],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+15+24,'Node',[11005,11017],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+16+24,'Node',[11017,11018],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+17+24,'Node',[11018,11006],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+18+24,'Node',[11006,11019],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+19+24,'Node',[11019,11007],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+20+24,'Node',[11007,11020],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+21+24,'Node',[11020,11021],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+22+24,'Node',[11021,11008],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+23+24,'Node',[11008,11022],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+24+24,'Node',[11022,7049],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+49,'Node',[10001,11001],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+50,'Node',[10002,11002],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+51,'Node',[10003,11003],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+52,'Node',[10004,11004],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+53,'Node',[10005,11005],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+54,'Node',[10006,11006],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+55,'Node',[10007,11007],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+56,'Node',[10008,11008],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+57,'Node',[10009,11009],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+58,'Node',[10010,11010],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+59,'Node',[10011,11011],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+60,'Node',[10012,11012],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+61,'Node',[10013,11013],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+62,'Node',[10014,11014],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+63,'Node',[10015,11015],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+64,'Node',[10016,11016],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+65,'Node',[10017,11017],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+66,'Node',[10018,11018],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+67,'Node',[10019,11019],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+68,'Node',[10020,11020],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+69,'Node',[10021,11021],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+70,'Node',[10022,11022],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+71,'Node',[10009,7048],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+72,'Node',[10009,11001],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+73,'Node',[10012,11002],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+74,'Node',[10012,11003],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+75,'Node',[10015,5048],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+76,'Node',[10015,11004],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+77,'Node',[10016,5049],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+78,'Node',[10016,11005],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+79,'Node',[10019,11006],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+80,'Node',[10019,11007],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+81,'Node',[10022,7049],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+82,'Node',[10022,11008],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+83,'Node',[10002,11011],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+84,'Node',[11011,10010],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+85,'Node',[10010,11001],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+86,'Node',[10001,11010],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+87,'Node',[11010,10011],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+88,'Node',[10011,11002],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+89,'Node',[10003,11013],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+90,'Node',[11013,10014],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+91,'Node',[10014,11004],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+92,'Node',[10004,11014],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+93,'Node',[11014,10013],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+94,'Node',[10013,11003],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+95,'Node',[10005,11017],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+96,'Node',[11017,10018],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+97,'Node',[10018,11006],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+98,'Node',[10006,11018],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+99,'Node',[11018,10017],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+100,'Node',[10017,11005],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+101,'Node',[10007,11020],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+102,'Node',[11020,10021],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+103,'Node',[10021,11008],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+104,'Node',[10008,11021],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+105,'Node',[11021,10020],'Group','MMS_structure_2');
Element(length(Element)+1)=struct('ID',Sub6+106,'Node',[10020,11007],'Group','MMS_structure_2');

% M1

% Upper

Sub7=50000;

Geo_Parameter_M1.Nb_R=20;
Geo_Parameter_M1.Outer_diameter=45;
Geo_Parameter_M1.Inner_diameter=10;
Geo_Parameter_M1.Extend=1.2;
[mi_hex_M1,Dim_M1]=Hexagonal(Geo_Parameter_M1);

F_number_M1=3;
Outer_diameter=Geo_Parameter_M1.Outer_diameter;

Mirror_seg_num=0;
Node_counter=0;
for ii=1:length(mi_hex_M1)
    if((mi_hex_M1(ii).ra>=Dim_M1.Ra_inner)&&(mi_hex_M1(ii).radius<S_L1in/2*1.005))
        Node_counter=Node_counter+1;
        coordx=mi_hex_M1(ii).center_y; % inversion
        coordy=mi_hex_M1(ii).center_x;
%         radius_curve=sqrt(coordx^2+coordy^2);
%         coordz=1/4/(F_number_M1*Outer_diameter)*radius_curve^2+H_Nas;
        coordz=H_Rad-R_ear*cos(angle_group(7)*pi/180);
        if(mi_hex_M1(ii).location==1)
            Node(length(Node)+1)=struct('ID',Sub7+Node_counter,'Coord',[coordx,coordy,coordz],'Group','Node_mirror_seg');
            Mirror_seg_num=Mirror_seg_num+1;
        else
            Node(length(Node)+1)=struct('ID',Sub7+Node_counter,'Coord',[coordx,coordy,coordz],'Group',[]);
        end
    end
end

Group_up_connect_1=[[38,52,47,53,44]+Sub4,[38,52,47,53,44]+Sub5];
Group_up_connect_2=[1:22]+Sub6;
Group_up_connect_3=[1:Node_counter]+Sub7;
Node_group_upper=[Group_up_connect_1,Group_up_connect_2,Group_up_connect_3];

Node_index_1=[];
for ii=1:length(Node)
    if(ismember(Node(ii).ID,Node_group_upper))
       Node_index_1=[Node_index_1,ii];
    end
end

Topo_table=zeros(length(Node_index_1),length(Node_index_1));
Element_counter=0;
for ii=1:length(Node_index_1)
    for jj=1:length(Node_index_1)
        dist=sqrt((Node(Node_index_1(ii)).Coord(1)-Node(Node_index_1(jj)).Coord(1))^2+(Node(Node_index_1(ii)).Coord(2)-Node(Node_index_1(jj)).Coord(2))^2);
        if(dist<Dim_M1.D_Hex_ic_micro*2*1.5)
            if(dist>Dim_M1.D_Hex_ic_micro*0.2)
                min_v=min(ii,jj);
                max_v=max(ii,jj);
                if(Topo_table(min_v,max_v)==0)
                    Element_counter=Element_counter+1;
                    Topo_table(min_v,max_v)=1;
                    index_1=Node_index_1(min_v);
                    index_2=Node_index_1(max_v);
                    Element(length(Element)+1)=struct('ID',Sub7+Element_counter,'Node',[Node(index_1).ID,Node(index_2).ID],'Group','M1_truss');
                end
            end
        end
    end
end

figure;
hold on;
ii_index=0;
for ii=1:length(mi_hex_M1)
    if((mi_hex_M1(ii).ra>=Dim_M1.Ra_inner)&&(mi_hex_M1(ii).radius<S_L1in/2*1.005))
        if(mi_hex_M1(ii).location==1)
            plot(mi_hex_M1(ii).center_x,mi_hex_M1(ii).center_y,'r.','MarkerSize',2);
            line_x=[mi_hex_M1(ii).point_x';mi_hex_M1(ii).point_x(1)];
            line_y=[mi_hex_M1(ii).point_y';mi_hex_M1(ii).point_y(1)];
            plot(line_x,line_y,'k');
            ii_index=ii_index+1;
        end
    end 
end
axis square;
box on;
xlim([-25,25]);
ylim([-25,25]);

% connection

Element(length(Element)+1)=struct('ID',Sub7+Element_counter+1,'Node',[50685,10005],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+2,'Node',[50684,10016],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+3,'Node',[50682,10016],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+4,'Node',[50682,5044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+5,'Node',[50681,5044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+6,'Node',[50680,5044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+7,'Node',[50741,5053],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+8,'Node',[50738,5053],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+9,'Node',[50736,5052],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+10,'Node',[50733,5038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+11,'Node',[50671,5038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+12,'Node',[50670,5038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+13,'Node',[50669,5038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+14,'Node',[50669,10015],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+15,'Node',[50667,10015],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+16,'Node',[50667,10004],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+17,'Node',[50741,5044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+18,'Node',[50684,10005],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+19,'Node',[50733,5052],'Group','M1_truss');

Element(length(Element)+1)=struct('ID',Sub7+Element_counter+20,'Node',[50624,10008],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+21,'Node',[50625,10008],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+22,'Node',[50625,10022],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+23,'Node',[50627,10022],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+24,'Node',[50627,7044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+25,'Node',[50628,7044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+26,'Node',[50629,7044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+27,'Node',[50706,7053],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+28,'Node',[50709,7053],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+29,'Node',[50711,7052],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+30,'Node',[50714,7052],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+31,'Node',[50714,7038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+32,'Node',[50638,7038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+33,'Node',[50639,7038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+34,'Node',[50640,7038],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+35,'Node',[50640,10009],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+36,'Node',[50642,10009],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+37,'Node',[50642,10001],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+38,'Node',[50706,7044],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+39,'Node',[50696,10006],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+40,'Node',[50613,10007],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+41,'Node',[50655,10003],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub7+Element_counter+42,'Node',[50654,10002],'Group','M1_truss');

% Down

Sub8=70000;

% Mirror_seg_num=0;
Node_counter=0;
for ii=1:length(mi_hex_M1)
    if((mi_hex_M1(ii).ra>=Dim_M1.Ra_inner)&&(mi_hex_M1(ii).radius<S_L1in/2*1.005))
        Node_counter=Node_counter+1;
        coordx=mi_hex_M1(ii).center_y; % inversion
        coordy=mi_hex_M1(ii).center_x;
%         radius_curve=sqrt(coordx^2+coordy^2);
%         coordz=1/4/(F_number_M1*Outer_diameter)*radius_curve^2+H_Nas;
        coordz=H_Rad-R_ear*cos(angle_group(7)*pi/180)-2.3;
        Node(length(Node)+1)=struct('ID',Sub8+Node_counter,'Coord',[coordx,coordy,coordz],'Group',[]);
    end
end

Group_do_connect_1=[[48,50,51,49]+Sub4,[48,50,51,49]+Sub5];
Group_do_connect_2=[1:22]+Sub6+Sub6_diff;
Group_do_connect_3=[1:Node_counter]+Sub8;
Node_group_down=[Group_do_connect_1,Group_do_connect_2,Group_do_connect_3];

Node_index_1=[];
for ii=1:length(Node)
    if(ismember(Node(ii).ID,Node_group_down))
       Node_index_1=[Node_index_1,ii];
    end
end

Topo_table=zeros(length(Node_index_1),length(Node_index_1));
Element_counter=0;
for ii=1:length(Node_index_1)
    for jj=1:length(Node_index_1)
        dist=sqrt((Node(Node_index_1(ii)).Coord(1)-Node(Node_index_1(jj)).Coord(1))^2+(Node(Node_index_1(ii)).Coord(2)-Node(Node_index_1(jj)).Coord(2))^2);
        if(dist<Dim_M1.D_Hex_ic_micro*2*1.5)
            if(dist>Dim_M1.D_Hex_ic_micro*0.2)
                min_v=min(ii,jj);
                max_v=max(ii,jj);
                if(Topo_table(min_v,max_v)==0)
                    Element_counter=Element_counter+1;
                    Topo_table(min_v,max_v)=1;
                    index_1=Node_index_1(min_v);
                    index_2=Node_index_1(max_v);
                    Element(length(Element)+1)=struct('ID',Sub8+Element_counter,'Node',[Node(index_1).ID,Node(index_2).ID],'Group','M1_truss');
                end
            end
        end
    end
end

% connection

Element(length(Element)+1)=struct('ID',Sub8+Element_counter+1,'Node',[70685,11005],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+2,'Node',[70684,11016],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+3,'Node',[70682,11016],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+4,'Node',[70682,5049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+5,'Node',[70681,5049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+6,'Node',[70680,5049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+7,'Node',[70741,5051],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+8,'Node',[70738,5051],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+9,'Node',[70736,5050],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+10,'Node',[70733,5048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+11,'Node',[70671,5048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+12,'Node',[70670,5048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+13,'Node',[70669,5048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+14,'Node',[70669,11015],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+15,'Node',[70667,11015],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+16,'Node',[70667,11004],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+17,'Node',[70741,5049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+18,'Node',[70684,11005],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+19,'Node',[70733,5050],'Group','M1_truss');

Element(length(Element)+1)=struct('ID',Sub8+Element_counter+20,'Node',[70624,11008],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+21,'Node',[70625,11008],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+22,'Node',[70625,11022],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+23,'Node',[70627,11022],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+24,'Node',[70627,7049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+25,'Node',[70628,7049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+26,'Node',[70629,7049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+27,'Node',[70706,7051],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+28,'Node',[70709,7051],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+29,'Node',[70711,7050],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+30,'Node',[70714,7050],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+31,'Node',[70714,7048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+32,'Node',[70638,7048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+33,'Node',[70639,7048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+34,'Node',[70640,7048],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+35,'Node',[70640,11009],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+36,'Node',[70642,11009],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+37,'Node',[70642,11001],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+38,'Node',[70706,7049],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+39,'Node',[70696,11006],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+40,'Node',[70613,11007],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+41,'Node',[70655,11003],'Group','M1_truss');
Element(length(Element)+1)=struct('ID',Sub8+Element_counter+42,'Node',[70654,11002],'Group','M1_truss');

% Middle

Sub9=90000;

Node_index_up=[];
Node_index_do=[];
for ii=1:length(Node)
    if(ismember(Node(ii).ID,Group_up_connect_3))
       Node_index_up=[Node_index_up,ii];   
    elseif(ismember(Node(ii).ID,Group_do_connect_3))
       Node_index_do=[Node_index_do,ii];   
    end
end

Topo_table=zeros(length(Node_index_up),length(Node_index_do));
Element_counter=0;
for ii=1:length(Node_index_up)
    for jj=1:length(Node_index_do)
        dist=sqrt((Node(Node_index_up(ii)).Coord(1)-Node(Node_index_do(jj)).Coord(1))^2+...
            (Node(Node_index_up(ii)).Coord(2)-Node(Node_index_do(jj)).Coord(2))^2+...
            (Node(Node_index_up(ii)).Coord(3)-Node(Node_index_do(jj)).Coord(3))^2);
        dis_cr=sqrt((Dim_M1.D_Hex_ic_micro*2)^2+(2.3^2));
        if(dist<dis_cr*1.05)
            if(dist>dis_cr*0.02)
                min_v=min(ii,jj);
                max_v=max(ii,jj);
                if(Topo_table(min_v,max_v)==0)
                    Element_counter=Element_counter+1;
                    Topo_table(min_v,max_v)=1;
                    index_1=Node_index_up(ii);
                    index_2=Node_index_do(jj);
                    Element(length(Element)+1)=struct('ID',Sub9+Element_counter,'Node',[Node(index_1).ID,Node(index_2).ID],'Group','M1_truss_middle');
                end
             end
        end
    end
end

% Spider

Sub10=100000;
Sub10_diff1=10000;

H1=H_Rad-R_ear*cos(angle_group(1)*pi/180);
H2=20+R_ear*cos(angle_group(1)*pi/180)-R_ear*cos(angle_group(7)*pi/180)+H1;
H3=H2+10;

Node(length(Node)+1)=struct('ID',Sub10+1,'Coord',[M1ring_p2,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+2,'Coord',[M1ring_p3,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+3,'Coord',[M1ring_p6,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+4,'Coord',[M1ring_p7,H1],'Group',[]);

Node(length(Node)+1)=struct('ID',Sub10+5,'Coord',[M1ring_p4,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+6,'Coord',[M1ring_p5,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+7,'Coord',[M1ring_p8,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+8,'Coord',[M1ring_p1,H1],'Group',[]);

Node(length(Node)+1)=struct('ID',Sub10+9,'Coord',[(M1ring_p4+[-S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1])/2,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+10,'Coord',[(M1ring_p5+[-S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1])/2,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+11,'Coord',[(M1ring_p1+[S_L1in/2,R_ear*sin(angle_group(1)*pi/180)+Ring_L1])/2,H1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+12,'Coord',[(M1ring_p8+[S_L1in/2,R_ear*sin(angle_group(33)*pi/180)-Ring_L1])/2,H1],'Group',[]);

% 5034 100005
% 5040 100006
% 7034 100008
% 7040 100007

Element(length(Element)+1)=struct('ID',Sub10+1,'Node',[10002,100001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+2,'Node',[10003,100002],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+3,'Node',[10006,100003],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+4,'Node',[10007,100004],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+5,'Node',[10002,100002],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+6,'Node',[10003,100001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+7,'Node',[10006,100004],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+8,'Node',[10007,100003],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+9,'Node',[5001,100009],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+10,'Node',[5033,100010],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+11,'Node',[7001,100011],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+12,'Node',[7033,100012],'Group','Sp_structure_1');

Element(length(Element)+1)=struct('ID',Sub10+13,'Node',[5001,100005],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+14,'Node',[5033,100006],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+15,'Node',[7001,100008],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+16,'Node',[7033,100007],'Group','Sp_structure_1');

Element(length(Element)+1)=struct('ID',Sub10+17,'Node',[110015,100005],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+18,'Node',[110015,100002],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+19,'Node',[110014,100002],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+20,'Node',[110014,100001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+21,'Node',[110013,100001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+22,'Node',[110013,100008],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+23,'Node',[110021,100007],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+24,'Node',[110021,100004],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+25,'Node',[110020,100004],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+26,'Node',[110020,100003],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+27,'Node',[110019,100003],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+28,'Node',[110019,100006],'Group','Sp_structure_1');

Element(length(Element)+1)=struct('ID',Sub10+29,'Node',[110016,100005],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+30,'Node',[110016,5001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+31,'Node',[110016,5034],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+32,'Node',[110018,100006],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+33,'Node',[110018,5040],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+34,'Node',[110018,5033],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+35,'Node',[110024,100008],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+36,'Node',[110024,7001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+37,'Node',[110024,7034],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+38,'Node',[110022,100007],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+39,'Node',[110022,7040],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+40,'Node',[110022,7033],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+41,'Node',[110017,5040],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+42,'Node',[110017,5034],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+43,'Node',[110023,7040],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+44,'Node',[110023,7034],'Group','Sp_structure_1');

Element(length(Element)+1)=struct('ID',Sub10+45,'Node',[100005,10003],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+46,'Node',[100002,10004],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+47,'Node',[100008,10002],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+48,'Node',[100001,10001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+49,'Node',[100006,10006],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+50,'Node',[100003,10005],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+51,'Node',[100007,10007],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+52,'Node',[100004,10008],'Group','Sp_structure_1');

Element(length(Element)+1)=struct('ID',Sub10+53,'Node',[100009,100005],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+54,'Node',[100009,5034],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+55,'Node',[100010,100006],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+56,'Node',[100010,5040],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+57,'Node',[100011,100008],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+58,'Node',[100011,7034],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+59,'Node',[100012,100007],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+60,'Node',[100012,7040],'Group','Sp_structure_1');

Element(length(Element)+1)=struct('ID',Sub10+61,'Node',[100009,10004],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+62,'Node',[100009,5038],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+63,'Node',[100010,10005],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+64,'Node',[100010,5044],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+65,'Node',[100011,10001],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+66,'Node',[100011,7038],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+67,'Node',[100012,10008],'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+68,'Node',[100012,7044],'Group','Sp_structure_1');

Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+1,'Coord',[M1ring_p1,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+2,'Coord',[M1ring_p2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+3,'Coord',[M1ring_p3,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+4,'Coord',[M1ring_p4,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+5,'Coord',[M1ring_p5,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+6,'Coord',[M1ring_p6,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+7,'Coord',[M1ring_p7,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+8,'Coord',[M1ring_p8,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+9,'Coord',[M1ring_pD,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+10,'Coord',[M1ring_pA,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+11,'Coord',[M1ring_pB,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+12,'Coord',[M1ring_pC,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+13,'Coord',[(M1ring_p1+M1ring_p2)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+14,'Coord',[(M1ring_p2+M1ring_p3)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+15,'Coord',[(M1ring_p3+M1ring_p4)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+16,'Coord',[(M1ring_p4+M1ring_pB)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+17,'Coord',[(M1ring_pB+M1ring_pC)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+18,'Coord',[(M1ring_pC+M1ring_p5)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+19,'Coord',[(M1ring_p5+M1ring_p6)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+20,'Coord',[(M1ring_p6+M1ring_p7)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+21,'Coord',[(M1ring_p7+M1ring_p8)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+22,'Coord',[(M1ring_p8+M1ring_pD)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+23,'Coord',[(M1ring_pD+M1ring_pA)/2,H2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub10+Sub10_diff1+24,'Coord',[(M1ring_pA+M1ring_p1)/2,H2],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+1,'Node',[1,13]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+2,'Node',[13,2]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+3,'Node',[2,14]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+4,'Node',[14,3]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+5,'Node',[3,15]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+6,'Node',[15,4]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+7,'Node',[4,16]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+8,'Node',[16,11]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+9,'Node',[11,17]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+10,'Node',[17,12]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+11,'Node',[12,18]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+12,'Node',[18,5]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+13,'Node',[5,19]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+14,'Node',[19,6]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+15,'Node',[6,20]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+16,'Node',[20,7]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+17,'Node',[7,21]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+18,'Node',[21,8]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+19,'Node',[8,22]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+20,'Node',[22,9]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+21,'Node',[9,23]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+22,'Node',[23,10]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+23,'Node',[10,24]+Sub10+Sub10_diff1,'Group','Sp_structure_1');
Element(length(Element)+1)=struct('ID',Sub10+Sub10_diff1+24,'Node',[24,1]+Sub10+Sub10_diff1,'Group','Sp_structure_1');

% M2

M2S_r=5;
M2S_t=4;

Sub11=200000;

Node(length(Node)+1)=struct('ID',Sub11+1,'Coord',[M2S_r*cos((30)*pi/180),M2S_r*sin((30)*pi/180),H3],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+2,'Coord',[M2S_r*cos((30+60)*pi/180),M2S_r*sin((30+60)*pi/180),H3],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+3,'Coord',[M2S_r*cos((30+120)*pi/180),M2S_r*sin((30+120)*pi/180),H3],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+4,'Coord',[M2S_r*cos((30+180)*pi/180),M2S_r*sin((30+180)*pi/180),H3],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+5,'Coord',[M2S_r*cos((30+240)*pi/180),M2S_r*sin((30+240)*pi/180),H3],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+6,'Coord',[M2S_r*cos((30+300)*pi/180),M2S_r*sin((30+300)*pi/180),H3],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+7,'Coord',[M2S_r*cos((30)*pi/180),M2S_r*sin((30)*pi/180),H3-M2S_t],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+8,'Coord',[M2S_r*cos((30+60)*pi/180),M2S_r*sin((30+60)*pi/180),H3-M2S_t],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+9,'Coord',[M2S_r*cos((30+120)*pi/180),M2S_r*sin((30+120)*pi/180),H3-M2S_t],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+10,'Coord',[M2S_r*cos((30+180)*pi/180),M2S_r*sin((30+180)*pi/180),H3-M2S_t],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+11,'Coord',[M2S_r*cos((30+240)*pi/180),M2S_r*sin((30+240)*pi/180),H3-M2S_t],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub11+12,'Coord',[M2S_r*cos((30+300)*pi/180),M2S_r*sin((30+300)*pi/180),H3-M2S_t],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub11+1,'Node',[1,2]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+2,'Node',[2,3]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+3,'Node',[3,4]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+4,'Node',[4,5]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+5,'Node',[5,6]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+6,'Node',[6,1]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+7,'Node',[7,8]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+8,'Node',[8,9]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+9,'Node',[9,10]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+10,'Node',[10,11]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+11,'Node',[11,12]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+12,'Node',[12,7]+Sub11,'Group','M2_structure');

Element(length(Element)+1)=struct('ID',Sub11+13,'Node',[1,7]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+14,'Node',[2,8]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+15,'Node',[3,9]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+16,'Node',[4,10]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+17,'Node',[5,11]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+18,'Node',[6,12]+Sub11,'Group','M2_structure');

Element(length(Element)+1)=struct('ID',Sub11+19,'Node',[1,8]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+20,'Node',[2,9]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+21,'Node',[3,10]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+22,'Node',[4,11]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+23,'Node',[5,12]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+24,'Node',[6,7]+Sub11,'Group','M2_structure');

Element(length(Element)+1)=struct('ID',Sub11+25,'Node',[1,12]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+26,'Node',[2,7]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+27,'Node',[3,8]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+28,'Node',[4,9]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+29,'Node',[5,10]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+30,'Node',[6,11]+Sub11,'Group','M2_structure');

Node(length(Node)+1)=struct('ID',Sub11+13,'Coord',[0,0,H3-M2S_t/2],'Group','M2');

Element(length(Element)+1)=struct('ID',Sub11+31,'Node',[1,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+32,'Node',[2,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+33,'Node',[3,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+34,'Node',[4,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+35,'Node',[5,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+36,'Node',[6,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+37,'Node',[7,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+38,'Node',[8,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+39,'Node',[9,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+40,'Node',[10,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+41,'Node',[11,13]+Sub11,'Group','M2_structure');
Element(length(Element)+1)=struct('ID',Sub11+42,'Node',[12,13]+Sub11,'Group','M2_structure');

% M2 spider

Sub12=300000;

% 110014
% 200005
Node(length(Node)+1)=struct('ID',Sub12+1,'Coord',[([M2S_r*cos((30+240)*pi/180),M2S_r*sin((30+240)*pi/180)]+(M1ring_p2+M1ring_p3)/2)/2,(H2+H3)/2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub12+2,'Coord',[([M2S_r*cos((30+240)*pi/180),M2S_r*sin((30+240)*pi/180)]+(M1ring_p2+M1ring_p3)/2)/2,(H2+H3-4)/2],'Group',[]);
% 110020
% 200002
Node(length(Node)+1)=struct('ID',Sub12+3,'Coord',[([M2S_r*cos((30+60)*pi/180),M2S_r*sin((30+60)*pi/180)]+(M1ring_p6+M1ring_p7)/2)/2,(H2+H3)/2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub12+4,'Coord',[([M2S_r*cos((30+60)*pi/180),M2S_r*sin((30+60)*pi/180)]+(M1ring_p6+M1ring_p7)/2)/2,(H2+H3-4)/2],'Group',[]);
% 110016
% 200004
Node(length(Node)+1)=struct('ID',Sub12+5,'Coord',[([M2S_r*cos((30+180)*pi/180),M2S_r*sin((30+180)*pi/180)]+(M1ring_p4+M1ring_pB)/2)/2,(H2+H3)/2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub12+6,'Coord',[([M2S_r*cos((30+180)*pi/180),M2S_r*sin((30+180)*pi/180)]+(M1ring_p4+M1ring_pB)/2)/2,(H2+H3-8)/2],'Group',[]);
% 110018
% 200003
Node(length(Node)+1)=struct('ID',Sub12+7,'Coord',[([M2S_r*cos((30+120)*pi/180),M2S_r*sin((30+120)*pi/180)]+(M1ring_pC+M1ring_p5)/2)/2,(H2+H3)/2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub12+8,'Coord',[([M2S_r*cos((30+120)*pi/180),M2S_r*sin((30+120)*pi/180)]+(M1ring_pC+M1ring_p5)/2)/2,(H2+H3-8)/2],'Group',[]);
% 110022
% 200001
Node(length(Node)+1)=struct('ID',Sub12+9,'Coord',[([M2S_r*cos((30+0)*pi/180),M2S_r*sin((30+0)*pi/180)]+(M1ring_p8+M1ring_pD)/2)/2,(H2+H3)/2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub12+10,'Coord',[([M2S_r*cos((30+0)*pi/180),M2S_r*sin((30+0)*pi/180)]+(M1ring_p8+M1ring_pD)/2)/2,(H2+H3-8)/2],'Group',[]);
% 110024
% 200006
Node(length(Node)+1)=struct('ID',Sub12+11,'Coord',[([M2S_r*cos((30+300)*pi/180),M2S_r*sin((30+300)*pi/180)]+(M1ring_pA+M1ring_p1)/2)/2,(H2+H3)/2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub12+12,'Coord',[([M2S_r*cos((30+300)*pi/180),M2S_r*sin((30+300)*pi/180)]+(M1ring_pA+M1ring_p1)/2)/2,(H2+H3-8)/2],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub12+1,'Node',[110014,300001],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+2,'Node',[110014,300002],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+3,'Node',[300001,300002],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+4,'Node',[300001,200011],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+5,'Node',[300001,200005],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+6,'Node',[300002,200011],'Group','Sp_structure_2');

Element(length(Element)+1)=struct('ID',Sub12+7,'Node',[110020,300003],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+8,'Node',[110020,300004],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+9,'Node',[300003,300004],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+10,'Node',[300003,200008],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+11,'Node',[300003,200002],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+12,'Node',[300004,200008],'Group','Sp_structure_2');

Element(length(Element)+1)=struct('ID',Sub12+13,'Node',[110016,300005],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+14,'Node',[300005,200004],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+15,'Node',[200010,300006],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+16,'Node',[300006,100009],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+17,'Node',[300005,300006],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+18,'Node',[300005,200010],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+19,'Node',[110016,300006],'Group','Sp_structure_2');

Element(length(Element)+1)=struct('ID',Sub12+20,'Node',[110018,300007],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+21,'Node',[300007,200003],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+22,'Node',[200009,300008],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+23,'Node',[300008,100010],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+24,'Node',[300007,300008],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+25,'Node',[300007,200009],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+26,'Node',[110018,300008],'Group','Sp_structure_2');

Element(length(Element)+1)=struct('ID',Sub12+27,'Node',[110022,300009],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+28,'Node',[300009,200001],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+29,'Node',[200007,300010],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+30,'Node',[300010,100012],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+31,'Node',[300009,300010],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+32,'Node',[300009,200007],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+33,'Node',[110022,300010],'Group','Sp_structure_2');

Element(length(Element)+1)=struct('ID',Sub12+34,'Node',[110024,300011],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+35,'Node',[300011,200006],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+36,'Node',[200012,300012],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+37,'Node',[300012,100011],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+38,'Node',[300011,300012],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+39,'Node',[300011,200012],'Group','Sp_structure_2');
Element(length(Element)+1)=struct('ID',Sub12+40,'Node',[110024,300012],'Group','Sp_structure_2');

% Tower

Sub13=400000;
Sub13_diff1=10000;
Sub13_diff2=20000;
Sub13_diff3=30000;
Sub13_diff4=40000;
Sub13_diff5=50000;

T_h1=H_Nas+3.5;
T_h2=H_Nas+7;
T_h3=H_Nas+11.4;
T_h4=H_Nas+15;

T_R=[7.5,6.6,4,4]/2;

for ii=1:18
    Node(length(Node)+1)=struct('ID',Sub13+ii,'Coord',[-T_R(1)*cos((90+(ii-1)*20)*pi/180),T_R(1)*sin((90+(ii-1)*20)*pi/180),T_h1],'Group',[]);
end
for ii=1:18
    Element(length(Element)+1)=struct('ID',Sub13+ii,'Node',[Sub13+ii,Sub7+ii],'Group','Tower');
end

for ii=19:36
    Node(length(Node)+1)=struct('ID',Sub13+ii,'Coord',[-T_R(2)*cos((90+(ii-19)*20)*pi/180),T_R(2)*sin((90+(ii-19)*20)*pi/180),T_h2],'Group',[]);
end
for ii=19:36
    Element(length(Element)+1)=struct('ID',Sub13+ii,'Node',[Sub13-18+ii,Sub13+ii],'Group','Tower');
end

for ii=37:54
    Node(length(Node)+1)=struct('ID',Sub13+ii,'Coord',[-T_R(3)*cos((90+(ii-37)*20)*pi/180),T_R(3)*sin((90+(ii-37)*20)*pi/180),T_h3],'Group',[]);
end
for ii=37:54
    Element(length(Element)+1)=struct('ID',Sub13+ii,'Node',[Sub13-18+ii,Sub13+ii],'Group','Tower');
end

for ii=55:72
    Node(length(Node)+1)=struct('ID',Sub13+ii,'Coord',[-T_R(4)*cos((90+(ii-55)*20)*pi/180),T_R(4)*sin((90+(ii-55)*20)*pi/180),T_h4],'Group',[]);
end
for ii=55:72
    Element(length(Element)+1)=struct('ID',Sub13+ii,'Node',[Sub13-18+ii,Sub13+ii],'Group','Tower');
end

for ii=1:17
    Element(length(Element)+1)=struct('ID',Sub13+72+ii,'Node',[Sub13+ii,Sub13+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+72+18,'Node',[Sub13+18,Sub13+1],'Group','Tower');

for ii=19:35
    Element(length(Element)+1)=struct('ID',Sub13+72+ii,'Node',[Sub13+ii,Sub13+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+72+36,'Node',[Sub13+36,Sub13+19],'Group','Tower');

for ii=37:53
    Element(length(Element)+1)=struct('ID',Sub13+72+ii,'Node',[Sub13+ii,Sub13+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+72+54,'Node',[Sub13+54,Sub13+37],'Group','Tower');

for ii=55:71
    Element(length(Element)+1)=struct('ID',Sub13+72+ii,'Node',[Sub13+ii,Sub13+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+72+72,'Node',[Sub13+72,Sub13+55],'Group','Tower');

for ii=1:17
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff1+ii,'Node',[Sub13+ii,Sub13+18+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff1+18,'Node',[Sub13+18,Sub13+19],'Group','Tower');

for ii=19:35
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff1+ii,'Node',[Sub13+ii,Sub13+18+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff1+36,'Node',[Sub13+36,Sub13+37],'Group','Tower');

for ii=37:53
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff1+ii,'Node',[Sub13+ii,Sub13+18+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff1+54,'Node',[Sub13+54,Sub13+55],'Group','Tower');

for ii=2:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff2+ii,'Node',[Sub13+ii,Sub13+18+ii-1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff2+1,'Node',[Sub13+1,Sub13+36],'Group','Tower');

for ii=20:36
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff2+ii,'Node',[Sub13+ii,Sub13+18+ii-1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff2+19,'Node',[Sub13+19,Sub13+54],'Group','Tower');

for ii=38:54
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff2+ii,'Node',[Sub13+ii,Sub13+18+ii-1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff2+37,'Node',[Sub13+37,Sub13+72],'Group','Tower');

for ii=1:17
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff3+ii,'Node',[Sub13+ii,Sub7+ii+1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff3+18,'Node',[Sub13+18,Sub7+1],'Group','Tower');

for ii=2:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff4+ii,'Node',[Sub13+ii,Sub7+ii-1],'Group','Tower');
end
Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff4+1,'Node',[Sub13+1,Sub7+18],'Group','Tower');

M4h=H_Nas+14;
Node(length(Node)+1)=struct('ID',Sub13+Sub13_diff5+1,'Coord',[0,0,M4h],'Group','M4');
M5h=H_Rad;
Node(length(Node)+1)=struct('ID',Sub13+Sub13_diff5+2,'Coord',[0,0,M5h],'Group','M5');

for ii=1:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff5+ii,'Node',[Sub13+54+ii,Sub13+Sub13_diff5+1],'Group','Tower');
end

for ii=1:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff5+18+ii,'Node',[Sub13+ii,Sub13+Sub13_diff5+2],'Group','Tower');
end

for ii=1:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff5+36+ii,'Node',[Sub7+ii,Sub13+Sub13_diff5+2],'Group','Tower');
end

M3h=(H_Rad-R_ear*cos(angle_group(7)*pi/180)+H_Rad-R_ear*cos(angle_group(8)*pi/180))/2;
Node(length(Node)+1)=struct('ID',Sub13+Sub13_diff5+3,'Coord',[0,0,M3h],'Group','M3');

for ii=1:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff5+100+ii,'Node',[Sub7+ii,Sub13+Sub13_diff5+3],'Group','Tower');
end

for ii=1:18
    Element(length(Element)+1)=struct('ID',Sub13+Sub13_diff5+200+ii,'Node',[Sub8+ii,Sub13+Sub13_diff5+3],'Group','Tower');
end

% M1 Bottom

M1Bot_h1=H_Rad-R_ear*cos(angle_group(10)*pi/180);
M1Bot_h2=H_Rad-R_ear*cos(angle_group(17)*pi/180);

B1=5;
B2=R_ear*sin(angle_group(26)*pi/180);
B3=18.5;

W1=M1ring_p7(1);
W2=M1ring_p8(1);

Sub14=500000;

Node(length(Node)+1)=struct('ID',Sub14+1,'Coord',[W1,B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+2,'Coord',[W1,B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+3,'Coord',[W1,B3,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+4,'Coord',[W1,-B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+5,'Coord',[W1,-B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+6,'Coord',[W1,-B3,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+7,'Coord',[-W1,B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+8,'Coord',[-W1,B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+9,'Coord',[-W1,B3,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+10,'Coord',[-W1,-B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+11,'Coord',[-W1,-B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+12,'Coord',[-W1,-B3,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+13,'Coord',[W2,B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+14,'Coord',[W2,B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+15,'Coord',[W2,-B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+16,'Coord',[W2,-B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+17,'Coord',[-W2,B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+18,'Coord',[-W2,B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+19,'Coord',[-W2,-B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+20,'Coord',[-W2,-B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+21,'Coord',[-(W1+W2)/2,-B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+22,'Coord',[-(W1+W2)/2,-B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+23,'Coord',[-(W1+W2)/2,B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+24,'Coord',[-(W1+W2)/2,B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+25,'Coord',[(W1+W2)/2,-B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+26,'Coord',[(W1+W2)/2,-B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+27,'Coord',[(W1+W2)/2,B1,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+28,'Coord',[(W1+W2)/2,B2,M1Bot_h1],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+29,'Coord',[-W1,-B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+30,'Coord',[W1,-B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+31,'Coord',[W1,B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+32,'Coord',[-W1,B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+33,'Coord',[-W2,-B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+34,'Coord',[W2,-B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+35,'Coord',[W2,B1,M1Bot_h2],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub14+36,'Coord',[-W2,B1,M1Bot_h2],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub14+1,'Node',[11006,Sub14+9],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+2,'Node',[Sub14+9,Sub14+8],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+3,'Node',[Sub14+8,Sub14+7],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+4,'Node',[Sub14+7,Sub14+10],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+5,'Node',[Sub14+10,Sub14+11],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+6,'Node',[Sub14+11,Sub14+12],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+7,'Node',[Sub14+12,11003],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+8,'Node',[11007,Sub14+3],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+9,'Node',[Sub14+3,Sub14+2],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+10,'Node',[Sub14+2,Sub14+1],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+11,'Node',[Sub14+1,Sub14+4],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+12,'Node',[Sub14+4,Sub14+5],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+13,'Node',[Sub14+5,Sub14+6],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+14,'Node',[Sub14+6,11002],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+15,'Node',[Sub14+2,Sub14+28],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+16,'Node',[Sub14+28,Sub14+14],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+17,'Node',[Sub14+14,11008],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+18,'Node',[Sub14+14,11021],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+19,'Node',[Sub14+8,Sub14+24],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+20,'Node',[Sub14+24,Sub14+18],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+21,'Node',[Sub14+18,11005],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+22,'Node',[Sub14+18,11017],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+23,'Node',[Sub14+2,Sub14+8],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+24,'Node',[Sub14+1,Sub14+27],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+25,'Node',[Sub14+27,Sub14+13],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+26,'Node',[Sub14+13,7058],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+27,'Node',[Sub14+7,Sub14+23],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+28,'Node',[Sub14+23,Sub14+17],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+29,'Node',[Sub14+17,5058],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+30,'Node',[Sub14+1,Sub14+7],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+31,'Node',[Sub14+4,Sub14+26],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+32,'Node',[Sub14+26,Sub14+15],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+33,'Node',[Sub14+15,7057],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+34,'Node',[Sub14+10,Sub14+22],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+35,'Node',[Sub14+22,Sub14+19],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+36,'Node',[Sub14+19,5057],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+37,'Node',[Sub14+10,Sub14+4],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+38,'Node',[Sub14+5,Sub14+25],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+39,'Node',[Sub14+25,Sub14+16],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+40,'Node',[Sub14+16,11001],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+41,'Node',[Sub14+16,11010],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+42,'Node',[Sub14+11,Sub14+21],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+43,'Node',[Sub14+21,Sub14+20],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+44,'Node',[Sub14+20,11004],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+45,'Node',[Sub14+20,11014],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+46,'Node',[Sub14+5,Sub14+11],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+47,'Node',[Sub14+14,Sub14+13],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+48,'Node',[Sub14+13,Sub14+15],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+49,'Node',[Sub14+15,Sub14+16],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+50,'Node',[Sub14+28,11021],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+51,'Node',[Sub14+25,11010],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+52,'Node',[Sub14+18,Sub14+17],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+53,'Node',[Sub14+17,Sub14+19],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+54,'Node',[Sub14+19,Sub14+20],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+55,'Node',[Sub14+24,11017],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+56,'Node',[Sub14+21,11014],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+57,'Node',[Sub14+3,Sub14+9],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+58,'Node',[Sub14+6,Sub14+12],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+59,'Node',[Sub14+33,Sub14+29],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+60,'Node',[Sub14+29,Sub14+30],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+61,'Node',[Sub14+30,Sub14+34],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+62,'Node',[Sub14+33,5014],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+63,'Node',[Sub14+34,7014],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+64,'Node',[Sub14+36,Sub14+32],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+65,'Node',[Sub14+32,Sub14+31],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+66,'Node',[Sub14+31,Sub14+35],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+67,'Node',[Sub14+36,5020],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+68,'Node',[Sub14+35,7020],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+69,'Node',[Sub14+33,Sub14+20],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+70,'Node',[Sub14+36,Sub14+18],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+71,'Node',[Sub14+34,Sub14+16],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+72,'Node',[Sub14+35,Sub14+14],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+73,'Node',[Sub14+29,Sub14+11],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+74,'Node',[Sub14+30,Sub14+5],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+75,'Node',[Sub14+32,Sub14+8],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+76,'Node',[Sub14+31,Sub14+2],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+77,'Node',[Sub14+36,Sub14+33],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+78,'Node',[Sub14+32,Sub14+29],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+79,'Node',[Sub14+31,Sub14+30],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+80,'Node',[Sub14+35,Sub14+34],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+81,'Node',[Sub14+35,Sub14+13],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+82,'Node',[Sub14+35,Sub14+15],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+83,'Node',[Sub14+35,Sub14+27],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+84,'Node',[Sub14+34,Sub14+15],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+85,'Node',[Sub14+34,Sub14+13],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+86,'Node',[Sub14+34,Sub14+26],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+87,'Node',[Sub14+36,Sub14+17],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+88,'Node',[Sub14+36,Sub14+19],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+89,'Node',[Sub14+36,Sub14+23],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+90,'Node',[Sub14+33,Sub14+19],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+91,'Node',[Sub14+33,Sub14+17],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+92,'Node',[Sub14+33,Sub14+22],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+93,'Node',[Sub14+29,Sub14+10],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+94,'Node',[Sub14+29,Sub14+22],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+95,'Node',[Sub14+29,Sub14+4],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+96,'Node',[Sub14+29,Sub14+7],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+97,'Node',[Sub14+30,Sub14+4],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+98,'Node',[Sub14+30,Sub14+26],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+99,'Node',[Sub14+30,Sub14+10],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+100,'Node',[Sub14+30,Sub14+1],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+101,'Node',[Sub14+31,Sub14+1],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+102,'Node',[Sub14+31,Sub14+27],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+103,'Node',[Sub14+31,Sub14+7],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+104,'Node',[Sub14+31,Sub14+4],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+105,'Node',[Sub14+32,Sub14+7],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+106,'Node',[Sub14+32,Sub14+23],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+107,'Node',[Sub14+32,Sub14+1],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+108,'Node',[Sub14+32,Sub14+10],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+109,'Node',[Sub14+35,Sub14+28],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+110,'Node',[Sub14+31,Sub14+28],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+111,'Node',[Sub14+32,Sub14+24],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+112,'Node',[Sub14+36,Sub14+24],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+113,'Node',[Sub14+33,Sub14+21],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+114,'Node',[Sub14+29,Sub14+21],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+115,'Node',[Sub14+30,Sub14+25],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+116,'Node',[Sub14+34,Sub14+25],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+117,'Node',[Sub14+21,Sub14+12],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+118,'Node',[Sub14+6,Sub14+25],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+119,'Node',[Sub14+28,Sub14+3],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+120,'Node',[Sub14+24,Sub14+9],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+121,'Node',[Sub14+21,11013],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+122,'Node',[Sub14+12,11013],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+123,'Node',[Sub14+6,11011],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+124,'Node',[Sub14+25,11011],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+125,'Node',[Sub14+3,11020],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+126,'Node',[Sub14+28,11020],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+127,'Node',[Sub14+9,11018],'Group','MMS_structure_3');
Element(length(Element)+1)=struct('ID',Sub14+128,'Node',[Sub14+24,11018],'Group','MMS_structure_3');

Sub14_diff=10000;

Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+1,'Node',[18,516]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+2,'Node',[17,516]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+3,'Node',[20,503]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+4,'Node',[19,503]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+5,'Node',[19,433]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+6,'Node',[17,433]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+7,'Node',[18,603]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+8,'Node',[24,603]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+9,'Node',[24,446]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+10,'Node',[8,446]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+11,'Node',[17,302]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+12,'Node',[23,302]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+13,'Node',[7,145]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+14,'Node',[23,145]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+15,'Node',[19,294]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+16,'Node',[22,294]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+17,'Node',[22,136]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+18,'Node',[10,136]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+19,'Node',[20,581]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+20,'Node',[21,581]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+21,'Node',[11,420]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+22,'Node',[21,420]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+23,'Node',[7,196]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+24,'Node',[8,196]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+25,'Node',[7,15]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+26,'Node',[10,15]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+27,'Node',[10,178]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+28,'Node',[11,178]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+29,'Node',[9,526]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+30,'Node',[8,526]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+31,'Node',[11,493]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+32,'Node',[12,493]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+33,'Node',[9,694]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+34,'Node',[12,657]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+35,'Node',[14,464]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+36,'Node',[13,464]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+37,'Node',[15,477]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+38,'Node',[16,477]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+39,'Node',[13,397]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+40,'Node',[15,397]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+41,'Node',[14,539]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+42,'Node',[28,539]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+43,'Node',[2,384]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+44,'Node',[28,384]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+45,'Node',[1,115]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+46,'Node',[27,115]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+47,'Node',[27,264]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+48,'Node',[13,264]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+49,'Node',[4,124]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+50,'Node',[26,124]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+51,'Node',[26,272]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+52,'Node',[15,272]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+53,'Node',[25,561]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+54,'Node',[16,561]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+55,'Node',[25,410]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+56,'Node',[5,410]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+57,'Node',[3,454]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+58,'Node',[2,454]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+59,'Node',[2,154]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+60,'Node',[1,154]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+61,'Node',[1,5]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+62,'Node',[4,5]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+63,'Node',[4,172]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+64,'Node',[5,172]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+65,'Node',[5,487]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+66,'Node',[6,487]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+67,'Node',[6,652]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+68,'Node',[3,615]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+69,'Node',[3,451]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+70,'Node',[9,451]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+71,'Node',[6,490]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+72,'Node',[12,490]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+73,'Node',[2,199]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+74,'Node',[8,199]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+75,'Node',[11,226]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+76,'Node',[5,226]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+77,'Node',[1,1]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+78,'Node',[7,1]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+79,'Node',[10,10]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+80,'Node',[4,10]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+81,'Node',[17,679]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+82,'Node',[5058,679]+[0,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+83,'Node',[19,672]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+84,'Node',[5057,672]+[0,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+85,'Node',[13,630]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+86,'Node',[7058,630]+[0,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+87,'Node',[15,637]+[Sub14,Sub8],'Group','MMS_structure_4');
Element(length(Element)+1)=struct('ID',Sub14+Sub14_diff+88,'Node',[7057,637]+[0,Sub8],'Group','MMS_structure_4');

%% Connection

Sub15=600000;
Sub15_diff=10000;

Ch_final=H1;
Ch_start=H_Rad-R_ear*cos(angle_group(7)*pi/180);

Delta_Ch=(Ch_final-Ch_start)/6;

% 10004/ 100005

Node(length(Node)+1)=struct('ID',Sub15+1,'Coord',[M1ring_outer/2*[cos(pi/180*(180+M1_theta1)),sin(pi/180*(180+M1_theta1))],Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+2,'Coord',[M1ring_outer/2*[cos(pi/180*(180+M1_theta1)),sin(pi/180*(180+M1_theta1))],3*Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+3,'Coord',[M1ring_outer/2*[cos(pi/180*(180+M1_theta1)),sin(pi/180*(180+M1_theta1))],5*Delta_Ch+Ch_start],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub15+1,'Node',[10004,Sub15+1],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2,'Node',[Sub15+1,Sub15+2],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3,'Node',[Sub15+2,Sub15+3],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4,'Node',[Sub15+3,100005],'Group','MMS_structure_1');

Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+1,'Node',[5007,Sub15+1],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+2,'Node',[5006,Sub15+1],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+3,'Node',[5005,Sub15+1],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+4,'Node',[5005,Sub15+2],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+5,'Node',[5004,Sub15+2],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+6,'Node',[5003,Sub15+2],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+7,'Node',[5003,Sub15+3],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+8,'Node',[5002,Sub15+3],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+Sub15_diff+9,'Node',[5001,Sub15+3],'Group','MMS_structure_1');

% 10001/ 100008

Node(length(Node)+1)=struct('ID',Sub15+4,'Coord',[M1ring_outer/2*[cos(pi/180*(-M1_theta1)),sin(pi/180*(-M1_theta1))],Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+5,'Coord',[M1ring_outer/2*[cos(pi/180*(-M1_theta1)),sin(pi/180*(-M1_theta1))],3*Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+6,'Coord',[M1ring_outer/2*[cos(pi/180*(-M1_theta1)),sin(pi/180*(-M1_theta1))],5*Delta_Ch+Ch_start],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub15+5,'Node',[10001,Sub15+4],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+6,'Node',[Sub15+4,Sub15+5],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+7,'Node',[Sub15+5,Sub15+6],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+8,'Node',[Sub15+6,100008],'Group','MMS_structure_1');

Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+1,'Node',[7007,Sub15+4],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+2,'Node',[7006,Sub15+4],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+3,'Node',[7005,Sub15+4],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+4,'Node',[7005,Sub15+5],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+5,'Node',[7004,Sub15+5],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+6,'Node',[7003,Sub15+5],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+7,'Node',[7003,Sub15+6],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+8,'Node',[7002,Sub15+6],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+2*Sub15_diff+9,'Node',[7001,Sub15+6],'Group','MMS_structure_1');

% 10008/ 100007

Node(length(Node)+1)=struct('ID',Sub15+7,'Coord',[M1ring_outer/2*[cos(pi/180*(M1_theta1)),sin(pi/180*(M1_theta1))],Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+8,'Coord',[M1ring_outer/2*[cos(pi/180*(M1_theta1)),sin(pi/180*(M1_theta1))],3*Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+9,'Coord',[M1ring_outer/2*[cos(pi/180*(M1_theta1)),sin(pi/180*(M1_theta1))],5*Delta_Ch+Ch_start],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub15+9,'Node',[10008,Sub15+7],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+10,'Node',[Sub15+7,Sub15+8],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+11,'Node',[Sub15+8,Sub15+9],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+12,'Node',[Sub15+9,100007],'Group','MMS_structure_1');

Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+1,'Node',[7027,Sub15+7],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+2,'Node',[7028,Sub15+7],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+3,'Node',[7029,Sub15+7],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+4,'Node',[7029,Sub15+8],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+5,'Node',[7030,Sub15+8],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+6,'Node',[7031,Sub15+8],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+7,'Node',[7031,Sub15+9],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+8,'Node',[7032,Sub15+9],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+3*Sub15_diff+9,'Node',[7033,Sub15+9],'Group','MMS_structure_1');

% 10005/ 100006

Node(length(Node)+1)=struct('ID',Sub15+10,'Coord',[M1ring_outer/2*[cos(pi/180*(180-M1_theta1)),sin(pi/180*(180-M1_theta1))],Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+11,'Coord',[M1ring_outer/2*[cos(pi/180*(180-M1_theta1)),sin(pi/180*(180-M1_theta1))],3*Delta_Ch+Ch_start],'Group',[]);
Node(length(Node)+1)=struct('ID',Sub15+12,'Coord',[M1ring_outer/2*[cos(pi/180*(180-M1_theta1)),sin(pi/180*(180-M1_theta1))],5*Delta_Ch+Ch_start],'Group',[]);

Element(length(Element)+1)=struct('ID',Sub15+13,'Node',[10005,Sub15+10],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+14,'Node',[Sub15+10,Sub15+11],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+15,'Node',[Sub15+11,Sub15+12],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+16,'Node',[Sub15+12,100006],'Group','MMS_structure_1');

Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+1,'Node',[5027,Sub15+10],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+2,'Node',[5028,Sub15+10],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+3,'Node',[5029,Sub15+10],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+4,'Node',[5029,Sub15+11],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+5,'Node',[5030,Sub15+11],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+6,'Node',[5031,Sub15+11],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+7,'Node',[5031,Sub15+12],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+8,'Node',[5032,Sub15+12],'Group','MMS_structure_1');
Element(length(Element)+1)=struct('ID',Sub15+4*Sub15_diff+9,'Node',[5033,Sub15+12],'Group','MMS_structure_1');

Sub20=1e9;


%% Check

Node_ID=[];
Node_Coord=[];
for ii=1:length(Node)
    ID=Node(ii).ID;  
    Coord=Node(ii).Coord; 
    Node_ID=[Node_ID;ID];
    Node_Coord=[Node_Coord;Coord];
end
% Node.ID
for ii=1:length(Node)
    ID=Node(ii).ID;  
    k=find(Node_ID==ID);
    if (length(k)>1)
        k
    end
end
% Node.Coord
Glue_group=[];
for ii=1:length(Node)
    Coord=Node(ii).Coord;
    [Lia,Locb]=ismember(Coord,Node_Coord,'rows');
    if (Locb~=ii)
        pair=[Locb,ii];
        Glue_group=[Glue_group;pair];
    end
end


Elem_ID=[];
Elem_Node=[];
for ii=1:length(Element)
    ID=Element(ii).ID;  
    Node_id=Element(ii).Node; 
    Elem_ID=[Elem_ID;ID];
    Elem_Node=[Elem_Node;Node_id];
end
% Element.ID
for ii=1:length(Element)
    ID=Element(ii).ID;  
    k=find(Elem_ID==ID);
    if (length(k)>1)
        k
    end
end

% return;
% % Node.Coord
% for ii=1:length(Node)
%     Node_id=Node(ii).Coord;
%     [Lia,Locb]=ismember(Node_id,Elem_Node,'rows');
%     if (Locb~=ii)
%         Locb
%         ii
%     end
% end

% Uni_Node_ID=unique(Node_ID);
% [C,ia]=intersect(Uni_Node_ID,Node_ID);

%% Plot

figure;
set(gcf,'Position',[776.2000,46.6000,753.6000,737.6000]);
hold on;
box on;
axis equal;
xlim([-40,40]);
ylim([-40,40]);
zlim([0,60]);
xlabel('X [m]');
ylabel('Y [m]');
zlabel('Z [m]');

draw_circle(D_Bout/2);
draw_circle(D_Bin/2);

% Geometry drawing

Patch_coord=[];

for ii=1:length(Point)
    coord=Point(ii).Coord;
    coordx=coord(1);
    coordy=coord(2);
    coordz=coord(3);
    plot3(coordx,coordy,coordz,'b.');
%     text(coordx,coordy,coordz,int2str(Point(ii).ID),'Color',[0.5,0.5,0.5],'FontSize',6);
    Patch_coord=[Patch_coord;coordx,coordy,coordz];
end

% Patch

v=Patch_coord;
f=[1,2,3,4;5,6,7,8];
patch('Faces',f,'Vertices',v,'FaceColor',[0.9,0.9,0.9]);

for ii=1:length(Line)
    pp=Line(ii).Point;
    mm=pp(1);
    nn=pp(2);
    for jj=1:length(Point)
        if(Point(jj).ID==mm)
            coordx1=Point(jj).Coord(1);
            coordy1=Point(jj).Coord(2);
            coordz1=Point(jj).Coord(3);
        end
    end
    for jj=1:length(Point)
        if(Point(jj).ID==nn)
            coordx2=Point(jj).Coord(1);
            coordy2=Point(jj).Coord(2);
            coordz2=Point(jj).Coord(3);
        end
    end
    X_line=[coordx1;coordx2];
    Y_line=[coordy1;coordy2];
    Z_line=[coordz1;coordz2];
    plot3(X_line,Y_line,Z_line,'k-','LineWidth',1);
    
end

% FE model drawing

% Support01 Sub1
% Support12 Sub2
% Nasmyth Sub3
% Ring Left Sub4
% Ring Right Sub5
% M1Ring Sub6
% M1Upper Sub7
% M1Down Sub8
% M1Middle Sub9
% M2 Sub11
% M2spider Sub12
% Tower Sub13
% M1Bottom Sub14

for ii=1:length(Node)
    if(strcmp(Node(ii).Group,'M2'))
        coord=Node(ii).Coord;
        coordx=coord(1);
        coordy=coord(2);
        coordz=coord(3);
        plot3(coordx,coordy,coordz,'r.','MarkerSize',10);
    end
    if(strcmp(Node(ii).Group,'M3'))
        coord=Node(ii).Coord;
        coordx=coord(1);
        coordy=coord(2);
        coordz=coord(3);
        plot3(coordx,coordy,coordz,'r.','MarkerSize',10);
    end
    if(strcmp(Node(ii).Group,'M4'))
        coord=Node(ii).Coord;
        coordx=coord(1);
        coordy=coord(2);
        coordz=coord(3);
        plot3(coordx,coordy,coordz,'r.','MarkerSize',10);
    end
    if(strcmp(Node(ii).Group,'M5'))
        coord=Node(ii).Coord;
        coordx=coord(1);
        coordy=coord(2);
        coordz=coord(3);
        plot3(coordx,coordy,coordz,'r.','MarkerSize',10);
    end
end

% for ii=1:length(Node)
%     coord=Node(ii).Coord;
%     coordx=coord(1);
%     coordy=coord(2);
%     coordz=coord(3);
% %     ((Node(ii).ID>Sub4)&&(Node(ii).ID<Sub7))||
% % ((Node(ii).ID>=Sub6)&&(Node(ii).ID<Sub7))||((Node(ii).ID>Sub14))
% % ((Node(ii).ID>Sub8)&&(Node(ii).ID<Sub9))||
%     if (Node(ii).ID>Sub14)
% %         &&(Node(ii).ID<Sub14))
% %         ||((Node(ii).ID>Sub9)&&(Node(ii).ID<Sub13))
%         
% %         if coordz>M1Bot_h2
%             plot3(coordx,coordy,coordz,'k.');
%             if(node_label==1)
%                 if(strcmp(Node(ii).Group,'Node_mirror_seg'))
%                 else
%                     text(coordx,coordy,coordz,int2str(Node(ii).ID),'Color',[0.5,0.5,0.5],'FontSize',6);
%                 end
%             end
% %         end
%     end %%
% end

% for jj=1:length(Node_index)
%     ii=Node_index(jj);
%     coord=Node(ii).Coord;
%     coordx=coord(1);
%     coordy=coord(2);
%     coordz=coord(3);
%     plot3(coordx,coordy,coordz,'r.');
% %     text(coordx,coordy,coordz,int2str(Node(ii).ID),'Color',[0.5,0.5,0.5],'FontSize',6);
% end

for ii=1:length(Element)
    pp=Element(ii).Node;
    mm=pp(1);
    nn=pp(2);
    for jj=1:length(Node)
        if(Node(jj).ID==mm)
            coordx1=Node(jj).Coord(1);
            coordy1=Node(jj).Coord(2);
            coordz1=Node(jj).Coord(3);
        end
    end
    for jj=1:length(Node)
        if(Node(jj).ID==nn)
            coordx2=Node(jj).Coord(1);
            coordy2=Node(jj).Coord(2);
            coordz2=Node(jj).Coord(3);
        end
    end
    X_line=[coordx1;coordx2];
    Y_line=[coordy1;coordy2];
    Z_line=[coordz1;coordz2];
    if(strcmp(Element(ii).Group,'Support_Beam_0_1'))
        plot3(X_line,Y_line,Z_line,'Color',[0,0.5,0.3],'LineWidth',1);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','r','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'Support_Beam_1_2'))
        plot3(X_line,Y_line,Z_line,'Color',[0.3,0,0.5],'LineWidth',1);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','b','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'Ring'))
        plot3(X_line,Y_line,Z_line,'k-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'MMS_structure_1'))
        plot3(X_line,Y_line,Z_line,'k-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'MMS_structure_2'))
        plot3(X_line,Y_line,Z_line,'k-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'MMS_structure_3'))
        plot3(X_line,Y_line,Z_line,'k-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'MMS_structure_4'))
        plot3(X_line,Y_line,Z_line,'g-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'M1_truss'))
        plot3(X_line,Y_line,Z_line,'b-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'M1_truss_middle'))
        plot3(X_line,Y_line,Z_line,'Color',[0.5,0.7,0.9],'LineWidth',0.1);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'Sp_structure_1'))
        plot3(X_line,Y_line,Z_line,'k-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'Sp_structure_2'))
        plot3(X_line,Y_line,Z_line,'Color',[0,0,0.5],'LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'M2_structure'))
        plot3(X_line,Y_line,Z_line,'r-','LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    elseif(strcmp(Element(ii).Group,'Tower'))
        plot3(X_line,Y_line,Z_line,'Color',[0.8,0.5,0],'LineWidth',0.5);
        if(element_label==1)
            coordx_center=(coordx1+coordx2)/2;
            coordy_center=(coordy1+coordy2)/2;
            coordz_center=(coordz1+coordz2)/2;
            text(coordx_center,coordy_center,coordz_center,int2str(Element(ii).ID),'Color','k','FontSize',8);
        end
    end
end

view([-26,16]);
% view([0,90]);

%% Write SAMCEF file

fprintf(h_elt,['.DEL.*\n']);
fprintf(h_elt,['.UNIT SI\n']);
fprintf(h_elt,['MODE PREC 1e-5\n']);
fprintf(h_elt,['\n']);

fprintf(h_elt,['! A. GEOMETRY FILE (Point)\n']);
for ii=1:length(Point)
    fprintf(h_elt,['.3POI I %i X %g Y %g Z %g\n'],Point(ii).ID,Point(ii).Coord(1),Point(ii).Coord(2),Point(ii).Coord(3));
end

fprintf(h_elt,['! B. MESH FILE\n']);
fprintf(h_elt,['! ====================================================\n']);
fprintf(h_elt,['! Generation of the node (truss)\n']);
fprintf(h_elt,['! ====================================================\n']);

for ii=1:length(Node)
    if(strcmp(Node(ii).Group,'Fix_Bottom'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 101\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    elseif(strcmp(Node(ii).Group,'Ear_Support_Beam'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 102\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    elseif(strcmp(Node(ii).Group,'Node_mirror_seg'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 103\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    elseif(strcmp(Node(ii).Group,'M2'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 104\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    elseif(strcmp(Node(ii).Group,'M3'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 105\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));    
    elseif(strcmp(Node(ii).Group,'M4'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 106\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    elseif(strcmp(Node(ii).Group,'M5'))
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 107\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    else
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g\n'],Node(ii).ID,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
    end
end

L_Support_Beam_0_1=0;
L_Support_Beam_1_2=0;
L_Ring=0;
L_MMS_structure_1=0;
L_MMS_structure_2=0;
L_M1_truss=0;
L_M1_truss_middle=0;
L_Sp_structure_1=0;
L_M2_structure=0;
L_Sp_structure_2=0;
L_Tower=0;
L_MMS_structure_3=0;
L_MMS_structure_4=0;


fprintf(h_elt,['! Generation of the element (truss)\n']);
fprintf(h_elt,['! ====================================================\n']);
for ii=1:length(Element)
    if(strcmp(Element(ii).Group,'Support_Beam_0_1'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 1\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_Support_Beam_0_1=L_Support_Beam_0_1+Length;
    elseif(strcmp(Element(ii).Group,'Support_Beam_1_2'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 2\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_Support_Beam_1_2=L_Support_Beam_1_2+Length;
    elseif(strcmp(Element(ii).Group,'Ring'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 3\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_Ring=L_Ring+Length;
    elseif(strcmp(Element(ii).Group,'MMS_structure_1'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 4\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_MMS_structure_1=L_MMS_structure_1+Length;
    elseif(strcmp(Element(ii).Group,'MMS_structure_2'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 5\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_MMS_structure_2=L_MMS_structure_2+Length;
    elseif(strcmp(Element(ii).Group,'M1_truss'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 6\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_M1_truss=L_M1_truss+Length;
    elseif(strcmp(Element(ii).Group,'M1_truss_middle'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 7\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_M1_truss_middle=L_M1_truss_middle+Length;
    elseif(strcmp(Element(ii).Group,'Sp_structure_1'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 8\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_Sp_structure_1=L_Sp_structure_1+Length;
    elseif(strcmp(Element(ii).Group,'M2_structure'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 9\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_M2_structure=L_M2_structure+Length;
    elseif(strcmp(Element(ii).Group,'Sp_structure_2'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 10\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_Sp_structure_2=L_Sp_structure_2+Length;
    elseif(strcmp(Element(ii).Group,'Tower'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 11\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_Tower=L_Tower+Length;
    elseif(strcmp(Element(ii).Group,'MMS_structure_3'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 12\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_MMS_structure_3=L_MMS_structure_3+Length;
    elseif(strcmp(Element(ii).Group,'MMS_structure_4'))
        fprintf(h_elt,['.MAI I %i N %i %i AT 13\n'],Element(ii).ID,Element(ii).Node(1),Element(ii).Node(2));
        [ID,Length]=truss_length(ii,Element,Node);
        L_MMS_structure_4=L_MMS_structure_4+Length;
    else
        disp('No grouped element(s), please check.');
    end
end

M_Support_Beam_0_1=7.8*L_Support_Beam_0_1*pi*(BPR(1).R1^2-BPR(1).R2^2);
M_Support_Beam_1_2=7.8*L_Support_Beam_1_2*pi*(BPR(2).R1^2-BPR(2).R2^2);
M_Ring=7.8*L_Ring*pi*(BPR(3).R1^2-BPR(3).R2^2);
M_MMS_structure_1=7.8*L_MMS_structure_1*pi*(BPR(4).R1^2-BPR(4).R2^2);
M_MMS_structure_2=7.8*L_MMS_structure_2*pi*(BPR(5).R1^2-BPR(5).R2^2);
M_M1_truss=7.8*L_M1_truss*pi*(BPR(6).R1^2-BPR(6).R2^2);
M_M1_truss_middle=7.8*L_M1_truss_middle*pi*(BPR(7).R1^2-BPR(7).R2^2);
M_Sp_structure_1=7.8*L_Sp_structure_1*pi*(BPR(8).R1^2-BPR(8).R2^2);
M_M2_structure=7.8*L_M2_structure*pi*(BPR(9).R1^2-BPR(9).R2^2);
M_Sp_structure_2=7.8*L_Sp_structure_2*pi*(BPR(10).R1^2-BPR(10).R2^2);
M_Tower=7.8*L_Tower*pi*(BPR(11).R1^2-BPR(11).R2^2);
M_MMS_structure_3=7.8*L_MMS_structure_3*pi*(BPR(12).R1^2-BPR(12).R2^2);
M_MMS_structure_4=7.8*L_MMS_structure_4*pi*(BPR(13).R1^2-BPR(13).R2^2);

% Manually add
fprintf(h_elt,['.MAI\n']);
fprintf(h_elt,['    SUPP 5020\n']);
fprintf(h_elt,['    SUPP 7020\n']);

% M5 Coordinate
for ii=1:length(Node)
    if(strcmp(Node(ii).Group,'M5'))
        ID=Node(ii).ID;
        angle_1=pi/4;
        angle_3=3*pi/4;
        basic_axis_1=[cos(angle_1),0,sin(angle_1)];
        basic_axis_3=[cos(angle_3),0,sin(angle_3)];
        fprintf(h_elt,['.AXL I %i\n'],ID);
        fprintf(h_elt,['     AXE 1 DIRECTION %g %g %g\n'],basic_axis_1(1),basic_axis_1(2),basic_axis_1(3));
        fprintf(h_elt,['     AXE 3 DIRECTION %g %g %g\n'],basic_axis_3(1),basic_axis_3(2),basic_axis_3(3));
    end
end


fprintf(h_elt,['! Selection of the group\n']);
fprintf(h_elt,['! ====================================================\n']);

% Selection of node and element group
fprintf(h_elt,['.SEL\n']);
fprintf(h_elt,['   GROUP NOM "Fix_Bottom" NOEUDS AT 101\n']);
fprintf(h_elt,['   GROUP NOM "Ear_Support_Beam" NOEUDS AT 102\n']);
fprintf(h_elt,['   GROUP NOM "Node_mirror_seg" NOEUDS AT 103\n']);
fprintf(h_elt,['   GROUP NOM "M2" NOEUDS AT 104\n']);
fprintf(h_elt,['   GROUP NOM "M3" NOEUDS AT 105\n']);
fprintf(h_elt,['   GROUP NOM "M4" NOEUDS AT 106\n']);
fprintf(h_elt,['   GROUP NOM "M5" NOEUDS AT 107\n']);
fprintf(h_elt,['   GROUP NOM "Node_all" NOEUDS TOUT\n']);

fprintf(h_elt,['   GROUP NOM "Support_Beam_0_1" MAILLE AT 1\n']);
fprintf(h_elt,['   GROUP NOM "Support_Beam_1_2" MAILLE AT 2\n']);
fprintf(h_elt,['   GROUP NOM "Ring" MAILLE AT 3\n']);
fprintf(h_elt,['   GROUP NOM "MMS_structure_1" MAILLE AT 4\n']);
fprintf(h_elt,['   GROUP NOM "MMS_structure_2" MAILLE AT 5\n']);
fprintf(h_elt,['   GROUP NOM "M1_truss" MAILLE AT 6\n']);
fprintf(h_elt,['   GROUP NOM "M1_truss_middle" MAILLE AT 7\n']);
fprintf(h_elt,['   GROUP NOM "Sp_structure_1" MAILLE AT 8\n']);
fprintf(h_elt,['   GROUP NOM "M2_structure" MAILLE AT 9\n']);
fprintf(h_elt,['   GROUP NOM "Sp_structure_2" MAILLE AT 10\n']);
fprintf(h_elt,['   GROUP NOM "Tower" MAILLE AT 11\n']);
fprintf(h_elt,['   GROUP NOM "MMS_structure_3" MAILLE AT 12\n']);
fprintf(h_elt,['   GROUP NOM "MMS_structure_4" MAILLE AT 13\n']);

fprintf(h_elt,['! ====================================================\n']);
fprintf(h_elt,['! Nasmyth platform geometry\n']);
fprintf(h_elt,['.PLAN I 1 Z %g \n'],H_Nas);

for ii=1:length(Line)
    fprintf(h_elt,['.3DROI I %i POINTS %i %i \n'],Line(ii).ID,Line(ii).Point(1),Line(ii).Point(2));
end

fprintf(h_elt,['.CON I 1 LIGNES %i A %i FERME\n'],1001,1004);
fprintf(h_elt,['.CON I 2 LIGNES %i A %i FERME\n'],1005,1008);
fprintf(h_elt,['.CON I 1001 POINTS %i A %i FERME\n'],1009,1020);
fprintf(h_elt,['.CON I 1002 POINTS %i A %i FERME\n'],1021,1032);
fprintf(h_elt,['.DOM I 1 CONTOURS %i %i SURFACE %i\n'],1,1001,1);
fprintf(h_elt,['.DOM I 2 CONTOURS %i %i SURFACE %i\n'],2,1002,1);

fprintf(h_elt,['! Generation of the mesh\n']);
fprintf(h_elt,['.GEN DEGRE 1 DOMAINES %i ATTRIBUT %i\n'],1,1001);
fprintf(h_elt,['.GEN DEGRE 1 DOMAINES %i ATTRIBUT %i\n'],2,1002);

Section1=15;
Section2=30;

fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1001,Section1);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1002,Section2);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1003,Section1);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1004,Section2);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1005,Section1);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1006,Section2);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1007,Section1);
fprintf(h_elt,['.GEN MODIFIE LIGNE %i ELEMENT %i\n'],1008,Section2);
fprintf(h_elt,['.GEN MAILLE %i A %i TRIANGULATION DELAUNAY\n'],1,2);

fprintf(h_elt,['.COL NOEUDS\n']);
fprintf(h_elt,['      EXECUTE\n']);
fprintf(h_elt,['.PURGE PURGE NOEUDS\n']);

% Selection of all the nodes and cells
fprintf(h_elt,['.SEL\n']);
fprintf(h_elt,['   GROUP NOM "nodes_elt" NOEUDS TOUT\n']);
fprintf(h_elt,['   GROUP NOM "cells_elt" MAILLE TOUT\n']);

fprintf(h_elt,['.SEL\n']);
fprintf(h_elt,['   GROUP NOM "Nas_R" MAILLE AT 1001\n']);
fprintf(h_elt,['   GROUP NOM "Nas_L" MAILLE AT 1002\n']);
fprintf(h_elt,['   GROUP NOM "Al_Structure" MAILLE AT 3 A 13\n']);
fprintf(h_elt,['   GROUP NOM "Az_Structure" MAILLE AT 1 2 1001 1002\n']);

fprintf(h_elt,['! C. PROPERTY FILE\n']);
fprintf(h_elt,['! ====================================================\n']);

% Define hypothesis

fprintf(h_elt,['.HYP ',Hypothesis,'\n']);

% Define material

fprintf(h_elt,['.MAT\n']);
fprintf(h_elt,['	I %i NOM "Steel" YT %g NT %g A %g M %g TREF %g\n'],1,230*1e9,0.3,0,7500,0);
% Manually input (equivelent material)
fprintf(h_elt,['	I %i NOM "Eqi_mat" YT %g NT %g A %g M %g TREF %g\n'],2,1e12,0.3,0,180,0);


fprintf(h_elt,['! Convert Rod Element to Beam Element\n']);
fprintf(h_elt,['! ====================================================\n']);
fprintf(h_elt,['.BEAM\n']);
for ii=1:length(Element)
    fprintf(h_elt,['     I %i CPOINT 0 0 %g\n'],Element(ii).ID,100);
end
fprintf(h_elt,['\n']);

% Define the Cross-section Profile

fprintf(h_elt,['! Define Cross-section profile\n']);
fprintf(h_elt,['! ====================================================\n']);
fprintf(h_elt,['.BPR\n']);
for ii=1:length(BPR)
    Name=['BPR_',BPR(ii).Name];
    if(strcmp(BPR(ii).Type,'CIRCLE'))
        fprintf(h_elt,['     NOM "',Name,'" UNITE 1 TYPE "',BPR(ii).Type,'" R %g\n'],BPR(ii).R0);
    elseif(strcmp(BPR(ii).Type,'CIRCLE0'))
        fprintf(h_elt,['     NOM "',Name,'" UNITE 1 TYPE "',BPR(ii).Type,'" R1 %g R2 %g\n'],BPR(ii).R1,BPR(ii).R2);
    end
end
fprintf(h_elt,['\n']);

fprintf(h_elt,['! Define Beam Property\n']);
fprintf(h_elt,['! ====================================================\n']);
fprintf(h_elt,['.AEL\n']);
fprintf(h_elt,['    GROUP "Support_Beam_0_1" MAT 1 PRO "BPR_Support_Beam_0_1"\n']);
fprintf(h_elt,['    GROUP "Support_Beam_1_2" MAT 1 PRO "BPR_Support_Beam_1_2"\n']);
fprintf(h_elt,['    GROUP "Ring" MAT 1 PRO "BPR_Ring"\n']);
fprintf(h_elt,['    GROUP "MMS_structure_1" MAT 1 PRO "BPR_MMS_structure_1"\n']);
fprintf(h_elt,['    GROUP "MMS_structure_2" MAT 1 PRO "BPR_MMS_structure_2"\n']);
fprintf(h_elt,['    GROUP "M1_truss" MAT 1 PRO "BPR_M1_truss"\n']);
fprintf(h_elt,['    GROUP "M1_truss_middle" MAT 1 PRO "BPR_M1_truss_middle"\n']);
fprintf(h_elt,['    GROUP "Sp_structure_1" MAT 1 PRO "BPR_Sp_structure_1"\n']);
fprintf(h_elt,['    GROUP "M2_structure" MAT 1 PRO "BPR_M2_structure"\n']);
fprintf(h_elt,['    GROUP "Sp_structure_2" MAT 1 PRO "BPR_Sp_structure_2"\n']);
fprintf(h_elt,['    GROUP "Tower" MAT 1 PRO "BPR_Tower"\n']);
fprintf(h_elt,['    GROUP "MMS_structure_3" MAT 1 PRO "BPR_MMS_structure_3"\n']);
fprintf(h_elt,['    GROUP "MMS_structure_4" MAT 1 PRO "BPR_MMS_structure_4"\n']);

fprintf(h_elt,['.PHP GROUP "Nas_R" THICK VAL %g\n'],1);
fprintf(h_elt,['.PHP GROUP "Nas_L" THICK VAL %g\n'],1);

fprintf(h_elt,['.AEL\n']);
fprintf(h_elt,['    GROUP "Nas_R" MAT 2\n']);
fprintf(h_elt,['    GROUP "Nas_L" MAT 2\n']);

%%
% Lumped Mass
% fprintf(h_elt,['! Define Lumped Mass (Mirror)\n']);
% fprintf(h_elt,['! ====================================================\n']);
% 
% fprintf(h_elt,['.MASS\n']);
% for ii=1:length(Node)
%     if(strcmp(Node(ii).Group,'Node_mirror_seg'))
%         fprintf(h_elt,['   N %i MASS %g\n'],Node(ii).ID,M1mseg);
%     elseif(strcmp(Node(ii).Group,'M2'))
%         fprintf(h_elt,['   N %i MASS %g\n'],Node(ii).ID,M2m);
%     elseif(strcmp(Node(ii).Group,'M3'))
%         fprintf(h_elt,['   N %i MASS %g\n'],Node(ii).ID,M3m);
%     elseif(strcmp(Node(ii).Group,'M4'))
%         fprintf(h_elt,['   N %i MASS %g\n'],Node(ii).ID,M4m);
%     elseif(strcmp(Node(ii).Group,'M5'))
%         fprintf(h_elt,['   N %i MASS %g\n'],Node(ii).ID,M5m);
%     end
% end
% fprintf(h_elt,['   GENERE\n']);
% fprintf(h_elt,['\n']);

fprintf(h_elt,['! Define Lumped Mass and Inertia (Mirror)\n']);
fprintf(h_elt,['! ====================================================\n']);

f_M1seg=60;
Mirror.Diameter=Dim_M1.D_Hex_cc_micro;
Mirror.Mass=M1mseg;
Mirror.Actuator_R=Dim_M1.D_Hex_cc_micro/2*0.85;
Mirror.Actuator_K=(2*pi*f_M1seg)^2*M1mseg/3;
Mirror.Damping=0.01;

[sys_mec,freqs_M1seg,modes_M1seg]=Mirror_system(Mirror);

% freqs_M1seg
% modes_M1seg

ktx=1e10;
kty=1e10;
ktz=Mirror.Actuator_K*3;
ctx=1e10;
cty=1e10;
ctz=2*(2*pi*f_M1seg)*Mirror.Damping*Mirror.Mass*0.001;

connect_index=0;
for ii=1:length(Node)
    if(strcmp(Node(ii).Group,'Node_mirror_seg'))
        connect_index=connect_index+1;
        fprintf(h_elt,['.NOE I %i X %g Y %g Z %g AT 831\n'],Node(ii).ID+831*1e5,Node(ii).Coord(1),Node(ii).Coord(2),Node(ii).Coord(3));
        fprintf(h_elt,['.MCE I %i BUSH N %i %i\n'],connect_index+831*1e5,Node(ii).ID,Node(ii).ID+831*1e5);
        fprintf(h_elt,['.MCC I %i KTX %g KTY %g KTZ %g\n'],connect_index+831*1e5,ktx,kty,ktz);
        fprintf(h_elt,['          CTX %g CTY %g CTZ %g\n'],ctx,cty,ctz);
%         fprintf(h_elt,['.MASS\n']);
%         fprintf(h_elt,['   N %i MASS %g MIXX %g MIYY %g\n'],Node(ii).ID+831*1e5,M1mseg,M1mseg*Dim_M1.D_Hex_cc_micro^2/16,M1mseg*Dim_M1.D_Hex_cc_micro^2/16);
%         fprintf(h_elt,['   GENERE\n']);
    end
end

fprintf(h_elt,['.SEL\n']);
fprintf(h_elt,['   GROUP NOM "Node_mirror_seg_top" NOEUDS AT 831\n']);

fprintf(h_elt,['.MASS\n']);
for ii=1:length(Node)
    if(strcmp(Node(ii).Group,'Node_mirror_seg'))
        fprintf(h_elt,['   N %i MASS %g MIXX %g MIYY %g\n'],Node(ii).ID+831*1e5,M1mseg,M1mseg*Dim_M1.D_Hex_cc_micro^2/16,M1mseg*Dim_M1.D_Hex_cc_micro^2/16);
    elseif(strcmp(Node(ii).Group,'M2'))
        fprintf(h_elt,['   N %i MASS %g MIXX %g MIYY %g\n'],Node(ii).ID,M2m,M2m*Dm2^2/16,M2m*Dm2^2/16);
    elseif(strcmp(Node(ii).Group,'M3'))
        fprintf(h_elt,['   N %i MASS %g MIXX %g MIYY %g\n'],Node(ii).ID,M3m,M3m*Dm3^2/16,M3m*Dm3^2/16);
    elseif(strcmp(Node(ii).Group,'M4'))
        fprintf(h_elt,['   N %i MASS %g MIXX %g MIYY %g\n'],Node(ii).ID,M4m,M4m*Dm4^2/16,M4m*Dm4^2/16);
    elseif(strcmp(Node(ii).Group,'M5'))
        fprintf(h_elt,['   N %i MASS %g MIXX %g MIYY %g\n'],Node(ii).ID,M5m,M5m*Dm5^2/16,M5m*Dm5^2/16);
    end
end
fprintf(h_elt,['   GENERE\n']);
fprintf(h_elt,['\n']);


fprintf(h_elt,['! D. LOAD AND BOUNDARY CONDITION\n']);
fprintf(h_elt,['! ====================================================\n']);
fprintf(h_elt,['.CLM\n']);
fprintf(h_elt,['	FIX GROUP "Fix_Bottom" COMP 1 2 3 4 5 6\n']);
% fprintf(h_elt,['	ACC STRU VAL %g %g %g NC 1\n'],Acc_x,Acc_y,Acc_z);

if(strcmp(Compute_type,'Dynamic'))
    fprintf(h_elt,['.SAM\n']);
    fprintf(h_elt,['        MF 1\n']);
    fprintf(h_elt,['        NALG 4\n']);
    fprintf(h_elt,['        NVAL %i\n'],Model_number);
elseif(strcmp(Compute_type,'Dynamic_Superelement'))    
    fprintf(h_elt,['.RET\n']);
    fprintf(h_elt,['   GROUP "Node_mirror_seg_top" C 3\n']);
    fprintf(h_elt,['   GROUP "M2" C 4 5\n']);
    fprintf(h_elt,['   GROUP "M3" C 4 5\n']);
    fprintf(h_elt,['   GROUP "M4" C 4 5\n']);
    fprintf(h_elt,['   GROUP "M5" C 3 4 5\n']);
%     fprintf(h_elt,['   GROUP "Sp_structure_1" C 1 2 3\n']);
%     fprintf(h_elt,['   GROUP "Sp_structure_2" C 1 2 3\n']);
    fprintf(h_elt,['.CSUP\n']);
    fprintf(h_elt,['   RET DYNAMIQUE COMPOSANTS LANCZOS NVAL %i\n'],900);  % 714+2+2+2+3+800=1623
    fprintf(h_elt,['	GENERE\n']);
    fprintf(h_elt,['.SAM\n']);
    fprintf(h_elt,['        MF 1\n']);
    fprintf(h_elt,['        NALG 4\n']);
end
%%
fprintf(h_elt,['\n']);

fprintf(h_elt,['.FIN 1\n']);
fprintf(h_elt,['RETURN']);
fclose(h_elt);

%% Send banque file to Samcef solver

if(Comupte_Samcef==1)
    if(strcmp(Compute_type,'Dynamic'))
        disp(' ');
        disp('SAMCEF calls the module DYNAM');
        evalc(['!samcef ba,dy ',samcef_file_name,' n 1 < ',samcef_file_name,'.dat'])% call to SAMCEF
        disp('DYNAM done.');
    elseif(strcmp(Compute_type,'Dynamic_Superelement'))
        disp(' ');
        disp('SAMCEF calls the module DYNAM');
        evalc(['!samcef ba,dy ',samcef_file_name,' n 1 < ',samcef_file_name,'.dat'])% call to SAMCEF
        disp('DYNAM done.');
        disp('SAMCEF calls Matrix (M/K) ');
        [Ms,Cs,Ks,Local,Nmode,Phi,Iselar]=samcef_read_win(samcef_file_name,'dynamic','yes');
        disp('Matrix (M/K) obtained.');
        save([samcef_file_name,'_superelement.mat'],'Ms','Cs','Ks','Local','Nmode','Phi','Iselar');
    end
end

if(Result_Samcef==0)
    disp('Task finished');
    return;
end