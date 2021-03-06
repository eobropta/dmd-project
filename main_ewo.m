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

% age group ranges
% lower bounds
age1 = [0 7];
% upper bounds
age2 = [7 100];

% Loop Over Subjects
for i = 1:length(d)
    % Calculate lambda
    lambda = d(i).lambda(2);
    X = lambda;
    Y = d(i).force;
    
   
    % do not include flagged data
    if d(i).flag ~= 1
        if sum(X(:)>1.1)
            disp('Flag');
            
        end
        %% RAW Control and DMD Data
        % seperate control from dmd patients
        if d(i).is_control == 1
            lambda_control = [lambda_control; X(:)];
            force_control = [force_control; Y(:)];
            % age 1 group
            if (d(i).age > age1(1) && d(i).age <= age1(2))
                lambda_control_age1 = [lambda_control_age1; X(:)];
                force_control_age1 = [force_control_age1; Y(:)];
            % age 2 group
            elseif (d(i).age > age2(1) && d(i).age <= age2(2))
                lambda_control_age2 = [lambda_control_age2; X(:)];
                force_control_age2 = [force_control_age2; Y(:)];
            end
        else
            lambda_dmd = [lambda_dmd; X(:)];
            force_dmd= [force_dmd; Y(:)];
            % age 1 group
            if (d(i).age > age1(1) && d(i).age <= age1(2))
                lambda_dmd_age1 = [lambda_dmd_age1; X(:)];
                force_dmd_age1 = [force_dmd_age1; Y(:)];
            % age 2 group
            elseif (d(i).age > age2(1) && d(i).age <= age2(2))
                lambda_dmd_age2 = [lambda_dmd_age2; X(:)];
                force_dmd_age2 = [force_dmd_age2; Y(:)];
            end
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
% control and dmd raw data
figure
scatter(lambda_control,force_control,'b')
hold on
scatter(lambda_dmd,force_dmd,'r')

xlabel('\lambda -  Stretch Ratio')
ylabel('Force (N)')
set(gca,'FontSize',font_size,'fontWeight','bold')
set(findall(gcf,'type','text'),'fontSize',font_size,'fontWeight','bold')
% save plot
%print(gcf,'-djpeg','-r300',plot_name_prin)

% control and dmd data split by age groups
figure
hold on
scatter(lambda_control_age1,force_control_age1,'c')
scatter(lambda_control_age2,force_control_age2,'b')
xlabel('\lambda -  Stretch Ratio')
ylabel('Force (N)')
xlim(xlimits)
legend('Control: Age 0-7','Control: Age 7-20','DMD: Age 0-7','DMD: Age 7-20')
set(gca,'FontSize',font_size,'fontWeight','bold')
set(findall(gcf,'type','text'),'fontSize',font_size,'fontWeight','bold')
title('Control Patients Age Groups')

figure 
hold on
scatter(lambda_dmd_age1,force_dmd_age1,'m')
scatter(lambda_dmd_age2,force_dmd_age2,'r')
xlabel('\lambda -  Stretch Ratio')
ylabel('Force (N)')
xlim(xlimits)
legend('Control: Age 0-7','Control: Age 7-20','DMD: Age 0-7','DMD: Age 7-20')
set(gca,'FontSize',font_size,'fontWeight','bold')
set(findall(gcf,'type','text'),'fontSize',font_size,'fontWeight','bold')
title('DMD Patients Age Groups')



%% Control Subject and DMD Subjects Individual Trials

% select 6 subjects of DMD and control
s_dmd = [1 4 6 8 10 12];
s_control = [26 28 30 32 34 36];
s = [s_dmd s_control];

% counters for subplots
count_control = 1;
count_dmd = 1;

% get number of current figure open
 fh=findobj(0,'type','figure');
 fignum = length(fh);

% loop over subjects
for i = 1:length(s)
    % Calculate lambda
    lambda = d(s(i)).lambda(2);
    X = lambda;
    Y = d(s(i)).force;
    
    % Exclude flagged patients
    if d(s(i)).flag ~= 1
        % seperate control from dmd patients
        if d(s(i)).is_control == 1
            figure(fignum+1)
            subplot(3,2,count_control)
            hold on
            scatter(X(:,1),Y(:,1),'r')
            scatter(X(:,2),Y(:,2),'g')
            scatter(X(:,3),Y(:,3),'b')
            title(['Control Patient ' num2str(s(i))])
            xlabel('\lambda -  Stretch Ratio')
            ylabel('Force (N)')
            %legend('Trial 1','Trial 2','Trial 3')
            xlim(xlimits)
            count_control = count_control + 1;
        else
            figure(fignum+2)
            subplot(3,2,count_dmd)
            hold on
            scatter(X(:,1),Y(:,1),'r')
            scatter(X(:,2),Y(:,2),'g')
            scatter(X(:,3),Y(:,3),'b')
            title(['DMD Patient ' num2str(s(i))])
            xlabel('\lambda -  Stretch Ratio')
            ylabel('Force (N)')
            %legend('Trial 1','Trial 2','Trial 3')
            xlim(xlimits)
            count_dmd = count_dmd + 1;
        end
        
    end
    
end

% plot 2 ideal patients data
idx = 1;
lambda = d(idx).lambda(2);
X = lambda;
Y = d(idx).force;
figure
subplot(2,1,1)
hold on
scatter(X(:,1),Y(:,1),'r')
scatter(X(:,2),Y(:,2),'g')
scatter(X(:,3),Y(:,3),'b')
title(['DMD Patient ' num2str(idx)])
xlabel('\lambda -  Stretch Ratio')
ylabel('Force (N)')
legend('Trial 1','Trial 2','Trial 3')
xlim(xlimits)
set(gca,'FontSize',font_size,'fontWeight','bold')
set(findall(gcf,'type','text'),'fontSize',font_size,'fontWeight','bold')
% save plot
%print(gcf,'-djpeg','-r300',plot_name_prin)

idx = 28;
lambda = d(idx).lambda(2);
X = lambda;
Y = d(idx).force;
subplot(2,1,2)
hold on
scatter(X(:,1),Y(:,1),'r')
scatter(X(:,2),Y(:,2),'g')
scatter(X(:,3),Y(:,3),'b')
title(['Control Patient ' num2str(idx)])
xlabel('\lambda -  Stretch Ratio')
ylabel('Force (N)')
legend('Trial 1','Trial 2','Trial 3')
xlim(xlimits)
set(gca,'FontSize',font_size,'fontWeight','bold')
set(findall(gcf,'type','text'),'fontSize',font_size,'fontWeight','bold')
% save plot
%print(gcf,'-djpeg','-r300',plot_name_prin)







