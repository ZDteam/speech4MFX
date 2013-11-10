function [v1,v2,v3] = feature_extract(x,fs,zcr,shortEnergy)
    
    v1 = get_det(zcr);
%     v2 = get_det(shortEnergy);
    v2 = shortEnergy;
    v3 = mfcc(x,fs,shortEnergy);
% disp(v);

end