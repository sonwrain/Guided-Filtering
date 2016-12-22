function [ Q ] = fastGuidedF2d( P, I, r, e, s )

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
		sumP = 0; sumI = 0; count = 0;
        k = 1; l = 1;
		while k <= 2*r+1
			while l <= 2*r+1
				sumP = sumP + wP(k, l);
				sumI = sumI + wI(k, l);
				count = count + 1;
                k = k + s;
                l = l + s;
			end
		end
		mP = sumP / count;
		mI = sumI / count;
		sumV = 0;
        k = 1; l = 1;
		while k <= 2*r+1
			while l <= 2*r+1
				sumV = sumV + (I(k, l) - mI)^2;
                k = k + s;
                l = l + s;
			end
		end
		vI = sumV / count;
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

