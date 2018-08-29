function [displ_nodes,indices_nodes]=read_SAMCEF_OUT(filename,type)

if (strcmp(type,'all_nodes_coordinate')
    h=fopen([filename '.out'],'r');
    fgetl(h);
    fgetl(h);
    fgetl(h);
    A=fgetl(h);
    nb_nodes=sscanf(A,'%i',[1 1]);
    fgetl(h);

    indices_nodes=zeros(nb_nodes,1);
    displ_nodes=zeros(nb_nodes,1);
    for tt=1:1:nb_nodes
        A=fgetl(h);
        indices_nodes(tt)=sscanf(A,'%i',[1 1]);
    end
    for tt=1:1:nb_nodes
        A=fgetl(h);
        displ_nodes(tt)=sscanf(A,'%g',[1 1]);
    end
    fclose(h);
else
end

