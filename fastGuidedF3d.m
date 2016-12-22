function [ Q ] = fastGuidedF3d( P, I, r, e, s )

Q(:, :, 1) = fastGuidedF2d(P(:, :, 1), I(:, :, 1), r, e, s);
Q(:, :, 2) = fastGuidedF2d(P(:, :, 2), I(:, :, 2), r, e, s);
Q(:, :, 3) = fastGuidedF2d(P(:, :, 3), I(:, :, 3), r, e, s);

end

