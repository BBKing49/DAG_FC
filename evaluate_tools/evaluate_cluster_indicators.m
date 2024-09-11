function [cluster_indicators] = evaluate_cluster_indicators(true_label,predict_label)
% evaluate the different indicators for the results of clustering
% containing entropy, purity, nmi, ri, recall, precision, f_measure,fmi
% 2017-12-8
% PengXu, Jiangnan University
% predict_label: n * 1
% true_label: n * 1
% data: cell array of multi_view data containing different views'data
%       rows of each cell represents examples, cols for features. 

% externel indicators for clustering
U0 = label_vec2mat(true_label); % n_examples*n_clusters
U = label_vec2mat(predict_label); % n_examples*n_clusters
entropy = compute_entropy(U0',U');
purity = compute_purity(true_label,predict_label);
nmi = compute_nmi(true_label,predict_label);
[f_measure,recall,precision,ri,fmi] = compute_matching_matrix(U0', U');
fprintf('entropy: %.4f\tpurity: %.4f\tnmi: %.4f\tri: %.4f\n',entropy,purity,nmi,ri);
 fprintf('recall: %.4f\tprecision: %.4f\tf_measure: %.4f\tfmi: %.4f\n',...
     recall,precision,f_measure,fmi);

cluster_indicators = [entropy,purity,nmi,ri,recall,precision,f_measure,fmi];
end

