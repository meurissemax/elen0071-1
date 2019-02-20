%% Applied digital signal processing - Homework 1

% Question 3 - Echo cancellation
%
% University of Liege
% Academic year 2018-2019
%
% Authors:
%   - Quentin Graillet
%   - Maxime Meurisse
%   - Adrien Schoffeniels

%% Parameters

alpha = 0.6;

%% Variables

audiofile = 'hw1_echo.wav';

%% Autocorrelation

[x, fs] = audioread(audiofile);
[acorrX, lagX] = xcorr(x(:, 1), x(:, 1));

figure;
plot(lagX, acorrX);

%% Echo cancellation

d = 2.205e4; % value obtained by looking on the plot
tau = d/fs; % delay in seconds

b = 1;
a = [1, zeros(1, d-1), alpha];

y = filter(b, a, x);
sound(y, fs);
