function hfig=plot_signals(EEG,f)
%     Plot signals
% 
%  How to use:
%   hfig=plot_signals(EEG,f)
% 
%  Inputs: 
%    - EEG    = matrix with signals
%    - f      = sampling frequency 
% 
%  Outpus:  
%    - hfig   = figure handle
% 

switch nargin
    case 0
        disp('Missing input arguments.')
        return;
    case 1
        f=1;
end

if size(EEG,1)>size(EEG,2) 
   EEG=EEG'; % assuming the number of samples is larger than the number of signals (i.e. 'channels')
end
n_ch = size(EEG,1);
n_sp = size(EEG,2);
labels=cell(n_ch,1);
for i=1:n_ch
    labels{i,1}=num2str(i);
end

time=(1:n_sp)/f;

mi = zeros(n_ch,1); % min(EEG,[],2);
ma = 2*ones(n_ch,1); % max(EEG,[],2);
shift = cumsum([0; abs(ma(1:end-1))+abs(mi(2:end))]);
shift = repmat(shift,1,n_sp);

hfig=figure; 
plot(time,EEG+shift,'k')
set(gca,'ytick',mean(EEG+shift,2),'yticklabel',labels,'fontsize',15)
ylim([mi(1),max(max(shift+EEG))])
xlim([time(1),time(end)])


