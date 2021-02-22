function MOEADABC(Global)
% <algorithm> <M>
% Multiobjective artifical bee colony algorithm based on decomposition
% type --- 1 --- The type of aggregation function

%------------------------------- Reference --------------------------------
% A Multiobjective Artificial Bee Colony Algorithm based on Decomposition, 
% 11th International Conference on Evolutionary Computation Theory and 
% Applications, 2019.
%--------------------------------------------------------------------------

    %% Parameter setting
    type = Global.ParameterSet(1);

    %% Generate the weight vectors
    [W,Global.N] = UniformPoint(Global.N,Global.M);
    % T = ceil(Global.N/10);
    T = 20;

    %% Detect the neighbours of each solution
    B = pdist2(W,W);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    
    %% Generate random population
    Population = Global.Initialization();
    Z = min(Population.objs,[],1);

    %% Optimization
    while Global.NotTermination(Population)
        % For each solution
        for i = 1 : Global.N      
            % Choose the parents
            P = B(i,:);
            
            % Generate an offspring
            %---------------1-----normalized test problem-----------------%
            % Teneighbour = max(abs(Population(P).objs-repmat(Z,T,1))./W(i,:),[],2);   % Modified Tchebycheff approach value based on the same weight
            %--------------------normalized test problem------------------%
            
            %---------------2-----scaled test problem---------------------%            
            Zmax  = max(Population.objs,[],1);
            Teneighbour = max(abs(Population(P).objs-repmat(Z,T,1))./repmat(Zmax-Z,T,1)./W(i,:),[],2);
            %---------------------scaled test problem---------------------%

            MeanCost = mean(Teneighbour);  %------mean of Te neighbourhood
            
            %--------avoid MeanCost==0--------%
            if MeanCost == 0
                m = randi([1 T]);  % radnom value of 1~T
            else
                F = exp(-Teneighbour/MeanCost);  % Convert Cost to Fitness
                PPP = F/sum(F);
                % Select Source Site
                m = SelfRouletteWheelSelection(PPP);
            end
            
            % Choose k randomly from neighborhood, not equal to m
            index = randperm(T);   % random order
            while m == index(1)
                index = randperm(T);
            end
            k = B(i,index(1));
            
            % Define Acceleration Coeff.
            % phi=a*unifrnd(-1,+1,VarSize);
            phi=1*unifrnd(-1,+1,[1,Global.D]);
            
            % New Bee Position
            Offspring = Population(B(i,m)).decs+phi.*(Population(B(i,m)).decs-Population(k).decs);
            
            %-------------------Polynomial mutation----------------------%
            for ii = 1:Global.D
                if rand < 1/Global.D
                    mu = 20;                   
                    r = rand;
                    if r < 0.5
                        delta = (2*r)^(1/(1+mu))-1;
                    else
                        delta = 1-(2*(1-r))^(1/(mu+1));
                    end
                    Offspring(ii) = Offspring(ii) + delta.*(Global.upper(ii)-Global.lower(ii));
                end
            end
        %----------------------------END-----------------------------%
         
            Offspring = INDIVIDUAL(Offspring);

            % Update the ideal point
            Z = min(Z,Offspring.obj);

            % Update the neighbours
            switch type
                case 1
                    % PBI approach
                    normW   = sqrt(sum(W(P,:).^2,2));
                    normP   = sqrt(sum((Population(P).objs-repmat(Z,T,1)).^2,2));
                    normO   = sqrt(sum((Offspring.obj-Z).^2,2));
                    CosineP = sum((Population(P).objs-repmat(Z,T,1)).*W(P,:),2)./normW./normP;
                    CosineO = sum(repmat(Offspring.obj-Z,T,1).*W(P,:),2)./normW./normO;
                    g_old   = normP.*CosineP + 5*normP.*sqrt(1-CosineP.^2);
                    g_new   = normO.*CosineO + 5*normO.*sqrt(1-CosineO.^2);
                case 2
                    % Tchebycheff approach
                    g_old = max(abs(Population(P).objs-repmat(Z,T,1)).*W(P,:),[],2);
                    g_new = max(repmat(abs(Offspring.obj-Z),T,1).*W(P,:),[],2);
                case 3
                    % Tchebycheff approach with normalization
                    Zmax  = max([Population.objs;Offspring.obj],[],1);
                    g_old = max(abs(Population(P).objs-repmat(Z,T,1))./repmat(Zmax-Z,T,1)./W(P,:),[],2);
                    g_new = max(repmat(abs(Offspring.obj-Z)./(Zmax-Z),T,1)./W(P,:),[],2);
                case 4
                    % Modified Tchebycheff approach
                    g_old = max(abs(Population(P).objs-repmat(Z,T,1))./W(P,:),[],2);
                    g_new = max(repmat(abs(Offspring.obj-Z),T,1)./W(P,:),[],2);
            end
            Population(P(g_old>=g_new)) = Offspring;
        end
    end
end