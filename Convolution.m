%% Setup

clear
clc
Impulse_File = "RoomImpulse1.wav";
Signal_File = "RecordingDry.wav";
%% Audio Read

[rev, rev_fs] = audioread(Impulse_File);
[Signal, Signal_fs] = audioread(Signal_File);
%% Audio Setup

rev = resample(rev, Signal_fs, rev_fs);
rev_fs = Signal_fs;
%rev = rev(426269:532472);
%% Sound Audio Signals

sound(rev, rev_fs);
pause(length(rev)/rev_fs);

sound(Signal, Signal_fs);
pause(length(Signal)/Signal_fs);
%% Plot Signals

figure(1);
plot(rev);
figure(2);
plot(Signal);
%% Convolution

WetSound = conv(Signal(:,1), rev);
sound(WetSound,Signal_fs);
pause(length(WetSound)/Signal_fs);
plot(WetSound);