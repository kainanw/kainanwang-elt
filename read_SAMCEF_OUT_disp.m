function [displ_nodes,indices_nodes]=read_SAMCEF_OUT(filename)

h1=fopen([filename '.out'],'r');
fgetl(h1);
fgetl(h1);
fgetl(h1);
A=fgetl(h1);
nb_nodes=sscanf(A,'%i',[1 1]);
fgetl(h1);

indices_nodes=zeros(nb_nodes,1);
displ_nodes=zeros(nb_nodes,1);
for tt=1:1:nb_nodes
    A=fgetl(h1);
    indices_nodes(tt)=sscanf(A,'%i',[1 1]);
end
for tt=1:1:nb_nodes
    A=fgetl(h1);
    displ_nodes(tt)=sscanf(A,'%g',[1 1]);
end
fclose(h1);

