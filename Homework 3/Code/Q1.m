%% Applied digital signal processing - Homework 3

% Question 1 - Noise filtering
%
% University of Liege
% Academic year 2018-2019
%
% Authors:
%   - Quentin Graillet
%   - Maxime Meurisse
%   - Adrien Schoffeniels

%% Load

load('hw3_noisy_signal.mat');

%% Data

Fs = 1000; % sampling period
Ts = 1 / Fs; % sampling interval
N = length(x); % length of the signal
Tmax = (N - 1) * Ts; % maximum time
t = 0:Ts:Tmax; % time vector

%% Subquestion a)

plot_range = ((N / 2 - 200):(N / 2 + 200));

figure
plot(t(plot_range), x(plot_range), 'LineWidth', 2);
hold on
plot(t(plot_range), x_ns(plot_range), 'LineWidth', 2);
axis tight
title('Signal x[n] and noisy signal x\_ns[n]');
legend('x[n]', 'x\_ns[n]');
grid on

%% Subquestion b)

X = fft(x_ns);
X2 = abs(X / N);
X1 = X2(1:N/2 + 1);
X1(2:end - 1) = 2 * X1(2:end - 1);

F = Fs * (0:(N / 2)) / N;

figure
plot(F, X1, 'LineWidth', 2);
title('Single-Sided Amplitude Spectrum of noisy signal x\_ns[n]');
xlabel('f (Hz)');
grid on

%% Subquestion c)

fr = find((X1 >= 0.1) & (X1 <= 0.4));

fprintf('Approximate frequency range of the noise v[n] : [%f - %f] Hz\n', F(fr(1)), F(fr(end)));

%% Subquestion e)

load('fir.mat');
fvtool(fir);

x_clean_FIR = filter(fir, x_ns);

X = fft(x_clean_FIR);
X2 = abs(X / N);
X1 = X2(1:N/2 + 1);
X1(2:end - 1) = 2 * X1(2:end - 1);
F = Fs * (0:(N / 2)) / N;

figure
plot(F, X1, 'LineWidth', 2);
title('Single-Sided Amplitude Spectrum of filtered signal x\_fil[n]');
xlabel('f (Hz)');
grid on

%% Subquestion f)

figure
plot(t(plot_range), x(plot_range), 'LineWidth', 2);
hold on
plot(t(plot_range), x_clean_FIR(plot_range), 'LineWidth', 2);
axis tight
title('Signal x[n] and filtered signal x\_fil[n]');
legend('x[n]', 'x\_fil[n]');
grid on

%% Cleaning workspace

clearvars
