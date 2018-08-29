function coord=draw_circle(R)


theta=[90:1:450-1];
theta=theta*pi/180;

x=[R.*cos(theta)]';
y=[R.*sin(theta)]';

coord=[x,y];

plot([x' x(1)],[y' y(1)],'-','LineWidth',0.5,'Color',[0,0,0]);
