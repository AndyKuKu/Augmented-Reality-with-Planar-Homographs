function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if (ndims(I1) == 3)
        I1 = rgb2gray(I1);
end

if (ndims(I2) == 3)
        I2 = rgb2gray(I2);
end
%% Detect features in both images
f1 = detectFASTFeatures(I1);
f2 = detectFASTFeatures(I2);
%f1 = detectSURFFeatures(I1);
%f2 = detectSURFFeatures(I2);
%% Obtain descriptors for the computed feature locations
[desc1, P1] = computeBrief(I1, f1.Location);
[desc2, P2] = computeBrief(I2, f2.Location);
%% Match features using the descriptors
% indexPairs = matchFeatures(desc1, desc2, 'MaxRatio', 0.65);
indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', 50, 'MaxRatio', 0.695);
locs1 = P1(indexPairs(:,1),:);
locs2 = P2(indexPairs(:,2),:);
figure;
showMatchedFeatures(I1, I2, locs1, locs2, 'montage');
end

