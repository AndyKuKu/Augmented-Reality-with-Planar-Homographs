function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
c_5 = combnk(1:length(locs1), 10);
n_iterations = min(size(c_5, 1), 1000);
locs1_3d = locs1;
locs1_3d(:, 3) = 1;
bestH2to1 = -1;
inliers =  0;
for i=1: n_iterations
    locs1_s = locs1(c_5(i,:),:);
    locs2_s = locs2(c_5(i,:),:);
    h = computeH_norm(locs1_s, locs2_s);
    New_Points = h * locs1_3d';
    New_Points(1,:) = New_Points(1,:)./New_Points(3,:);
    New_Points(2,:) = New_Points(2,:)./New_Points(3,:);
    New_Points = New_Points';   
    New_Points = New_Points(:,1:2);
    Dist = (New_Points - locs2) .^ 2;
    Dist = Dist(:,1) + Dist(:,2);
    Dist = Dist < 1;
    in_lier = sum(Dist);
    if inliers <= in_lier
        bestH2to1 = h;
        inliers = in_lier;
    end
end
%Q2.2.3
end
