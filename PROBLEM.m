classdef PROBLEM < handle
%PROBLEM - The superclass of all the problems in platemo.
%
%   This is the superclass of all the problems. This class cannot be
%   instantiated.
%--------------------------------------------------------------------------

    properties(SetAccess = private)
        Global; % The current GLOBAL object
    end
    methods(Access = protected)
        %% Constructor
        function obj = PROBLEM()
            obj.Global = GLOBAL.GetObj();
        end
    end
    methods
        %% Generate initial population
        function PopDec = Init(obj,N)
            switch obj.Global.encoding
                case 'binary'
                    PopDec = randi([0,1],N,obj.Global.D);
                case 'permutation'
                    [~,PopDec] = sort(rand(N,obj.Global.D),2);
                otherwise
                    PopDec = unifrnd(repmat(obj.Global.lower,N,1),repmat(obj.Global.upper,N,1));
            end
        end
        %% Repair infeasible solutions
        function PopDec = CalDec(obj,PopDec)
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = PopDec(:,1)   + sum(PopDec(:,2:end),2);
            PopObj(:,2) = 1-PopDec(:,1) + sum(PopDec(:,2:end),2);
        end
        %% Calculate constraint violations
        function PopCon = CalCon(obj,PopDec)
            PopCon = zeros(size(PopDec,1),1);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P = ones(1,obj.Global.M);
        end
        %% Draw special figure
        function Draw(obj,PopDec)
        end
    end
end