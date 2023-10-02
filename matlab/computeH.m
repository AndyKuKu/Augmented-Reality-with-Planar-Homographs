function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
 m = size(x1, 1);
    H = [];
    for i=1:m
        Point1_x = x1(i, 1);
        Point1_y = x1(i, 2);
        Point2_x = x2(i, 1); 
        Point2_y = x2(i, 2);
        Hx = [-Point1_x, -Point1_y, -1, 0, 0, 0, Point1_x*Point2_x, Point1_y*Point2_x, Point2_x];
        Hy = [0, 0, 0, -Point1_x, -Point1_y, -1, Point1_x*Point2_y, Point1_y*Point2_y, Point2_y];
        H = [H; [Hx; Hy]];
    end
    [~, S, V] = svd(H);
    [m, i] = min(diag(S));
    h_svd = V(:,  i);
    H2to1 = reshape(h_svd, [3, 3])';

end
