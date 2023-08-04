clc;clear all;close all;
data = readtable('Feature_matrix_all.xlsx');

% Extract features and labels
features = table2array(data(:, 2:end-1));
labels = categorical(table2array(data(:, end)));

% Split data into training and testing sets
cvp = cvpartition(labels, 'Holdout', 0.3);
Xtrain = features(training(cvp), :);
ytrain = labels(training(cvp));
Xtest = features(test(cvp), :);
ytest = labels(test(cvp));

% Train SVM classifier using RBF kernel
t = templateSVM('KernelFunction', 'rbf');
svmModel = fitcecoc(Xtrain, ytrain, 'Learners', t);
% Evaluate feature importance
imp = predictorImportance(svmModel);

% Sort features by importance
[sortedImp, sortedIdx] = sort(imp, 'descend');

% Display results
disp('Feature Importance Ranking:');
disp(data.Properties.VariableNames(sortedIdx));
