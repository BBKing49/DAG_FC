function [cell_l,cell_s] = get_Lf(X)

view_num = size(X,2);

N = size(X{1},2);
e=7;
ker = struct('type','gauss','width',1); 

%��ʼ������S
cell_s = cell(view_num,1); 
for t = 1:view_num
    cell_s{t,1} = zeros(N,N); 
end

%��ʼ������D,L
cell_d = cell(view_num,1); 
cell_l = cell(view_num,1);
% tic;
%���ɾ���S��D
for t = 1:view_num
    acc_x = X{t}';
    acc_s = cell_s{t};
    for i = 1:N
        x_vec = acc_x(i,:);
        x_dist = x_vec(ones(N,1),:);
        x_dist = sqrt( sum( (x_dist - acc_x).^2, 2 ) );
        [x_sort,index] = sort(x_dist);
        for e_nearest = 1:e
            j = index(e_nearest,:);
            acc_s(i,j) = kernel(ker,acc_x(i,:)',acc_x(j,:)');
        end
    end
    acc_d = diag( sum( acc_s));
    acc_l = zeros(size(acc_d));
    acc_l = acc_d - acc_s;
    cell_s{t} = acc_s;
    cell_d{t} = acc_d;
    cell_l{t} = acc_l;
end