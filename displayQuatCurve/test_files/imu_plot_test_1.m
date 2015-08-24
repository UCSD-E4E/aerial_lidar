% 
 r=[ones(1,744);1:1:744;ones(1,744)];
% %figure(1)
% %plot3(rx,ry,rz)
% r_t = r.';
% figure(1)
% displayQuatCurve(gps_data,imu_data)
% title('GPS + IMU')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% n = quatrotate(imu_data,r_t);
% figure(2)
% plot3(gpsx,gpsy,gpsz)
% title('just GPS')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% figure(3)
% plot3(nx,ny,nz)
% title('quaternion rotation')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% figure(4)
% plot3(imux,imuy,imuz)
% title('just IMU mag')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% figure(5)
% l = quatrotate(imu_data,gps_data);
% plot3(lx,ly,lz)
% title('quaternion rotation on GPS')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% 
% figure(6)
% displayQuatCurve(r_t,imu_data)
% title('IMU on line')
% xlabel('x');
% ylabel('y');
% zlabel('z');
[yaw,pitch,roll] = quat2angle(imu_data);

[x] = [-10:1:10;-1:.1:1]; % Generate x and y data
r=[-10:1:10;ones(1,21);ones(1,21)];
%figure(2)
%plot3(rx,ry,rz)
r_t = r.';
%n = quatrotate(imutest,r_t);
%figure(1)
%plot3(nx,ny,nz)
%z = ones(size(21, 1)); % Generate z data
figure(7)
hsurface = surf(X, Y, Z) % Plot the surface
xlabel('x');
ylabel('y');
zlabel('z');
direction=[1 0 0];
rotate(hsurface,direction,25);


