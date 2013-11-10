function  [feature_mat,thresholds] = train(train_set)

files = dir(train_set);
[n,~] = size(files);
n = n-2;
fd_num = 3;
fprintf('======================== training ========================\n');
feature_mat = cell(n,fd_num);

for i =1:n
    waveFile = [train_set,num2str(i),'.wav'];
    [y,fs,nbits] = wavread(waveFile);

    [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
    [feature_mat{i,1},feature_mat{i,2},feature_mat{i,3}]= feature_extract(x,fs,zcr,shortEnergy);
    
end
fprintf('======================== trained successfully ============\n');
end

