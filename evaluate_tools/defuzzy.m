function de_U = defuzzy(num,N,cluster)
num=num';
num_max=max(num);
de_U=zeros(cluster,N);
for i=1:size(num,1)
    for j=1:num_max
        if(num(i)==j)
          de_U(j,i)=1;
        end
    end
end