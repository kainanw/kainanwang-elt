function [sys_mec,freqs,modes]=Mirror_system(Mirror)

DM5=Mirror.Diameter;
m=Mirror.Mass;
R=Mirror.Actuator_R;
ka=Mirror.Actuator_K;
damping_ratio=Mirror.Damping;

%% System general setting

s=tf('s');

Ix=0.25*m*DM5^2/4;
Iy=0.25*m*DM5^2/4;

zeta=damping_ratio*ones(3,1);

%% Matrix

% Inertia matrix
M=[m,0,0;0,Ix,0;0,0,Iy];

% Stiffness matrix
K=[3*ka,0,0;0,1.5*ka*R^2,0;0,0,1.5*ka*R^2];

[freqs,modes]=natural_frequencies(M,K,3);
omega=2*pi*freqs;

% State space model (mec)
A_sys_mec=[zeros(3,3),eye(3);-diag(omega)*diag(omega),-2*diag(zeta)*diag(omega)];
B_sys_mec=[zeros(3,3);modes'];
C_sys_mec=[modes,zeros(3,3)];
D_sys_mec=zeros(3,3);
sys_mec=ss(A_sys_mec,B_sys_mec,C_sys_mec,D_sys_mec);

