clear
clc
%input data 
load('intersection_network1800');

%case 1 
od_demand(21,10)=1000;
%case 2
od_demand(9,22)=1000;
%case 3
od_demand(3,16)=1000;
od_demand(15,4)=1000;

od=sparse(od_demand)

%parameters
max_iter=90;

%flow assignment main procedure
tic
[link_flows, link_times, obj, iter] = uefw(links, movements, od_demand);
toc

%output flow
iter
sparse(link_flows)
obj

