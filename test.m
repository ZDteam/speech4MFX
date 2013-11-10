function test( test_set,feature_mat )
%TEST Summary of this function goes here
%   Detailed explanation goes her

% dist_seg = [0,1000,1500,2500,4000,10000];
% score_seg = [100,90,80,60,30,0];
% seg_num = length(score_seg)-1;
% cof_abc = zeros(seg_num,3);
% for i=1:seg_num
%     
%     x1 = dist_seg(i);
%     x2 = dist_seg(i+1);
%     y1 = score_seg(i);
%     y2 = score_seg(i+1);
%     cof_abc(i,1) = (y2-y1)/((x2-x1)^2);
%     cof_abc(i,2) = -2*x1*cof_abc(i,1);
%     cof_abc(i,3) = y1+x1^2*cof_abc(i,1);
% end

dist_seg = [0,5000];%0,3000,500
score_seg = [100,10];
seg_num = length(score_seg)-1;
cof_k1 = -90/3000;
cof_k2 = -90/500;
cof_k3 = -90/5000;


fprintf('======================== testing =========================\n');
parfor p = 1:5
%     test_dir = [test_set,num2str(p),')/'];
    test_dir = [test_set,num2str(p),'/'];
    files = dir(test_dir);
    [n,~] = size(files);
    n = n-2;
    dists = zeros(n,1);
    final_score = 0;
    dist = zeros(3,1);
    dist_sum =zeros(3,1);
   
    seg_ps = zeros(seg_num,1);
    feature = cell(3,1);
    for i=1:n
        waveFile = [test_dir,num2str(i),'.wav'];
        [y,fs,nbits] = wavread(waveFile);
        %     fprintf('%d %d\n',fs,nbits);
        %     wavplay(y,fs);
        [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);

        [feature{1},feature{2},feature{3}] =  feature_extract(x,fs,zcr,shortEnergy);
        for j=1:3
            dist(j) = dtw(feature_mat{i,j},feature{j});
            dist(j) = dist(j)/size(feature_mat{i,j},1);
            dist_sum(j) = dist_sum(j)+dist(j);
        end
        if(dist(1)>3000)
            score1 = 0;
        else
            score1 = cof_k1*dist(1)+100;
        end
        
        if(dist(2)>500)
            score2 = 0;
        else
            score2 = cof_k2*dist(2)+100;
        end
        
        if(dist(3)>5000)
            score3 = 0;
        else
            score3 =cof_k3*dist(3)+100;
        end
        score = (score1+score2+score3)/3;
        final_score = final_score+score;
%         fprintf('%dth people %dth sentence score = %.2f\n',p,i,score);
%         fprintf('%dth sentence dist2 = %d\n',i,dist(2));
%         fprintf('%dth people %dth sentence score1 = %.2f score2 = %.2f score3= %.2f score =%.2f\n',p,i,score1,score2,score3,score)
%          dist = get_dist_direct(feature_mat{i},feature);
%         dist = dist/size(feature_mat{i},1);
%         fprintf('%dth people %dth sentence: dist= %f\n',p,i,dist);
%         dists(i) = dist;
%         for j=1:seg_num
%             if(dist_seg(j)<=dist && dist <dist_seg(j+1))
%                 seg_ps(j) = seg_ps(j)+1;
%                 score = dist^2*cof_abc(j,1)+dist*cof_abc(j,2)+cof_abc(j,3);
%                 final_score = final_score + score;
%             end
% %         end
%          if dist > dist_seg(2)
%              score = 0;
%          else
%             score = dist*cof_k+100;
%          end
%          fprintf('%dth people %dth sentence: score = %f dist=%f\n',p,i,score,dist);
%          dist_sum = dist_sum+dist;
    end

        fprintf('%dth people score = %.2f\n',p,final_score/n);

%     dist = dist_sum/n;
%       if dist > dist_seg(2)
%              final_score = 0;
%          else
%             final_score = dist*cof_k+100;
%          end
%     figure;
%     plot(dists,'.-');
% 
%     title([num2str(p),'th people']);
%     fprintf('%dthpeople avg dist = %.2f\n',p,dist);
%     fprintf('%dthpeople final score = %.2f\n',p,final_score);
%     fprintf('%dth people:\n');
%     for i=1:seg_num
%         fprintf('%d - %d:%d\n',dist_seg(i),dist_seg(i+1),seg_ps(i));
%     end
end
fprintf('======================== test end ========================\n');


end





