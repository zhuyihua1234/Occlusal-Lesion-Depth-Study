function d = distance(p1, p2)
% Calculates the Euclidean distance between two 3D points
% p1: Nx3 matrix of points
% p2: Nx3 matrix of points (or a single 1x3 point)
% d: Nx1 vector of distances

if size(p2,1) == 1
    p2 = repmat(p2, size(p1,1), 1);
end

d = sqrt(sum((p1 - p2).^2, 2));