function main(song_name)

 close all;
% clc;
%  open_multiple_thread();
% clear all;
warning off

if nargin<1
    song_name = 'beiyiwangdeshiguang';

end

fprintf('song_name: %s\n',song_name);
train_dir = ['songs/',song_name,'/origin/'];
if ~isdir(train_dir)
    fprintf('train_set does not exit!\n');
    return;
end
test_dir =  ['songs/',song_name,'/test/'];
if ~isdir(test_dir)
    fprintf('test_set does not exit!\n');
    return;
end
feature_mat = train(train_dir);

test(test_dir,feature_mat);



end

