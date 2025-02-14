function [b_hat] = receive(r,plot_flag)
% [b_hat] = receive(r,plot_flag)
% Receiver program for part 1 of the project. The program should produce the
% received information bits given the samples of the received signal (sampled 
% at fs Hz.)
%
% Input:
%   r = samples of the received signal
%   plot_flag = flag for plotting [0: don't plot, 1: plot] 
%
% Output:
%   b_hat = vector containing the received information bits
%
% Rev. C (VT 2016)

%********** Begin program EDIT HERE
M=4; % PAM 2 or 4
Ns=151; % Kolla med lägre Ns
pulse = ones(Ns,1);

%1. filter with Rx filter (Matched filter)
MF = conj(fliplr(pulse)); % Specify Rx filter here (vector)

y = filter(MF,1,r);       % Here the received signal r is passed through the matched filter to obtain y 
E = conv(pulse,pulse);     % Energy
%2. Sample filter output

%choose what phase (1-4) which gives maximum y
y_sampled = y(Ns:Ns:end)/E(Ns);             % Compute the sampled signal y_sampled
y(Ns)
y(Ns*2)
E(Ns);


%3. Make decision on which symbol was transmitted
          % Specify decision boundaries for minimum distance detection (vector)
a_hat=[];
for i=1:length(y_sampled)
    if M == 4
%         boundaries = [-6 0 6];
        boundaries = [-2 0 2];
        if y_sampled(i)<boundaries(1)
            a=0;
        
        elseif y_sampled(i)>boundaries(1) && y_sampled(i)<boundaries(2)
            a=1;
        elseif y_sampled(i)>boundaries(2) && y_sampled(i)<boundaries(3)
            a=3;
        elseif y_sampled(i)>boundaries(3)
            a=2;
        end
    elseif M == 2
        boundaries=0;
        if y_sampled(i) >boundaries
            a=1;
        else
            a=0;
        end
    end    
    a_hat(end+1) = a;
end
                 % Compute the received symbols (in vector a_hat) from  
                        % the sampled signal, based on your decision
                        % boundaries
%4. Convert symbols to bits
b_hat = []; 
for i = 1:length(a_hat)
    b_hat = [b_hat, dec2bin(a_hat(i),M/2)];

end            % Convert the symbols in vector a_hat to bits in vector b_hat

b_hat=num2str(b_hat)-'0';
%********** DON'T EDIT FROM HERE ON
% plot Rx signals
PlotSignals(plot_flag, 'Rx', r, y, y_sampled)
%********** End program