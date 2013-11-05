function [v] = feature_extract(x,fs,zcr,shortEnergy)
% v1 = get_det(zcr);
% v2 = get_det(shortEnergy);
% % v2 = get_det(shortEnergy);
v = mfcc(x,fs);
% disp(v);
end