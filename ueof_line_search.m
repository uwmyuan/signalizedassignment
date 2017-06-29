function [phi, ueof_val] = ueof_line_search(link_flows, aux_flows, freeflowtraveltime, slope, c, lambda, s)
interval = 0.1;
tol = 1e-3;
a = 0;
b = 1;
while (interval > tol)
    x = a:interval:(b - interval);
    ueof_vals = zeros(1, 10);
    for i = 1:10
        ueof_vals(i) = ueof(x(i) + interval / 2, link_flows, aux_flows, freeflowtraveltime, slope, c, lambda, s);
    end
    [min_ueof, i] = min(ueof_vals);
    a = x(i);
    b = x(i) + interval;
    interval = interval / 10;
end
phi = (a + b) / 2;
ueof_val = ueof(phi, link_flows, aux_flows, freeflowtraveltime, slope, c, lambda, s);
end