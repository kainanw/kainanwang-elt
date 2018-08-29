function [ID,Length]=truss_length(Element_ii,Element_struc,Node_struc)

ID=Element_struc(Element_ii).ID;
Node_ID1=Element_struc(Element_ii).Node(1);
Node_ID2=Element_struc(Element_ii).Node(2);

for ii=1:length(Node_struc)
    if(Node_struc(ii).ID==Node_ID1)
        Coordx1=Node_struc(ii).Coord(1);
        Coordy1=Node_struc(ii).Coord(2);
        Coordz1=Node_struc(ii).Coord(3);
    elseif(Node_struc(ii).ID==Node_ID2)
        Coordx2=Node_struc(ii).Coord(1);
        Coordy2=Node_struc(ii).Coord(2);
        Coordz2=Node_struc(ii).Coord(3);
    end
end

Length=sqrt((Coordx1-Coordx2)^2+(Coordy1-Coordy2)^2+(Coordz1-Coordz2)^2);
