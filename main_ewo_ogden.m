%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MCTB - DMD Project
% Alex Mijailovic, Eddie Obropta, Whitney Young
% Fall 2014
%-------------------------------------------------------------------------%
% This code is a main that runs the non-linear analysis on the datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all
% Plots Data
%% Load Data
% Use the following file structure
% MATLAB/dmd_project/
% --- code/
% --- data/

load('../data/subject_data.mat');

% Plot parameters
xlimits = [0.2 1.1];
font_size = 14;

%%% special case, these subject had lamda > 1
d(3).flag = 1;
d(5).flag = 1;
d(16).flag = 1;
d(24).flag = 1;




%% Process Data
% intitalize lists
lambda_control = [];
force_control = [];
lambda_dmd = [];
force_dmd = [];
% lists for different age populations
lambda_dmd_age1 = [];
force_dmd_age1 = [];
lambda_dmd_age2 = [];
force_dmd_age2 = [];
lambda_control_age1 = [];
force_control_age1 = [];
lambda_control_age2 = [];
force_control_age2 = [];
flag_count_control = 0;
flag_count_dmd = 0;

idx_dmd_count = 1;
idx_control_count = 1;

% Loop Over Subjects
for i = 1:length(d)
    % Calculate lambda
    lambda = d(i).lambda(2);
    X = lambda;
    Y = d(i).force;
    
   
    % do not include flagged data
    if d(i).flag ~= 1
        %% Fit Odgen Model to each person
        
        % use all data from each trial 
        X = X(:);
        Y = Y(:);
        
        % remove 0,0 data points that appears in some of the data
        X = X(Y>1);
        Y = Y(Y>1);
        
        % subtract 2 Newtons so force starts at 0
        Y = Y - 2;
        
        % intial guess for parameters
        beta0 = [1 -1];
        
        % non-linear regression
        beta = nlinfit(X,Y,@odgen,beta0);
        
        x_data = linspace(min(X),max(X),100);
        % calculate data
        y_data = odgen(beta,x_data);
        
        
        % plot data and fit
        if i == 1 || i==28
            figure
            scatter(X,Y,'*b')
            hold on
            plot(x_data,y_data,'-r')
            legend('data',['\mu=' num2str(beta(1)) ' \alpha=' num2str(beta(2))])
            
            title(['Odgen Model - Subject' num2str(i)])
            xlabel('\lambda')
            ylabel('Force (N)')
        end
        
        % store parameters
        if d(i).is_control == 1
            mu_control(idx_control_count) = beta(1);
            alpha_control(idx_control_count) = beta(2);
            age_control(idx_control_count) = d(i).age;
            idx_control_count = idx_control_count + 1;
        % store parameters of dmd patients
        else
            mu_dmd(idx_dmd_count) = beta(1);
            alpha_dmd(idx_dmd_count) = beta(2);
            age_dmd(idx_dmd_count) = d(i).age;
            idx_dmd_count = idx_dmd_count + 1;
        end
        
    else
        % Count number of flagged patients
        if d(i).is_control == 1
            flag_count_control = flag_count_control + 1;
        else
            flag_count_dmd = flag_count_dmd + 1;
        end
    
    end
  
%     X = mean(X')';
%     % Y-data force
%     Y = d(subject(i)).force(:,1);
%     
%     % intial guess
%     beta0 = [1 -1];
%     
%     % non-linear regression
%     beta = nlinfit(X,Y,@odgen,beta0);
%     
%     x_data = linspace(min(X),max(X),100);
%     % calculate data
%     y_data = odgen(beta,x_data);
%     
%     % plot data and fit
%     figure
%     scatter(X,Y,'*b')
%     hold on
%     plot(x_data,y_data,'-r')
%     legend('data',['\mu=' num2str(beta(1)) ' \alpha=' num2str(beta(2))])
%     
%     title(['Odgen Model - Subject' num2str(d(subject(i)).id)])
%     xlabel('\lambda')
%     ylabel('Force (N)')
    
end
% Total flag count
flag_count = flag_count_control + flag_count_dmd;

%% PLOTS
figure
subplot(2,1,1)
hold on
scatter(age_dmd,mu_dmd,'r')
scatter(age_control,mu_control,'b')
legend('DMD', 'Control')
ylabel('\mu (N)')
xlabel('Age (years)')

subplot(2,1,2)
hold on
scatter(age_dmd,alpha_dmd,'r')
scatter(age_control,alpha_control,'b')
legend('DMD', 'Control')
ylabel('\alpha')
xlabel('Age (years)')








