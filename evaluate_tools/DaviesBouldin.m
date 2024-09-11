function [DB] = DaviesBouldin(M)
%Davies-Bouldin指标
for i=1:M.clusterSize
cluster{1,i}=M.Samples(find(M.label==i),:);    
end
w=[];%均值
s=[];%散度
for i=1:M.clusterSize
    if size(cluster{1,i},1)>1
        wtemp=mean(cluster{1,i});
    else
        wtemp=cluster{1,i};
    end
    w=[w;wtemp];
    stemp=0;
    for j=1:size(cluster{1,i},1)
        stemp=stemp+sum((cluster{1,i}(j,:)-wtemp).^2);
    end
    stemp=stemp/size(cluster{1,i},1);
    stemp=sqrt(stemp);
    s=[s,stemp];
end

for i=1:M.clusterSize
    for j=1:M.clusterSize
        if(i~=j)
          DB(i,j)=(s(1,i)+s(1,j))/sqrt(sum((w(i,:)-w(j,:)).^2));
        else
           DB(i,j)=0; 
        end
    end
end
DB=max(DB);
DB=sum(DB)/M.clusterSize;
