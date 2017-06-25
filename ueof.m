function ueof_val = ueof(phi, link_flows, aux_flows, freeflowtraveltime, slope, c, lambda, s)
ueof_val = 0;
n = length(link_flows);
for i = 1:n
    for j = 1:n
        if (9999>freeflowtraveltime(i, j) > 0)
            updated_flow = link_flows(i, j) * (1 - phi) + aux_flows(i, j) * phi;
            ueof_val = ueof_val + ...`
                integral(@(x)linearpf(x, freeflowtraveltime(i, j), slope(i, j)), 0, updated_flow); 
            %integral, a built-in function which performs numerical
            %integration of a function of a single variable over a nite
            %domain. i.e. integral(@(x)myfun2(x,5),lowerbound,upperbound)
        end
        if (c(i, j) > 0)
            updated_flow = link_flows(i, j) * (1 - phi) + aux_flows(i, j) * phi;
            ueof_val = ueof_val + ...
                integral(@(x)intersectionpf(x, c(i, j), lambda(i, j), s(i, j)), 0, updated_flow); 
        end
    end
end
end