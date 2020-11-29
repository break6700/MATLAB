% Filter

[Ping, PingFs] = audioread('Echoes_Ping.wav');

% Create Filter in **Filter** Designer and Export as Object: Hd
Filtered = filter(Hd, Ping);


% Show Plots
subplot(2,1,1)
plot(Ping);
grid
subplot(2,1,2)
plot(Filtered)
grid