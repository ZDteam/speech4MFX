function [v] = feature_extract(x,fs,zcr,shortEnergy)
    
      v1 =unify( get_det(zcr),0,100);
%     v2 = get_det(shortEnergy);
%     v2 =unify( shortEnergy );
%      v2 = v2(3:size(shortEnergy,1)-2);
    v2 = unify(get_det(shortEnergy),0,100);
    v3 = mfcc(x,fs,shortEnergy);
    v4 = unify(zcr(3:size(zcr,1)-2),0,100);
%     v5 = unify(shortEnergy(3:size(shortEnergy,1)-2));
    for i = 1:size(v3,1)
        v3(i,:) = unify(v3(i,:),0,80);
    end
% disp(v);
    v = [v3 v2 v4];
%     v = v3;
end