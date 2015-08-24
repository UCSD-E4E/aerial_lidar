%% Movie Test.
[yaw,pitch,roll] = quat2angle(imu_data);
z=[ones(10,10)];
[X,Y,Z] = peaks(10);
x = ones(10,1)*(1:10);
y = x.';
fid = figure;
%hold on
xlabel('x');
ylabel('y');
zlabel('z');
hsurface = plot(x,y);
%hsurface = surf(x, y, z) % Plot the surface
axis([0 100 0 10 -3 3]);
direction=[1 0 0];
rotate(hsurface,direction,roll(1));
%% Set up some function. 
% Sine between -2*pi and 2*pi.
%x = (10*-pi:0.1:10*pi)'; % Note the transpose.
%y = sin(x);

% The final plot.
%plot(x,y, '*');
 
%% Set up the movie.
writerObj = VideoWriter('out2.avi'); % Name it.
writerObj.FrameRate = 60; % How many frames per second.
open(writerObj); 
 
for i=2:10  
    % We just use pause but pretend you have some really complicated thing here...
    pause(0.1);
    figure(fid); % Makes sure you use your desired frame.
     clf
    %plot(x(i),y(i),'or');
    x = ones(10,1)*(10*(i-1):1:(10*i)-1);
    %hsurface = surf(x, y, z)
    hsurface = plot(x,y);
    rotate(hsurface,direction,(0));
    xlabel('x');
ylabel('y');
zlabel('z');
 
    %if mod(i,4)==0, % Uncomment to take 1 out of every 4 s.
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    %end
 
end
%hold off
close(writerObj); % Saves the movie.