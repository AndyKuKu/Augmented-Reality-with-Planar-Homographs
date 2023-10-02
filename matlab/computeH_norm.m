function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
X1_c = x1 - centroid1;
X2_c = x2 - centroid2; 
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
X1_c2 = X1_c.^2;
X2_c2 = X2_c.^2;
B_1 = sqrt(2) / (sum(sqrt(X1_c2(:,1) + X1_c2(:,2)))/(length(x1)));
B_2 = sqrt(2) / (sum(sqrt(X2_c2(:,1) + X2_c2(:,2)))/(length(x2)));
X1_Norm = X1_c * B_1;
X2_Norm = X2_c * B_2;
%% similarity transform 1
T1 = computeH(x1, X1_Norm);
%% similarity transform 2
T2 = computeH(x2, X2_Norm);
%% Compute Homography
H = computeH(X1_Norm, X2_Norm);
%% Denormalization
H2to1 = T1 \ (H * T2);
