function [ Q ] = guidedF2d( P, I, r, e )

P = padding(P, r);
I = padding(I, r);
[pRow, pCol] = size(P);
Q = zeros(pRow, pCol);

% Compute coefficients for each area w
a = zeros(pRow, pCol);
b = zeros(pRow, pCol);

for i = r+1 : pRow-r
	for j = r+1 : pCol-r
		wP = P(i-r:i+r, j-r:j+r);
		wI = I(i-r:i+r, j-r:j+r);
		mP = mean2(wP);
		mI = mean2(wI);
		vI = std2(wI)^2;
		a(i, j) = (mean2(wI.*wP) - mI*mP) / (vI+e);
		b(i, j) = mP - a(i, j) * mI;
	end
end

% Compute output Image
for i = r+1 : pRow-r
	for j = r+1 : pCol-r
		ma = mean2(a(i-r:i+r, j-r:j+r));
		mb = mean2(b(i-r:i+r, j-r:j+r));
		Q(i-r:i+r, j-r:j+r) = ma .* I(i-r:i+r, j-r:j+r) + mb;
	end
end

Q = rePadding(Q, r);

end

