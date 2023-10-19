 load ch2.mat
load states.mat
fs=1250;
frequenc_filter=[9 16];
state=zeros(length(ch2),1);
s_nrem=round((states.nrem)*fs);
s_rem=round((states.rem)*fs);
s_wake=round((states.wake)*fs);
for i=1:size(states.nrem,1)
    state(s_nrem(i,1): s_nrem(i,2))=3;
end
for i=1:size(states.rem,1)
    state(s_rem(i,1): s_rem(i,2))=2;
end
for i=1:size(states.wake,1)
    state(s_wake(i,1): s_wake(i,2))=1;
end
ch2(state == 0)=[];
state(state == 0)=[];

ch2=ch2.';
f_ch2 = eegfilt(ch2, fs, 0.5, 300, 0, fix(fs/0.5)*3, 0, 'fir1');
ch2 = zscore(f_ch2);

time=(1:length(ch2))/fs;
nrem_data=ch2(state==3);
nrem_time=time(state==3);

nrem_onset=time(find(diff(state==3)==1)+1);
rem_ind=find(diff(state==2)==1)+1;
rem_time=time(rem_ind);
wake_ind=find(diff(state==1)==1)+1;
wake_time=time(wake_ind);
f_data = eegfilt(nrem_data, fs, frequenc_filter(1), frequenc_filter(2), 0, fix(fs/frequenc_filter(1))*3, 0, 'fir1');
filtered=[nrem_time.' f_data.'];
spindles2=FindSpindles(filtered,'threshold',3,'durations',[500 3000]);
%%
figure
plot(time, ch2, 'k');
hold on
plot(nrem_time, f_data + 5, 'b');
for i = 1:length(spindles2)
    plot([spindles2(i,1) spindles2(i,3)], [6 6], 'r');
    plot(spindles2(i,2), 6,'*r');
    xlabel('TIME (s)')
    yticks([0 5 6])
yticklabels(["AD" "filtered [9 16] HZ" "spindle"])
    g=gca;
    g.FontSize=14;
    
end
%%
figure('Name','Raw data and filtered data')
subplot(2,1,1);
plot(nrem_time,nrem_data,'linewidth',2)
xlim([0 10]);
xlabel('time(s)')
ylabel('data')
g=gca;
g.FontSize=14;
subplot(2,1,2);
plot(nrem_time,f_data,'linewidth',2)
xlim([0 10]);
xlabel('time(s)')
ylabel('data')
g=gca;
g.FontSize=14;
figure
plot(time,state,'linewidth',2)
hold on
plot(spindles2(:,2),ones(length(spindles2(:,2)),1)*4,'*k')
xlabel('time(s)')
yticks([1 2 3 4])
yticklabels(["WAKE" "REM" "NREM" "Peak spindle"])
ylim([-1 7])
g=gca;
g.FontSize=14;
rate_N2R=zeros(1,length(rem_time));
rate_N2R(1)=(sum(spindles2(:,2)<rem_time(1))/rem_time(1))*60;
for i=2:size(rem_time.',1)
    N2R=sum(spindles2(:,2)<rem_time(i) & spindles2(:,2)>rem_time(i-1));
    start=nrem_onset(nrem_onset>rem_time(i-1) & nrem_onset<rem_time(i));
    stop=rem_time(i);
    duration=stop-start;
    rate_N2R(i)=(N2R/duration)*60;
end
ave_N2R=(sum(rate_N2R))/25;
N2W=sum(spindles2(:,2)<wake_time(1) & spindles2(:,2)<nrem_onset(10));
duration2=wake_time(1);
rate_N2W=(N2W/duration2)*60;
%% 25
rate_twenty_five = zeros(size(rem_time));

for j=1:size(rem_time.',1)
twenty_five=sum(spindles2(:,2)>rem_time(j)-25 & spindles2(:,2)<rem_time(j));
rate_twenty_five(j)=(twenty_five/25)*60;
end
ave_twenty_five=mean(rate_twenty_five);

%%
strength = [rate_N2R,rate_N2W,rate_twenty_five];
alloy = {'N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2R','N2W','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25','25'};
[p,~,stats]=anova1(strength,alloy);
g=gca;
g.FontSize=14;
%%
X = categorical({'N2R'});
X = reordercats(X,{'N2R'});
Y = (ave_N2R);
figure
A1=bar(X,Y,0.25,'r');
hold on
for i=1:25 
    plot(X,rate_N2R(1,i),'*g')
end
hold on
X = categorical({'N2W'});
X = reordercats(X,{'N2W'});
Y = (rate_N2W);
A2=bar(X,Y,0.25,'b');
hold on
plot(X,rate_N2W,'*g')
hold on
X = categorical({'25'});
X = reordercats(X,{'25'});
Y = (ave_twenty_five);
A3=bar(X,Y,0.25,'k');
hold on
for j=1:25
plot(X,rate_twenty_five(1,j),'*g')
end
ylabel('Spindle rate /min')
g=gca;
g.FontSize=14;
title('spindle rate during N2R&N2W')
legend([A1 A2 A3],{'N2R','N2W','25'},'Location','north')





