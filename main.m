function main()

 close all;
% clc;
%  open_multiple_thread();
% clear all;
warning off

song_name = 'n';
test_people = 5;

train_dir = ['songs/',song_name,'/origin/'];
test_dir =  ['songs/',song_name,'/'];

feature_mat = train(train_dir);

test(test_dir,test_people,feature_mat);



end

