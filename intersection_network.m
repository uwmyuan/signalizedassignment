clear
clc
%input data 
load('intersection_network');

%case 1 
%od_demand(21,10)=1800;
%case 2
od_demand(9,22)=1800;
%case 3
od_demand(3,16)=1800;
od_demand(15,4)=1800;

od=sparse(od_demand)

%parameters
max_iter=5;

%flow assignment main procedure
tic
[link_flows, link_times, obj] = uefw(links, movements, od_demand, max_iter);
toc

%output flow
link_flow=sparse(squeeze(link_flows(:,:,max_iter)))
obj

