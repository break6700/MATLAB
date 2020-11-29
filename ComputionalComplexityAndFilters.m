%% Algorithm Testing Code
% The following code is designed to apply an adaptive algorithm and plot the 
% filtered signal, the error/difference between the original dry signal and the 
% wet convolved signal
%% 
% Audio files are imported and the data is stored as the signal and it's sample 
% rate. This is need to ensure the file is played back correctly.

clc
clear

[Convolved, ConvolvedFs] = audioread("Convolved.wav");
[Impulse, ImpulseFs] = audioread("RoomImpulse.wav");
[Dry, DryFs] = audioread('RecordingDry.wav');
%% Comparing Algorithms
% Despite both algorthims working in similar ways, the MATLAB system objects 
% have differing variables to modify. 
% 
% As a result the computational complexity and error factor is measured.
% 
% tic = starts system timer, toc = ends system timer

% LMS Filter Computational Complexity
% Make yourself something to drink
l = 0;
j = 0;
a = 0;
while l < 120
    %w = num2cell(l)
    j(length(a)+1) = l;
    l = (l+10);
    tic
    lms = dsp.LMSFilter('Length', l);
    [lmsFiltered, lmsError] = lms(Convolved, Dry); 
    toc
    y = toc;
    x(length(a)+1) = y;
end

% RLS Filter Computational Complexity
l = 0;
k = 0;
while l < 128
    %w = num2cell(l)
    k(length(a)+1) = l;
    l = (l+10);
    tic
    rls = dsp.RLSFilter('Length', l);
    [rlsFiltered,rlsError] = rls(Convolved, Dry);
    toc
    y = toc;
    h(length(a)+1) = y;
end
subplot(2,1,1)
plot(j,x)
grid
title('LMS Computational Complexity')
xlabel('Length of filter')
ylabel('Time (s)')
subplot(2,1,2)
title('RLS Computational Complexity')
ylim([0 20])
xlabel('Length of filter')
ylabel('Time (s)')
grid
%% Compute Convergence
% Plot the  error signals for both variations. The error signal for the NLMS 
% variant converges to zero much faster than the error signal for the LMS  variant. 
% The normalized version adapts in far fewer iterations to a  result almost as 
% good as the nonnormalized version.

lms = dsp.LMSFilter('Length',64);
[lmsFiltered, lmsError, wts] = lms(Convolved, Dry);

rls = dsp.RLSFilter('Length',64);
[rlsFiltered,rlsError] = rls(Convolved, Dry);

plot([lmsError,rlsError]);
title('Comparing the LMS and RLS Error');
legend('LMS', ...
       'RLS','Location', 'NorthEast');
xlabel('Time (s)')
ylabel('Amplitude')
% Plot the filtered signals

subplot(6,1,1)
plot(Impulse)
grid on
title('Impulse Response of Room')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
subplot(6,1,2)
plot(Dry)
grid on
title('Dry Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
subplot(6,1,3)
plot(Convolved)
grid on
title('Convolved Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid
subplot(6,1,4)
plot(lmsFiltered)
grid on
title('LMS Filtered Signal')
xlabel('Time (s)')
ylabel('Amplitude')
subplot(6,1,5)
plot(rlsFiltered)
grid on
title('RLS Filtered Signal')
xlabel('Time (s)')
subplot(6,1,6)
ylabel('Amplitude')
plot([lmsError,rlsError]);
title('Comparing the LMS and RLS Error');
legend('LMS', ...
       'RLS','Location', 'NorthEast');
xlabel('Time (s)')
ylabel('Amplitude')