%% Applied digital signal processing - Homework 2

% Question 1 - Noise elimination
%
% University of Liege
% Academic year 2018-2019
%
% Authors:
%   - Quentin Graillet
%   - Maxime Meurisse
%   - Adrien Schoffeniels

%% Figure properties

gca_fs = 12;
axis_fs = 12;
title_fs = 14;

%% Data

addpath('filters/')
load('hw2_electrocardiogram.mat', 'ecg')
Fs = 250; % sampling frequency

t_min = 2;
t_max = 5;

%% Subquestion a)

Ts = 1 / Fs; % sampling period
N = length(ecg);
Tmax = (N - 1) * Ts;
t = 0:Ts:Tmax; % time vector

figure
plot(t, ecg)
set(gca, 'FontSize', gca_fs)
xlabel('Time (s)', 'FontSize', axis_fs)
ylabel('Amplitude', 'FontSize', axis_fs)
title('ECG with noise', 'FontSize', title_fs)
grid on

%% Subquestion b)

figure
plot(t, ecg, 'LineWidth', 1.5)
set(gca, 'FontSize', gca_fs)
xlim([t_min t_max])
xlabel('Time (s)', 'FontSize', axis_fs)
ylabel('Amplitude', 'FontSize', axis_fs)
title('ECG with noise (zoom)', 'FontSize', title_fs)
grid on

%% Subquestion c)

ECG = fft(ecg); % Fast Fourier Transform
ECG2 = abs(ECG / N); % take abs and scale it
ECG1 = ECG2(1:(N / 2) + 1); % pick the first half
ECG1(2:end - 1) = 2 * ECG1(2:end - 1); % multiply by 2 (except on DC part) to compensate the removed side from the spectrum
F = Fs * (0:(N / 2)) / N; % frequency range

figure
plot(F, ECG1, 'LineWidth', 2)
set(gca, 'FontSize', gca_fs)
xlabel('f (Hz)', 'FontSize', axis_fs)
title('Single-Sided Amplitude Spectrum', 'FontSize', title_fs)
grid on

%% Subquestion e)

load('filters/filter60.mat', 'filter60')
load('filters/filter120.mat', 'filter120')

pure_ecg = ecg;
pure_ecg = filter(filter60, pure_ecg);
pure_ecg = filter(filter120, pure_ecg);

figure
plot(t(500:(length(t) / 6)), ecg(500:(length(t) / 6)))
set(gca, 'FontSize', gca_fs)
xlim([t_min t_max])
xlabel('Time (s)', 'FontSize', axis_fs)
ylabel('Amplitude', 'FontSize', axis_fs)
title('Noisy and without noise ECG', 'FontSize', title_fs)
hold on
plot(t(500:(length(t) / 6)), pure_ecg(500:(length(t) / 6)), 'LineWidth', 2)
legend('Noisy', 'Without noise')
grid on

%% Filter analysis

fvtool(filter60)
fvtool(filter120)
