%% Movie Test.
[yaw,pitch,roll] = quat2angle(imucamp);
rolldeg = radtodeg(roll);
x(1) = 0;
y(1) = 1;
x(2) = 30;
y(2) = 1;
fid = figure;
xlabel('x');
ylabel('y');
H = plot(x,y);
grid on;
direction=[0 0 1];
rotate(H,direction,rolldeg(1));
axis([0 10 -3 3]);

%% Set up the movie.
writerObj = VideoWriter('orientation_video_2.avi'); % Name it.
writerObj.FrameRate = 10; % How many frames per second.
open(writerObj); 
 
for i=2:430 
    pause(0.1);
    figure(fid); % Makes sure you use your desired frame.     
    H = plot(x,y);
    grid on;
    rotate(H,direction,rolldeg(i));
    axis([0 10 -3 3]);
    xlabel('x');
    ylabel('y');
    %if mod(i,4)==0, % Uncomment to take 1 out of every 4 s.
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    %end
 
end
hold off
close(writerObj); % Saves the movie.