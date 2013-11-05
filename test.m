function test( test_set,feature_mat )
%TEST Summary of this function goes here
%   Detailed explanation goes her

dist_seg = [0,5000,10000,20000,1000000];
score_seg = [100,90,70,50,0];
seg_num = length(score_seg)-1;
cof_abc = zeros(seg_num,3);
for i=1:seg_num
    
    x1 = dist_seg(i);
    x2 = dist_seg(i+1);
    y1 = score_seg(i);
    y2 = score_seg(i+1);
    cof_abc(i,1) = (y2-y1)/((x2-x1)^2);
    cof_abc(i,2) = -2*x1*cof_abc(i,1);
    cof_abc(i,3) = y1+x1^2*cof_abc(i,1);
end
fprintf('======================== testing =========================\n');
parfor p = 1:5
    test_dir = [test_set,'∫Û¿¥ (',num2str(p),')/'];
    files = dir(test_dir);
    [n,~] = size(files);
    n = n-2;
    %     dists = zeros(n,1);
    final_score = 0;
    dist_sum = 0;
    fenmu = n*(seg_num-1);
    for i=1:n
        waveFile = [test_dir,num2str(i),'.wav'];
        [y,fs,nbits] = wavread(waveFile);
        %         fprintf('%d %d\n',fs,nbits);
        %     wavplay(y,fs);
        [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
        feature =  feature_extract(x,fs,zcr,shortEnergy);
        dist = dtw(feature_mat{i},feature);
        %         dists(i) = dist;
        for j=1:seg_num
             if(dist_seg(j)<=dist && dist <dist_seg(j+1))
               score = dist^2*cof_abc(j,1)+dist*cof_abc(j,2)+cof_abc(j,3);
               final_score = final_score + score*(seg_num-j)/fenmu;
             end
        end
        %         fprintf('%dthpeople %dth sentence: score = %f dist=%f\n',p,i,score,dist);
    end
    
    fprintf('%dthpeople final score = %.2f\n',p,final_score);
end
fprintf('======================== test end ========================\n');

%     figure, plot(dists,'.-'),title([num2str(p),'th people']);
end





