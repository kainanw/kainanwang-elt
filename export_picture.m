function []=export_picture(picture_name)
% saveas(gcf,picture_name,'m');
saveas(gcf,[picture_name,'.tif']);
% saveas(gcf,[picture_name,'.png']);
% saveas(gcf,[picture_name,'.eps'],'psc2');