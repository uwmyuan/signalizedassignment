function new_link_times = update_link_times(freeflowtraveltime, slope, c, lambda, s, link_flow)
n = length(freeflowtraveltime);
new_link_times = freeflowtraveltime;
for i = 1:n
    for j = 1:n
        if (freeflowtraveltime(i, j) > 0)
            new_link_times(i, j) = linearpf(link_flow(i, j), freeflowtraveltime(i, j), slope(i, j)); 
        end
        if (c(i, j) > 0)
            new_link_times(i, j) = intersectionpf(link_flow(i, j), c(i, j), lambda(i, j), s(i, j)); 
        end
    end
end
for i = 1:n
    new_link_times(i, i) = 0;
end
end