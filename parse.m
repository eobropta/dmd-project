%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MCTB - DMD Project
% Parser
% Alex Mijailovic, Eddie Obropta, Whitney Young
% Fall 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear
clc

%% Load Data
% Use the following file structure
% MATLAB/dmd_project/
% --- code/
% --- data/

load('../data/age_data.mat');
load('../data/data.mat');

%% Initialize 
is_new = 1;
subject_id = data.id(1);
idx = 1;
counter = 1;
is_new_trial = 1;
trial = data.muscle_number(1);

%% Parse
for j = 1:length(data.id)
    
    id = data.id(j);
    index = find(age_data.id == id);
    age = age_data.age(index);
    visit_number = data.visit_number(j);
    force = data.force(j);
    skinfat_thickness = data.skinfat_thickness(j);
    muscle_thickness = data.muscle_thickness(j);
    trial_number = data.muscle_number(j);
    flag = data.flag(j);
    
    if id < 2000
        is_control = 0;
    else
        is_control = 1;
    end
    
    if id == subject_id
        is_new = 0;
    else
        is_new = 1;
        subject_id = id;
        idx = idx + 1;
        counter = 1;
    end
    
    if trial_number ~= trial
        counter = 1;
        trial = trial_number;
    end
    
    
    if is_new == 1 || j == 1
        d(idx) = Subject(id, age, visit_number, flag, is_control);
        d(idx).muscle_thickness(1,trial_number) = muscle_thickness;
        d(idx).skinfat_thickness(1,trial_number) = skinfat_thickness;
        d(idx).force(1,trial_number) = force;
        counter = counter + 1;
    else
        d(idx).muscle_thickness(counter,trial_number) = muscle_thickness;
        d(idx).skinfat_thickness(counter,trial_number) = skinfat_thickness;
        d(idx).force(counter,trial_number) = force;
        counter = counter + 1;
    end
end
    
        







