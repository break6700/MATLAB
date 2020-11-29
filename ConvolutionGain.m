%% Gain and Conv
% Importing Data and Etiquette
% Audio files are imported and the data is stored as the signal and it's sample 
% rate. This is need to ensure the file is played back correctly.
% 
% It is good ettiqutte to clear all previous variables and consolse commands.

% Good Code Etiquette
clc
clear

[Impulse, ImpulseFs] = audioread("RoomImpulse.wav");
[Dry, DryFs] = audioread('RecordingDry.wav');
%% 
% If required the audio is re-sampled using the resample command. For this testing 
% it is not required.

% example = resample(example, signal_fs, example_fs);
% example_fs = signal_fs;
%% 
% Both the impulse response and the dry signal and played (sound) and plotted.

% Impulse response of Room
subplot(3,1,1)
plot(Impulse)
title('Impulse Response')
xlabel('Time (s)')
ylabel('Amplitude')
grid

% Dry Signal
sound(Dry, DryFs)
subplot(3,1,2)
plot(Dry)
title('Dry Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid
pause(3)
% Gain Reduction and Convolution
% To ensure the convolved signal does not distort, the 'MaxPowerGain' of the 
% dry signal is set by -12 dB. The dry signal and the impulse response are then 
% convolved together using the 'conv' function. This is played and plotted.

% Automatic Gain Reduction
agc = comm.AGC('MaxPowerGain', -12);
Dry = agc(Dry);
% Convolution
Convolved = conv(Dry(:,1), Impulse);
ConvolvedFs = DryFs;
sound(Convolved,ConvolvedFs);
pause(3);
plot(Convolved);
audiowrite('convolved.wav',Convolved,ConvolvedFs);