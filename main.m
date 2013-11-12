function main()

 close all;
% clc;
 open_multiple_thread();
% clear all;
 warning off

song_name = 'n';
train_dir = 'songs/n/origin/';
test_dir =  'songs/n/';

feature_mat = train(train_dir);

test(test_dir,feature_mat);



end

