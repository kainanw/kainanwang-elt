function [freqs,modes]=natural_frequencies(M,K,reserve_order)
%% Compute the natural frequencies and mode shapes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inputs:
% M:mass matrix (kg)
% K:stiffness matrix (kg/m)
% reserve_order: The modal order which is needed to reserved

% Outputs:
% freqs: natural frequencies (Hz)
% modes: mode shape matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[V,D]=eig(K,M);

omega_square=zeros(size(D,1),1);
for i=1:size(D,1)
    omega_square(i)=D(i,i);
end
[omega_square_seq,index]=sort(omega_square);
V=V(:,index);
D=diag([omega_square_seq]);

V=V(:,1:reserve_order);
D=D(1:reserve_order,1:reserve_order);


freqs=zeros(reserve_order,1);
for i=1:length(D)
    freqs(i)=sqrt(D(i,i))/2/pi;
end

modes=V;

end