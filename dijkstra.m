function [distances, previous, visited] = dijkstra(graph, s)
n = length(graph);
distances = ones(n, 1)*9999;
previous = nan(n, 1);
visited = zeros(n, 1);
c = s;
distances(s) = 0;
while ~all(visited)
    visited(c) = 1;
    for j = 1:n
        if distances(c) + graph(c, j) < distances(j)
            distances(j) = distances(c) + graph(c, j);
            previous(j) = c;
        end
    end
    nv = nan;
    for j = 1:n
        if (visited(j) == 0)
            if isnan(nv)
                nv = j;
            end
            if distances(j) <= distances(nv)
                nv = j;
            end
        end
    end
    c = nv;
end
previous(s)=nan;
end