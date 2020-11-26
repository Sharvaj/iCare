classdef CircArray < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Data
        Length
        CurrentPos
    end
    
    methods
        function obj = CircArray(InputMatrix)
            % Construct an instance of this class
            %   Detailed explanation goes here
            obj.Data = InputMatrix(:);
            obj.Length = length(obj.Data);
            obj.CurrentPos = obj.Length-1;
        end
        
        function IndexedValues = GetVals(obj, indices)
            % Summary of this method goes here
            %   Detailed explanation goes here
            IndexedValues = obj.Data(mod(indices+obj.CurrentPos, obj.Length) + 1);
            % IndexedValues = obj.Data(mod(indices-obj.CurrentPos, obj.Length) + 1);
        end
        
        function WriteVals(obj, indices, values)
            
            obj.Data(mod(indices+obj.CurrentPos, obj.Length) + 1) = values(:);
            shiftPos = length(indices);
            obj.CurrentPos = mod(obj.CurrentPos+shiftPos, obj.Length);
        end
        
        function OutArray = AddCircArray(obj, other)
            
            AddedMatrix = obj.Data + other.Data;
            OutArray = CircArray(AddedMatrix);           
        end
        
        function Show(obj)
            ShowDat = table;
            ShowDat.Data = obj.Data;
            ShowDat.CurrentPos = ...
                (obj.CurrentPos == (0:obj.Length-1).')*1;
            disp(ShowDat);
        end
        
        function RunningPlot(obj, NumVals)
            arrangedArray = obj.GetVals((-NumVals+1):0);            
            plot((-NumVals+1):0, arrangedArray);
        end
        
        function RunningStem(obj, NumVals)
            arrangedArray = obj.GetVals((-NumVals+1):0);            
            stem((-NumVals+1):0, arrangedArray);
        end
        
        function RunningTimePlot(obj, trackTime, NumVals)
            arrangedArray = obj.GetVals((-NumVals+1):0);
            timeVals = trackTime.GetVals((-NumVals+1):0);
            plot(timeVals, arrangedArray);
            xlim([timeVals(1), timeVals(end)])
        end
        
        function RunningTimeStem(obj, trackTime, NumVals)
            arrangedArray = obj.GetVals((-NumVals+1):0); 
            timeVals = trackTime.GetVals((-NumVals+1):0);
            stem(timeVals, arrangedArray);
            xlim([timeVals(1), timeVals(end)])
        end
        
    end
    
end

