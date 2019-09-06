% This program simulates searching in 2d plane by random walk
% INPUTS:
%   alpha: motivation factor, acts as probability to continue search, coin
%          flipped every time before movement
%   Xm, Ym: location of male at the begining, make sure Xm^2 + Ym^2 < 5, arena is 5*unit
%            size
%   Xf, Yf : location of female, make sure Xf^2 + Yf^2 < 5, arena is unit
%            size
%   Rf: area of stopping searching, again, make sure < 5
%   delta: size of movement each step, again, please be < 5
%   theta: range of change in orientation
%   T: maximum time step of simulation
%   thrshld: maximum time before give up
% OUTPUTS:
%   x, y: time series of location, 
%   isfound:  1 is found, 0 not found, 2 is not found and give up
%   time_found: time it takes to found female, if not found, then it's T.
%
% @ Yuru Song, Aug-25-2019, UCSD
function [x, y, isfound, latency] = random_walk_searching_2d_finite_space(alpha, Xm, Ym, Xf, Yf, Rf, delta, theta, T, thrshld)
x = [Xm];
y = [Ym];
isfound = 0;
latency = T;
counter = 0;
for t = 1: T
    %select proper position for the next time step
    direc = theta * rand();
    x_tmp = x(end) + delta * cos(direc);
    y_tmp = y(end) + delta * sin(direc);
    while x_tmp^2 + y_tmp^2 > 5^2
%         disp('out of arena!');
        direc = 2* pi * rand();
        x_tmp = x(end) + delta * cos(direc);
        y_tmp = y(end) + delta * sin(direc);
    end
    %see if motivated
    x = [x, x_tmp];
    y = [y, y_tmp];
    if rand() > alpha(t)
        counter = counter + 1;
    else
        counter = 0;
    end
    %see if bumps into female
    if (x(end) - Xf)^2 + (y(end) - Yf)^2 < Rf^2
        latency = t;
        isfound = 1;
        disp('found!');
        break;
    end
    %see if gives up
    if counter > thrshld
        latency = t;
        isfound = 2;
        disp('give up!');
        break;
    end
end
end
