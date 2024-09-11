function [dbi] = compute_dbi_singleview(label,data)
% compute dbi for single view data
% 2017-12-8
% PengXu, Jiangnan University
% label: n_examples * 1
% data: n_examples * n_features
index_label = unique(label);
for i=1:length(index_label)
    label(label==index_label(i)) = i;
end
M.label = label;
M.clusterSize = length(unique(label));
M.Samples = data;
dbi=DaviesBouldin(M); 
fprintf('dbi: %.4f\n', dbi);

end

