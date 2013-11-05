function main()

%  close all;
% clc;
 open_multiple_thread();
% clear all;
% WARNING('OFF')

train_dir = '模仿秀实验歌曲/后来/原唱干声/';
test_dir =  '模仿秀实验歌曲/后来/';



feature_mat = train(train_dir);

test(test_dir,feature_mat);



end

