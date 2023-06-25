% TestScript

% small map
map = false(10);

% obstacle

% map (1, 1) = true;
% map (2, 2) = true;
% map (3, 3) = true;
% map (4, 4) = true;
% map (5, 5) = true;
% map (6, 6) = true;
% map (7, 7) = true;
% map (8, 8) = true;
map (6, 6) = true;
map (6, 7) = true;
map (6, 8) = true;
map (7, 8) = true;
map (8, 8) = true;
% map (8, 7) = true;
map (8, 6) = true;
map (8, 5) = true;
map (7, 5) = true;
%    map(2:8, 6) = true;
% map(4, 9) = true;

start_coords = [2, 1];
target_coords  = [7, 7];

close all;

[route, numExpanded] = Astarmap(map, start_coords, target_coords)