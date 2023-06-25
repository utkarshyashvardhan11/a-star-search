function [route,numExpanded] = Astarmap (input_map, start_coords, target_coords)
% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

o_map = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...
    0 1 0; ...
    1 1 0; ...
    0.5 0.5 0.5];

colormap(o_map);

[n_rows, n_cols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(n_rows,n_cols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and target nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
target_node  = sub2ind(size(map), target_coords(1),  target_coords(2));

map(start_node) = 5;
map(target_node)  = 6;

% meshgrid will `replicate grid vectors' nrows and ncols to produce
% a full grid
% type `help meshgrid' in the Matlab command prompt for more information
parent = zeros(n_rows,n_cols);

% 
[X, Y] = meshgrid (1:n_cols, 1:n_rows);

destX = target_coords(1);
destY = target_coords(2);

% Evaluate Heuristic function, H, for each grid cell
% Manhattan distance
H = abs(X - destX) + abs(Y - destY);
H = H';
% Initialize cost arrays
f = Inf(n_rows,n_cols);
g = Inf(n_rows,n_cols);

g(start_node) = 0;
f(start_node) = H(start_node);

% keep track of the number of nodes that are expanded
numExpanded = 0;

% Main Loop

while true
    
    % Draw current map
    map(start_node) = 5;
    map(target_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (true)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum f value
    [min_f, current] = min(f(:));
    
    if ((current == target_node) || isinf(min_f))
        break;
    end;
    
    % Update input_map
    map(current) = 3;
    f(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(f), current);
    
    % *********************************************************************
    % ALL YOUR CODE BETWEEN THESE LINES OF STARS
    % Visit all of the neighbors around the current node and update the entries in the map, f, g and parent arrays
    
    
    
    %Generating 4 successors of this cell
 
%                    N   
%                    |   
%                    |  
%              W----Cell----E
%                    | 
%                    |  
%                    S   
       
    
    % North cell
    
%     Only process this cell if this is a valid one
    if(i-1 >= 1 && i-1 <= n_rows && j >= 1 && j <= n_cols)
        
%         If the destination cell is the same as the current successor
        if([i-1, j] == target_coords)
            parent(start_node) = 0;
            parent(i-1, j) = current;
            fNew = (g(current)+1) + 0;
            f(i-1, j) = fNew;
            break;
            
%         If the successor is already on the closed list or if it is
%         blocked, then ignore it. Else do the following    
        elseif map(i-1, j) ~= 3 && map(i-1, j) ~= 2
                map(i-1, j) = 4;
                gNew = g(current)+1;
                fNew = gNew+H(i-1, j);
                
%                  If it isn’t on the open list, add it to
%                  the open list. Make the current square
%                  the parent of this square. Record the
%                  f, g, and h costs of the square cell
%                                 OR
%                  If it is on the open list already, check
%                  to see if this path to that square is
%                  better, using 'f' cost as the measure.

                if f(i-1, j) > fNew
                    f(i-1, j) = fNew;
                    g(i-1, j) = gNew;
                    parent(i-1, j) = current;
                end
        end
    end
    
    % South cell
    
%     Only process this cell if this is a valid one
    if(i+1 >= 1 && i+1 <= n_rows && j >= 1 && j <= n_cols)
        
%         If the destination cell is the same as the current successor        
        if([i+1, j] == target_coords)
            parent(start_node) = 0;
            parent(i+1, j) = current;
            fNew = (g(current)+1) + 0;
            f(i+1, j) = fNew;
            break;
            
%         If the successor is already on the closed list or if it is
%         blocked, then ignore it. Else do the following
        elseif map(i+1, j) ~= 3 && map(i+1, j) ~= 2
                map(i+1, j) = 4;
                gNew = g(current)+1;
                fNew = gNew+H(i+1, j);
                
%                  If it isn’t on the open list, add it to
%                  the open list. Make the current square
%                  the parent of this square. Record the
%                  f, g, and h costs of the square cell
%                                 OR
%                  If it is on the open list already, check
%                  to see if this path to that square is
%                  better, using 'f' cost as the measure.

                if f(i+1, j) > fNew
                    f(i+1, j) = fNew;
                    g(i+1, j) = gNew;
                    parent(i+1, j) = current;
                end
        end
    end
    
    % West cell
    
%     Only process this cell if this is a valid one
    if(i >= 1 && i <= n_rows && j-1 >= 1 && j-1 <= n_cols)
        
%         If the destination cell is the same as the current successor
        if([i, j-1] == target_coords)
            parent(start_node) = 0;
            parent(i, j-1) = current;
            fNew = (g(current)+1) + 0;
            f(i, j-1) = fNew;
            break;
            
%         If the successor is already on the closed list or if it is
%         blocked, then ignore it. Else do the following
        elseif map(i, j-1) ~= 3 && map(i, j-1) ~= 2
                map(i, j-1) = 4;
                gNew = g(current)+1;
                fNew = gNew+H(i, j-1);              
                
%                  If it isn’t on the open list, add it to
%                  the open list. Make the current square
%                  the parent of this square. Record the
%                  f, g, and h costs of the square cell
%                                 OR
%                  If it is on the open list already, check
%                  to see if this path to that square is
%                  better, using 'f' cost as the measure.
                if f(i, j-1) > fNew
                    f(i, j-1) = fNew;
                    g(i, j-1) = gNew;
                    parent(i, j-1) = current;
                end
         end
    end
    
    % East cell
    
%     Only process this cell if this is a valid one
    if(i >= 1 && i <= n_rows && j+1 >= 1 && j+1 <= n_cols)
        
%         If the destination cell is the same as the current successor        
        if([i, j+1] == target_coords)
            parent(start_node) = 0;
            parent(i, j+1) = current;
            fNew = (g(current)+1) + 0;
            f(i, j+1) = fNew;
            break;
            
%         If the successor is already on the closed list or if it is
%         blocked, then ignore it. Else do the following
        elseif map(i, j+1) ~= 3 && map(i, j+1) ~= 2
                map(i, j+1) = 4;
                gNew = g(current)+1;
                fNew = gNew+H(i, j+1);
                
%                  If it isn’t on the open list, add it to
%                  the open list. Make the current square
%                  the parent of this square. Record the
%                  f, g, and h costs of the square cell
%                                 OR
%                  If it is on the open list already, check
%                  to see if this path to that square is
%                  better, using 'f' cost as the measure.

                if f(i, j+1) > fNew
                    f(i, j+1) = fNew;
                    g(i, j+1) = gNew;
                    parent(i, j+1) = current;
                end
        end
    end
    
    % Update the number of nodes expanded
    numExpanded = numExpanded + 1;
    
    %*********************************************************************
    
end

%% Construct route from start to dest by following the parent links
if (isinf(f(target_node)))
    route = [];
else
    route = [target_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end

    % Snippet of code used to visualize the map and the path
    for q = 2:length(route) - 1        
        map(route(q)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end

end
