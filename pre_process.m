function [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits, plot_opt )
if nargin == 4
    plot_opt = false;
end

%Ԥ����
y=filter([1 -0.9375],1,y);

%  frameTime ÿ֡��ʱ�� ��λms
frameTime = 15;
%�֎�
frameSize = floor(fs*frameTime/1000);
overLap = floor(frameSize/3);

x = enframe(y,frameSize,overLap);

%������
tmp1 = x(:,1:end-1);
tmp2 = x(:,2:end);
sign = tmp1.*tmp2 < 0 ;
diff = abs(tmp1-tmp2) > 0.02;
zcr = sum(sign.*diff,2);

%��ʱ����
shortEnergy = sum(abs(x), 2);
% shortEnergy = 10*log10( sum(x(:,1:end).^2,2)+realmin);

% %�˵���
[x1,x2] = vad2(x,zcr,shortEnergy);
% % for i=x1:x2
% %     if shortEnergy(i) == 0 
% %         fprintf('debuge:energy=0!');
% %     end
% % end


if(plot_opt == true)
    figure();
    frameNum = size(x,1);
    sampleTime = (1:length(y))/fs;
    frameTimes = ((0:frameNum-1)*(frameSize-overLap)+0.5*frameSize)/fs;
    s = (x1-1)*(frameSize-overLap);
    t = (x2)*(frameSize-overLap);
    subplot(3,1,1);
    plot(sampleTime,y);title(waveFile);
    line([s/fs,s/fs],[min(y)/2,max(y)*2],'Color','red');
    line([t/fs,t/fs],[min(y)/2,max(y)*2],'Color','red');
    
    subplot(3,1,2);
    plot(frameTimes, zcr, '.-');title('ZCR'); xlabel('Time (sec)');
    line([s/fs,s/fs],[min(zcr)/2,max(zcr)*2],'Color','red');
    line([t/fs,t/fs],[min(zcr)/2,max(zcr)*2],'Color','red');
    
    subplot(3,1,3);
    plot(frameTimes,shortEnergy,'.-');title('shortEnergy');xlabel('Time (sec)');
    line([s/fs,s/fs],[min(shortEnergy)/2,max(shortEnergy)*2],'Color','red');
    line([t/fs,t/fs],[min(shortEnergy)/2,max(shortEnergy)*2],'Color','red');
    
end


x = x(x1:x2,:);
zcr = zcr(x1:x2);
shortEnergy = shortEnergy(x1:x2);


end