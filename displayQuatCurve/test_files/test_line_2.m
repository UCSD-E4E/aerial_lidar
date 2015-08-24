%lineLength = 10;
%angle = 50;
x(1) = 0;
y(1) = 1;
z(1) = 0;
z(2) = 1;
x(2) = 30;
y(2) = 1;
hold on;
xlabel('x');
ylabel('y');
zlabel('z');
H = plot(x,y);
%xlim([0 70]);
%ylim([0 70]);
grid on;
direction=[0 0 1];
rotate(H,direction,30)