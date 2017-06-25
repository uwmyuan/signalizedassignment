function link_flows = aon(traveltime, od_demand)
[~, back_nodes] = generate_skims(traveltime);
delta = build_delta(back_nodes);
n = length(traveltime);
link_flows = zeros(n, n);
p = length(od_demand);
for i = 1:p
    for j = 1:p
        for k = 1:n
            for m = 1:n
                if (delta(j, i, m, k) == 1)
                    link_flows(k, m) = link_flows(k, m) + od_demand(i, j);
                end
            end
        end
    end
end
link_flows(traveltime == 9999) = 0;
end