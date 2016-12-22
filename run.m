P = imread('src');

% Set coefficients as input
P = im2double(P);
I = P;
r = 16;
e = 0.1^2;
s = 4;

Q1 = guidedF3d(P, I, r, e);
Q2 = fastGuidedF3d(P, I, r, e, s);
Q1 = (P-Q1) + P;
Q2 = (P-Q2) + P;

Q1 = im2uint8(Q1);
Q2 = im2uint8(Q2);
P = im2uint8(P);

subplot(131)
imshow(P);
subplot(132)
imshow(Q1);
subplot(133)
imshow(Q2);

