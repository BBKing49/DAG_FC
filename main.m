clc;
clear;

addpath(genpath('./'));
datafiles = {'mul_ORL'};

for datafile = datafiles

    load(['data/' datafile{1} '.mat']);
    fprintf('Dataset:%s\t',datafile{1});


    nv=length(data); % view
    ns=length(unique(labels)); % k

    Xnor = cell(nv,1);
    for ni=1:nv
        Xnor{ni} = mapstd(data{ni}',0,1); 
    end
    % MSRC
%     numanchor = 5*ns;
%     alpha = 10.^1;
%     lan = 10.^3;
%     lambda = 10.^-5;
%     beta = 10.^-1;
    % ORL
    numanchor = 4*ns;
    alpha = 10.^3;
    lan = 10.^2;
    lambda = 10.^-5;
    beta = 10.^-2;

    [ids,best_ZS,best_ZC,best_sim_mat] = MVFCM_DAL(Xnor,alpha,numanchor, ns);

    options.lan=lan;
    options.lambda = lambda;
    options.beta = beta;
    options.cluster_n= ns;

    [ U,Z,alfa ] = expt_clustering(best_ZS,best_sim_mat,options,datafile{1});
    pred_labels = vec2lab(U');
    result_cluster = ClusteringMeasure(labels, pred_labels);
    nmi = result_cluster(2);
    acc= result_cluster(1);
    purity= result_cluster(3);
    ARI= result_cluster(4);


end