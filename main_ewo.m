%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MCTB - DMD Project
% Alex Mijailovic, Eddie Obropta, Whitney Young
% Fall 2014
%-------------------------------------------------------------------------%
% This code is a main that runs the non-linear analysis on the datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
% Plots Data
%% Load Data
% Use the following file structure
% MATLAB/dmd_project/
% --- code/
% --- data/

load('../data/subject_data.mat');

%% Subjects 
subject = [1 3 5];

% specify trial number 
% note: we want to actually average these at some point
trial = 1;

%% FIT ODGEN MODEL
% Loop Over Subjects
for i = 1:length(subject)
    % X-data - average trials
    
    lambda = d(subject(i)).lambda(2);
    X = lambda;
    X = mean(X')';
    % Y-data force
    Y = d(subject(i)).force(:,1);
    
    % intial guess
    beta0 = [1 -1];
    
    % non-linear regression
    beta = nlinfit(X,Y,@odgen,beta0);
    
    % calculate data
    y_data = odgen(beta,X);
    
    % plot data and fit
    figure
    d(3).plot(trial)
    hold on
    scatter(X,y_data,'r')
    legend('data','fit')
end



