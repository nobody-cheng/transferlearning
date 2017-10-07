%% Choose domains from Office+Caltech
%%% 'Caltech10', 'amazon', 'webcam', 'dslr' 
src = 'Caltech10';
tgt = 'amazon';

%% Load data
load(['data/' src '_SURF_L10.mat']);     % source domain
fts = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
Xs = zscore(fts,1);    clear fts
Ys = labels;           clear labels
Ps = pca(Xs);  % source subspace

load(['data/' tgt '_SURF_L10.mat']);     % target domain
fts = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
Xt = zscore(fts,1);     clear fts
Yt = labels;            clear labels
Pt = pca(Xt);  % target subspace

%% Set algorithm options
options.gamma = 1.0;
options.lambda = 0.1;
options.kernel_type = 'linear';
options.T = 10;
options.dim = 100;
options.mu = 0.5;
%% Run algorithm
[Acc,acc_ite,~] = MyBDA(Xs,Ys,Xt,Yt,options);
fprintf('Acc:%.2f',Acc);
