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
d = [];

%% Parse
for j = 1:length(data.id)
    
    id = data.id(j);
    index = find(age_data.id == id);
    age = age_data.age(index);
    visit_number = data.visit_number(j);
    force = data.force(j);
    skinfat_thickness = data.skinfat_thickness(j);
    muscle_thickness = data.muscle_thickness(j);
    flag = data.flag(j);
    
    if id == subject_id
        is_new = 0;
    else
        is_new = 1;
        subject_id = id;
    end
    
    if is_new == 1 || j == 1
        d(idx) = Subject(age, visit, flag, is_control);
        d(idx).muscle_thickness = muscle_thickness;
        d(idx).skinfat_thickness = skinfat_thickness;
        d(idx).force = force;
    else
        d(idx).muscle_thickness = [d(idx).muscle_thickness muscle_thickness];
        d(idx).skinfat_thickness = [d(idx).skinfat_thickness skinfat_thickness];
        d(idx).force = [d(idx).force force];
    end
end
    
        






