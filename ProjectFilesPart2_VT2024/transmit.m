function s = transmit(b,plot_flag)
% s = transmit(b,plot_flag)
% Transmitter program for part 1 of the project. The program should produce samples
% of the transmitted signal. The sample rate is fs Hz.
%
% Input:
%   b = vector containing the information bits to be transmitted
%   plot_flag = flag for plotting [0: don't plot, 1: plot]  
%
% Output:
%   s = vector containing samples of the transmitted signal at rate of fs Hz
%
% Rev. C (VT 2016)

%********** Begin program, EDIT HERE

% Complete the code below to create samples of the transmitted signal.

%1. Convert bits to symbols

M = 4; % PAM 2 or 4
% Specify constellation here (vector)
constellation = [-3 ,-1 ,1, 3];

a = []; % Convert the bits in vector b to symbols in vector a
index=[];
for i = 1:(log2(M)):length(b)
    k = bin2dec(num2str(b(i:i+(log2(M)-1))))+1;
    
    if k == 4
        k = 3;
    elseif k==3
        k=4;
    end

    index(end + 1) = k;
end
a=constellation(index);

%2. Pulse Amplitude Modulation
Ns = 151;                    % Specify the length of the transmit pulse here (scalar)
%pulse = rcosdesign(0.5,Ns,1); % Specify the transmit pulse here (vector)
pulse =ones(1,Ns);
s = [];                     % Perform PAM. The resulting transmit signal is the vector s.
for n = 1:length(index)
    s = [s, pulse.*a(n)];
end

%********** DON'T EDIT FROM HERE ON
% plot Tx signals
PlotSignals(plot_flag, 'Tx', a, s)
%********** End program