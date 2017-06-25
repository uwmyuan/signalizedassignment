function [link_flows, link_times,ue_obj] = uefw(links, movements, od_demand, iters)

[freeflowtraveltime, slope, c, lambda, s] = build_skeleton(links, movements);

%building cost matrix and capacity matrix
n = length(freeflowtraveltime);

%number of nodes
link_flows = zeros(n, n, iters + 1);
aux_flows = zeros(n, n, iters);
link_times = zeros(n, n, iters + 1);

link_times(:, :, 1) = update_link_times(freeflowtraveltime, slope,... 
    c, lambda, s, squeeze(link_flows(:, :, 1)));

for i = 1:iters
    aux_flows(:, :, i) = aon(link_times(:, :, i), od_demand);
    %addition link flow in i^th iteration
    if (i == 1)
        phi = 1;
        %UE objective function
        ue_obj=ueof(phi, squeeze(link_flows(:, :, i)), ...
            squeeze(aux_flows(:, :, i)), freeflowtraveltime, slope, c, lambda, s);
    else
        %linear search
        [phi, ue_obj] = ueof_line_search(squeeze(link_flows(:, :, i)), ...
            squeeze(aux_flows(:, :, i)), freeflowtraveltime, slope, c, lambda, s);
    end
    link_flows(:, :, i + 1) = link_flows(:, :, i) * (1 - phi) + ...
        aux_flows(:, :, i) * phi;
    link_times(:, :, i + 1) = ...
        update_link_times(freeflowtraveltime, slope, c, lambda, s, squeeze(link_flows(:, :, i + 1)));
end
end

