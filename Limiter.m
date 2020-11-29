%% Setup
clear
clc
Filename = 'Trumpet.wav';
Threshold = 0.2;
%% Signal Data Extraction
[Signal, Signal_fs] = audioread(Filename);
%% Initial Signal Playback & Plot
plot(Signal)
sound(Signal , Signal_fs, 24)
%% Limitter
% dRL = limiter('SampleRate', Signal_fs, 'Threshold', 0.1);
% Limited_Signal = dRL(Signal);
Limited_Signal = Signal;
Limited_Signal(Limited_Signal>Threshold) = Threshold;
Limited_Signal(Limited_Signal<(Threshold)*-1) = Threshold*-1;
%% Limited Signal Playback & Plot
hold on
plot(Limited_Signal)
grid
sound(Limited_Signal, Signal_fs,24)