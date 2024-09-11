function [FMeasure, Recall, Precision, RI, FMI] = compute_matching_matrix(U0, U)
% 根据U0和U，计算FMeasure, Recall, Precision, RI, FMI的值
% U0为参考划分矩阵。
% U0和U均为cxn矩阵
% ref:
% 1. Michele Ceccarelli, Antonio Maratea. Improving fuzzy clustering of
% biological data by metric learning with side information. 
% 2. Jesse Davis, Mark Goadrich. The Relationship Between Precision-Recall
% and ROC Curves
% last modified: 2009.7.6 18:54:00

[cluster_n0, data_n0] = size(U0);
[cluster_n, data_n] = size(U);

if (data_n0~=data_n)
    fprintf('FMeasure: 两矩阵大小不同\n');
    FMeasure = 0;
    return;
end

if cluster_n < cluster_n0
    zeroM = zeros(cluster_n0-cluster_n, data_n);
    U = [U; zeroM];
else
    if cluster_n > cluster_n0
        zeroM = zeros(cluster_n-cluster_n0, data_n);
        U0 = [U0; zeroM];
    end
end

mask = triu(ones(data_n0, data_n0))-eye(data_n0);
% 计算Mr
M0 = (U0'*U0).*mask;
% 计算M
M = (U'*U).*mask;
% 计算TP,FP,FN,TN


TP = sum(sum(M0 & M));
FN = sum(sum(M0 > M));
FP = sum(sum(M0 < M));
TN = sum(sum(1-M0 & 1-M))-(data_n0+1)*data_n0/2;

Recall = TP/(TP+FN);
Precision = TP/(TP+FP);
FMeasure = 2*Recall*Precision/(Recall+Precision);
RI = (TP+TN)/(TP+TN+FP+FN);
FMI = sqrt((TP/(TP+FP))*(TP/(TP+FN)));
