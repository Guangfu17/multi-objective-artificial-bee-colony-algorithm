classdef ZDT1 < PROBLEM
% <problem> <ZDT>
% Benchmark MOP proposed by Zitzler, Deb, and Thiele
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function obj = ZDT1()
            obj.Global.M = 2;
            if isempty(obj.Global.D)
                obj.Global.D = 30;
            end
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D);
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = PopDec(:,1);
            g = 1 + 9*sum(PopDec(:,2:end),2);
            h = 1 - (PopObj(:,1)./g).^0.5;
            PopObj(:,2) = g.*h;
            %--------------------scaled test problem---------%
            % PopObj(:,1)=PopObj(:,1);
            % PopObj(:,2)=PopObj(:,2).*10;
            %--------------------scaled test problem---------%
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1)';
            P(:,2) = 1 - P(:,1).^0.5;
            %--------------------scaled test problem---------%
            % P(:,1)=P(:,1);
            % P(:,2)=P(:,2).*10;
            %--------------------scaled test problem---------%
        end
    end
end