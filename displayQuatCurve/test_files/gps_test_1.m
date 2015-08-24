y = -10:1:10; % Generate x and y data
x = -1:.1:1;
z=[ones(25,25)];
[X,Y,Z] = peaks(25);
%plot3(x, y, z) % Plot the surface
xlabel('x');
ylabel('y');
zlabel('z');
hsurface = surf(X, z, Y) % Plot the surface
xlabel('x');
ylabel('y');
zlabel('z');
axis([-10 10 -10 10 -10 10]);
direction=[1 0 0];
rotate(hsurface,direction,10);