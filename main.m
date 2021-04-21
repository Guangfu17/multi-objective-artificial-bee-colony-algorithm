function main(varargin)

% "PlatEMO"
%   main('-Name',Value,'-Name',Value,...) runs one algorithm on a problem
%   with the specified parameter setting.
%
% All the acceptable properties:
%   '-N'            <positive integer>  population size
%   '-M'            <positive integer>  number of objectives
%   '-D'            <positive integer>  number of variables
%	'-algorithm'    <function handle>   algorithm function
%	'-problem'      <function handle>   problem function
%	'-evaluation'   <positive integer>  maximum number of evaluations
%   '-run'          <positive integer>  run number
%   '-save'         <integer>           number of saved populations
%   '-outputFcn'	<function handle>   function invoked after each generation
%
%   Example:
%
%       main('-algorithm',@MOEADABC,'-problem',@DTLZ2,'-N',200,'-M',10)
%
%   runs MOEAD-ABC on 10-objective DTLZ2 with a population size of 200.
%
%       for i = 1 : 10
%           main('-algorithm',@MOEADABC,'-problem',@DTLZ1,'-run',i,'-save',5)
%       end
%
%   runs MOEAD-ABC on DTLZ1 for 10 times, and each time saves 5 populations to
%   a file in /Data/MOEAD-ABC.



    Global = GLOBAL(varargin{:});
    Global.Start();

end