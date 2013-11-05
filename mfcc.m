function ccc = mfcc(x,fs)

[nf,frameSize] = size(x);

% ��һ��mel�˲�����ϵ��
filter_num = 24; %�����˲�������
coef_num = 12; %����
bank=melbankm(filter_num,frameSize,fs,0,0.5,'m');
% bank=full(bank);
% bank=bank/max(bank(:));

% DCTϵ��,coef_num*filter_num;
for k=1:coef_num
  n=1:filter_num;
  dctcoef(k,:)=cos((n-0.5)*k*pi/(filter_num));
end

% ��һ��������������
w = 1 + 6 * sin(pi * [1:coef_num] ./ coef_num);
w = w/max(w);

% % Ԥ�����˲���
% xx=double(x);
% xx=filter([1 -0.9375],1,xx);

% % �����źŷ�֡
% [x1,x2]= vad(xx);
% xx=enframe(xx,256,80);

% ����ÿ֡��MFCC����

for i=1:nf
  y = x(i,:);
  s = y' .* hamming(frameSize);
  t = abs(fft(s));
  t = t.^2;
  c1=dctcoef * log(bank * t(1:1+floor(frameSize/2)));
  c2 = c1.*w';
  m(i,:)=c2';
end

%���ϵ��
dtm = zeros(size(m));
for i=3:size(m,1)-2
%     if(i==size(m,1)-2)
% %         disp(m(i+1,:));
% %         disp(m(i+2,:));
%     end
    dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
end
dtm = dtm / 3;
%���ϵ���Ĳ��
% dtm2 = zeros(size(dtm));
% for i=3:size(dtm,1)-2
%   dtm2(i,:) = -2*dtm(i-2,:) - dtm(i-1,:) + dtm(i+1,:) + 2*dtm(i+2,:);
% end
% dtm2 = dtm2 / 3;
%�ϲ�mfcc������һ�ײ��mfcc����
ccc = [m dtm];
%ȥ����β��֡����Ϊ����֡��һ�ײ�ֲ���Ϊ0
ccc = ccc(3:size(m,1)-2,:);

