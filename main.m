function main()

 close all;
% clc;
 open_multiple_thread();
% clear all;
% WARNING('OFF')

%  train_dir = 'ģ����ʵ�����/ʮ��/ԭ������/';
%  test_dir =  'ģ����ʵ�����/ʮ��/ʮ�� (';
train_dir = 'ģ����ʵ�����/nn/ԭ������/';
test_dir =  'ģ����ʵ�����/nn/';

feature_mat = train(train_dir);

test(test_dir,feature_mat);



end

