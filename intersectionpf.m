function t=intersectionpf(v, c, lambda, s)
if(v>s*lambda)
    t=9999;
else if (v==0)
        v=0.1;
    end
    x=v./(s.*lambda);
    t=c.*(1-lambda).^2./2./(1-v/s)+x.^2./2./v./(1-x);
end
end