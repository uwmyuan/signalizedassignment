function [freeflowtraveltime, slope, c, lambda, s] = build_skeleton(links, movements)

n = max(max(max(links(:, 1:2))),max(max(movements(:, 1:2))));
freeflowtraveltime = zeros(n, n);
for i=1:n
    for j=1:n
        freeflowtraveltime(i,j)=9999;
    end
end

slope = zeros(n, n);
c = zeros(n, n);
lambda= zeros(n, n);
s= zeros(n, n);

%road links
for i = 1:length(links)
    freeflowtraveltime(links(i, 1), links(i, 2)) = links(i, 3);
    slope(links(i, 1), links(i, 2)) = links(i, 4);
end
for i = 1:n
    freeflowtraveltime(i, i) = 0;
end

%movements
for i = 1:length(movements)
    c(movements(i, 1), movements(i, 2)) = movements(i, 3);
    lambda(movements(i, 1), movements(i, 2)) = movements(i, 4);
    s(movements(i, 1), movements(i, 2)) = movements(i, 5);
end

end

