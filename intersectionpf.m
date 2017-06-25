function t=intersectionpf(v, c, lambda, s)
v=max(v,1);
x=v./(s.*lambda);
t=c.*(1-lambda).^2./2./(1-v/s)+x.^2./2./v./(1-x);
end