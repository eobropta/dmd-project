classdef Subject < handle
    % Subject class
    %   This class let's you plot data and query data for each subject
    
    properties
        id % int
        age % float
        visit % int
        force % nx1 float [N]
        skinfat_thickness % nx1 float [mm]
        muscle_thickness % nx1 float [mm]
        flag % boolean (0,1)
        is_control % boolean (0,1)
        
    end
    
    methods
        %% Constructor
        function d = Subject(id, age, visit, flag, is_control)
            d.id = id;
            d.age = age;
            d.visit = visit;
            d.flag = flag;
            d.is_control = is_control;
        end
        %% Plots
        function plot(obj, trial)
            if trial > 3
                error('Trial number invalid. Only three trials')
            end
            
            scatter(obj.muscle_thickness(:,trial), obj.force(:,trial));
            title('Force v. length');
        end
        %% Calculate Stretch Ratio
        function x = lambda(obj, force)
            % force determine which length to normalize to
            [I,J] = find(obj.force == 2);
            
            for i = 1:length(I)
                x(:,J(i)) = obj.muscle_thickness(:,J(i)) / obj.muscle_thickness(I(i),J(i));
            end
        end
            
    end
    
end

