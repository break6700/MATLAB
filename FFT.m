%% FFT
%% Setup

clear
clc
Filename = 'Sine.wav';
%% Signal Data Extraction

Signal_Info = audioinfo(Filename); % Pulls the metadata around the audio file
[Signal, Signal_fs] = audioread(Filename); % Pulls the sample value data and the sample rate of the audio file
Total_Sample_No = Signal_Info.TotalSamples; % Pulls the the total lenght of the file in samples from the metadata
%% Window Setup
% Always use Hann

N = Total_Sample_No; % Total samples in file
n = 1000; % Window Length
W = hann(n); % Window Type
%% Look at Windowed Data

Transform_Signal = W.*Signal(1:n); % Creates the windowed data
plot(Signal(1:n))
hold on
plot(Transform_Signal)
hold off
%% FFT

Signal_fft = fft(Transform_Signal);
P2 = abs(Signal_fft/N);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
%% Establishing Frequency Domain

f = Signal_fs*(0:(N/2))/N;
plot(f(1:n/2+1),P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')