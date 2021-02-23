function Score = IGD(PopObj,PF)
% <metric> <min>
% Inverted generational distance


    %---------------scaled test problem--------------%
    % PopObj(:,1)=PopObj(:,1);
    % PopObj(:,2)=PopObj(:,2)./10;
    % PopObj(:,3)=PopObj(:,3)./100;
    %---------------scaled test problem--------------%

    
    Distance = min(pdist2(PF,PopObj),[],2);
    Score    = mean(Distance);
end