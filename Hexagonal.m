function [mi_hex,Dim]=Hexagonal(Geo_Parameter)

% Diameter of Primary mirror and the inner diamter of the central hole
Outer_diameter=Geo_Parameter.Outer_diameter;
Inner_diameter=Geo_Parameter.Inner_diameter;

% Number of the radial order [/]
Nb_R=Geo_Parameter.Nb_R;

% Width of the gap [m]
W_gap=0;

% Diameter of the circumcircle of the hexagonal region [m]
D_Hex_cc_region=Outer_diameter*2/sqrt(3);

% Diameter of the inscribed circle of the micro-hexagonal [m]
D_Hex_ic_micro=(D_Hex_cc_region/(2*Nb_R-2)-W_gap)/2;
D_Hex_cc_micro=D_Hex_ic_micro*2/sqrt(3);

%
Ra_inner=ceil(Inner_diameter/D_Hex_ic_micro/4);

% Define the structure mi_hex_temp(ii,jj)
% ii: the id of the radial order
% jj: the id of the electrode on each crown

% Central point coordinate of the micro-hexagonal

% Central electrode
mi_hex_temp(1,1).center_x=0;
mi_hex_temp(1,1).center_y=0;

% Corner electrodes
for ii=2:Nb_R+1
    for jj=1:(ii-1):6*ii
        if ii==2
            mi_hex_temp(ii,jj).center_x=(ii-1)*(2*D_Hex_ic_micro+W_gap)*cos((jj-1)*60*pi/180);
            mi_hex_temp(ii,jj).center_y=(ii-1)*(2*D_Hex_ic_micro+W_gap)*sin((jj-1)*60*pi/180);
        else
            mi_hex_temp(ii,jj).center_x=(ii-1)*(2*D_Hex_ic_micro+W_gap)*cos(floor(jj/(ii-1))*60*pi/180);
            mi_hex_temp(ii,jj).center_y=(ii-1)*(2*D_Hex_ic_micro+W_gap)*sin(floor(jj/(ii-1))*60*pi/180);
        end
    end
end

% Middle electrode between corner electrodes  
for ii=3:Nb_R+1
    for jj=1:1:6 % section index
        for mm=(ii-1)*(jj-1)+2:(ii-1)*(jj-1)+ii-1
            mm_start=(ii-1)*(jj-1)+1;
            mm_end=(ii-1)*(jj-1)+ii;
            if mm_end>6*ii
                mm_end=1;
            end
            mi_hex_temp(ii,mm).center_x=mi_hex_temp(ii,mm_start).center_x+(mm-(ii-1)*(jj-1)-1)/(ii-1)*(mi_hex_temp(ii,mm_end).center_x-mi_hex_temp(ii,mm_start).center_x);
            mi_hex_temp(ii,mm).center_y=mi_hex_temp(ii,mm_start).center_y+(mm-(ii-1)*(jj-1)-1)/(ii-1)*(mi_hex_temp(ii,mm_end).center_y-mi_hex_temp(ii,mm_start).center_y);
        end
    end
end

mi_hex_geo=mi_hex_temp;

% Change the type of the structure
% Define the structure mi_hex(ii)
% ii: the id of the electrode

mi_hex(1).id=1;
mi_hex(1).center_x=mi_hex_temp(1,1).center_x;
mi_hex(1).center_y=mi_hex_temp(1,1).center_y;
mi_hex(1).center_z=0;
mi_hex(1).ra=1;
mi_hex(1).az=1;
mi_hex(1).radius=0;
mi_hex(1).location=0;

id_micro=2;
for ii=1:Nb_R+1
    for jj=1:6*(ii-1)
        mi_hex(id_micro).id=id_micro;
        mi_hex(id_micro).center_x=mi_hex_temp(ii,jj).center_x;
        mi_hex(id_micro).center_y=mi_hex_temp(ii,jj).center_y;
        mi_hex(id_micro).center_z=0;
        mi_hex(id_micro).ra=ii;
        mi_hex(id_micro).az=jj;
        mi_hex(id_micro).radius=sqrt(mi_hex(id_micro).center_x^2+mi_hex(id_micro).center_y^2);
        if(mi_hex(id_micro).radius<=Inner_diameter/2)
            mi_hex(id_micro).location=0;
        else
            if(mi_hex(id_micro).radius<=Outer_diameter/2)
                mi_hex(id_micro).location=1;
            else
                mi_hex(id_micro).location=2;
            end
        end
        id_micro=id_micro+1;
    end
end

clear id_micro mi_hex_temp

% Corner point coordinate of the micro-hexagonal
for ii=1:length(mi_hex)
    for jj=1:6
        mi_hex(ii).point_x(jj)=mi_hex(ii).center_x+D_Hex_cc_micro*cos((60*jj-30)*pi/180);
        mi_hex(ii).point_y(jj)=mi_hex(ii).center_y+D_Hex_cc_micro*sin((60*jj-30)*pi/180);
    end
end


Dim.D_Hex_ic_micro=D_Hex_ic_micro;
Dim.D_Hex_cc_region=D_Hex_cc_region;
Dim.D_Hex_cc_micro=D_Hex_cc_micro;
Dim.Ra_inner=Ra_inner;
