function delta = build_delta(back_nodes)
n = length(back_nodes);
delta = zeros(n, n, n, n);
for i = 1:n
    for j = 1:n
        last = i;
        while ~isnan(back_nodes(last, j))
            delta(i, j, last, back_nodes(last, j)) = 1;
            last = back_nodes(last, j);
        end
    end
end
end