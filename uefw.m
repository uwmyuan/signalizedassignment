function [link_flows, link_times, ue_obj, iter] = uefw(links, movements, od_demand)

%building cost matrices and capacity matrix
[freeflowtraveltime, slope, c, lambda, s] = build_skeleton(links, movements);

%number of nodes
n = length(freeflowtraveltime);

iter=1;
phi=1;

max_iter=100;
min_iter=10;
%initializing link travel time
link_times = update_link_times(freeflowtraveltime, slope, c, lambda, s, zeros(n,n));

while(true)
    %addition link flow in iter^th iteration
    aux_flows=aon(link_times, od_demand);
    if(iter==1)
        link_flows = aux_flows* phi;
        %UE objective function
        ue_obj=ueof(phi, link_flows, aux_flows, freeflowtraveltime, slope, c, lambda, s);
    else
        %linear search
        [phi, ue_obj] = ueof_line_search(link_flows, aux_flows, freeflowtraveltime, slope, c, lambda, s);
    end
    last_link_flows=link_flows;
    link_flows = link_flows * (1 - phi) + aux_flows* phi;
    link_times = update_link_times(freeflowtraveltime, slope, c, lambda, s, link_flows);
    iter=iter+1;
    
    %stopping criteria
    if(iter>min_iter)
        %check flow constraint
        if(abs(sum(sum(last_link_flows-link_flows))/sum(sum(last_link_flows)))<0.01)
            %check capacity constraint
            m=length(c);
            flag=true;
            for i=1:m

                if (link_flows(movements(i, 1), movements(i, 2)) > movements(i, 4)*movements(i, 5))
                    flag=false;
                    break;
                end
            end
            
            if(flag)
                disp 'capacity condition'
                break;
            end
        end
    end
    
    %iteration limitation
    if(iter>max_iter)
        disp 'iteration condition'
        break;
    end
    
end

