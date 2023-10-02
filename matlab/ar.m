% Q3.3.1
clear all; clc;

%% read movie and images
Book_Target = '../data/book.mov';
AR_source = '../data/ar_source.mov';
source_mov = loadVid(AR_source);
m = size(source_mov, 2);
Target_mov = loadVid(Book_Target);
n = size(Target_mov, 2);
cv_img = imread('../data/cv_cover.jpg');

%% match feature
[h, w] = size(cv_img);
[ht, wt, ch] = size(Target_mov(1).cdata);
output = zeros(ht, wt, ch, n);
for i = 1: n-m
    output(:, :, :, i) = Target_mov(i).cdata; 
end

for i = n-m+1: n
    Temp_t = Target_mov(i).cdata;
    [locs1, locs2] = matchPics(cv_img, Temp_t);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    Temp_s = source_mov(i+m-n).cdata;
    Temp_s_resize = imresize(Temp_s, [h w]);
    im = compositeH(inv(bestH2to1), Temp_s_resize, Temp_t);
    output(:, :, :, i) = im;
end