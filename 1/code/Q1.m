%% Applied digital signal processing - Homework 1

% Question 1 - Magnitude response of a filter
%
% University of Liege
% Academic year 2018-2019
%
% Authors:
%   - Quentin Graillet
%   - Maxime Meurisse
%   - Adrien Schoffeniels

%% Parameters

K = 8;
r = 0.9;
b_0 = 5.3936*1e-7;
w = linspace(-pi, pi, 500);

%% Magnitude responses

% Subquestion a)
magn_resp(pi/3, K, r, b_0, w);

% Subquestion b)
magn_resp((2*pi)/3, K, r, b_0, w);

%% Function
function H = magn_resp(w_0, K, r, b_0, w)

b = b_0^(1/K);
a = [1, -2*r*cos(w_0), r^2];

H = freqz(b, a, w);

% Plot
figure;
plot(w/pi, K*10*log10(abs(H)));

end
