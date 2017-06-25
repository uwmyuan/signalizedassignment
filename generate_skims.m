function [skims, back_nodes] = generate_skims(traveltime)
n = length(traveltime);
back_nodes = zeros(n, n);
skims = zeros(n, n);
visited = zeros(n, n);
for i = 1:n
    [skims(:, i), back_nodes(:, i), visited(:, i)] = dijkstra(traveltime, i);
end
%skims = skims';
end