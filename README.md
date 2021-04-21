# multi-objective-artificial-bee-colony-algorithm
This project introduces a multiobjective artificial bee colony algorithm based on decomposition for solving normalized and scaled MOPs.

MOEADABC.m is the proposed algorithm. ZDT1.m is an example of problem.
Run the algorithm:  
main('-algorithm',Value,'-problem',Value,...) runs one algorithm on a problem with acceptable parameters.
For example: main('-algorithm',@MOEADABC,'-problem',ZDT1,'-N',200,'-M',2)

All the acceptable parameters:
%   '-N'            <positive integer>  population size
%   '-M'            <positive integer>  number of objectives
%   '-D'            <positive integer>  number of variables
%	  '-algorithm'    <function handle>   algorithm function
%	  '-problem'      <function handle>   problem function
%	  '-evaluation'   <positive integer>  maximum number of evaluations
%   '-run'          <positive integer>  run number
%   '-save'         <integer>           number of saved populations
%   '-outputFcn'	  <function handle>   function invoked after each generation

