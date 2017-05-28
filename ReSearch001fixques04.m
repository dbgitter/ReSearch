% *************************************************************************
% *Copyright (C) 2017  Dan Bobczynski KG4HNS                              *
% *                                                                       *
% *This program is free software: you can redistribute it and/or modify   *
% *it under the terms of the GNU General Public License as published by   *
% *the Free Software Foundation, either version 3 of the License, or      *
% *(at your option) any later version.                                    *
% *                                                                       *
% *This program is distributed in the hope that it will be useful,        *
% *but WITHOUT ANY WARRANTY; without even the implied warranty of         *
% *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
% *GNU General Public License for more details.                           *
% *                                                                       *
% *You should have received a copy of the GNU General Public License      *
% *along with this program.  If not, see <http://www.gnu.org/licenses/>.  *
% *                                                                       *
% *************************************************************************
% *                                                                       *
% * Title:    ReSearch.m                                                  *
% * Abstract: A program to calculate selected parallel resistances from a *
% *           list of resistors on hand and calculate the desired         *
% *           resistance from the new resistamce list.                    *   
% *                                                                       *
% *                                                                       *   
% * Version:  1.00                                                        *
% * Date:     2017-04-29 00:34:32                                         *
% * Coded By: Dan Bobczynski  KG4HNS                                      *
% *                                                                       *
% *************************************************************************
% *************************************************************************
%  Change Log:
%        
% ****************************************************************************
% ****************************************************************************
%
%  The ReSearch.m program creates an expanded list of resistance
%  values from a supplied list of resistors to aid in searching for parallel
%  and series resistor combinations to form a desired resistance.
%
%  It calculates the resistance of two resistors in 
%  parallel from a list in ascending order of resistors on hand.  Each resistor is paired one at 
%  a time with the next resistors in the list.  For each combination, a 
%  record is produced showing the resultant parallel resistance, and the 
%  values of the two resistors used. This can then be used by a simple bin packing 
%  program to select and add up the desired resistance from the new resistance
%  list.  The bin packing program would then traverse this new list
%  accumulating resistance records of value equal or less than the desired 
%  resistance until the desired resistance is approximated.  The search
%  depth determines the sample set size.  
%
%  The actual resistor list of resistors on hand is also included in the
%  new list.
%
%  The program can search deeper or shallower numbers of
%  resistors at a time, however the law of diminishing returs kicks in 
%  when going very deep, e.g, pairing a 1M resistor with a 1 Ohm resistor is
%  of little value.  The search depth limit should be determined by the
%  percentage difference between paired resistances.  A depth of six 
%  seems to accomodate most needs.
%
%
% Usage:
% 
%  The user must input the name of the file containing 
%  the list of resistors on hand, the search depth, the desired resistance 
%  and the tolerance.
%  The resistor values are then read into to the 'r' array.
%  Upon completion, the new expanded resistance list resides in the 
%  'nc' array.  Each row of the 'nc' array
%  contains: New resistance value; Resistor 1; Resistor2
%  where Resistor 1 and Resistor 2 are selected from the list of 
%  owned resistors.  The nc array is then sorted, producing the
%  ncsorted array.  Next the desired resitance is computed by selecting 
%  resistances from the new list to be placed in series.  The computation
%  ends when no smaller resistance can be used in series, or when the
%  desired tolerance has been met. 
%
%  
%
%
%  
%
%
%  
%
%  
%
% run MakeResistors
clear                                                 % Clear the workspace
instring = input('Resistor list file name ?  ','s');  % Input owned resistor file name
%instring =    '/Users/dan/Documents/db/Electronics/ResCalc/ResistorList01.txt'
%while 1==1
    %clear
r = importdata(instring);                             % Input owned resistance values
r = sortrows(r);                                      % sort the input resistance list
limitresolution = ('Resolution Limit Reached');
sdepth = input('Search depth ? (0 ends program) ');   % Input desired search depth
if sdepth == 0
    exit
end
cdepth = sdepth;
dres = input('Desired resistance ?  ');               % Input resistance desired
drestol = (input('Desired resistance tolerance in percent 1 - 20 ?  '))/100;
format shortEng                                      % Set the output format
rsize=length(r);                                     % Get the input array length
alloc = (rsize-sdepth)*(sdepth+2) + sum(2:sdepth+1);
n= zeros(1,alloc);            % Preallocation of new value list saves time
nc=zeros(alloc,3);            % Preallocate search results record list
ixn=1;                                 % Initialize new list index
k=1;                                   % Initialize resistor 2 index
for j=1:rsize                          % Do for the number of owned resistors 
   if j > rsize - sdepth               % If not near the end, keep search depth the same
       cdepth = cdepth - 1;            % If near the end, adjust search depth to equal remaining values
   end
   for i=0:cdepth                      % Do for the deph of search
       n(ixn)= 1/(1/r(j) + 1/r(i+k));  % Calculate the parallel resistance from resistor 1 and resistor 2
       nc(ixn,1) = n(ixn);             % Fill out the new resistance record with computed value
       nc(ixn,2) = r(j);               % Fill out the new resistance record with resistor 1 
       nc(ixn,3) = r(i+k);             % Fill out the new resistance record with resistor 2
       ixn = ixn + 1;                  % Increment the new list index
   end                                 % End of depth search
   nc(ixn,1) = r(j);                   % Insert the owned resistor value into the new list
   ixn = ixn + 1;                      % Increment the new list index
   k= k+1;                             % Increment the resistor 2 index
end                                    % End of number of owned resistors
ncsorted= sortrows(nc);                % Sort the output resistance records on the result field.
                                       % Results Format:
                                       % Each row (record) of ncsorted contains the results of 
                                       % the parallel calculation and the values of the two owned
                                       % resistors used in the calculation as follows:
                                       %       Result value; Owned resistor #1; Owned resistor #2
                                       %
                                       % To obtain the resistance required, simply select resistors
                                       % from the new list to be placed in series.
                                       
dresidx = find((ncsorted(:,1))<=dres); % find the largest resistor less than or equal to desired
dresix=dresidx(end);                   % get the index to largest resistor
dressum=ncsorted(dresix,1);            % get the resistance from the sorted records
resseries(1) = ncsorted(dresix);       % initialize resseries

for m=1:ixn         % Now search the list for values to place in series to make the desired resistance
    residx = find(ncsorted(:,1) <= (dres - dressum));   % get index list of next value less than (desired - current sum)
    if isempty(residx) | dressum == 0                  % quit if sum is 0 or no next value
        limitresolution
        break
    end
    resix = residx(end);                               % get last index from found list
    dressum = ncsorted(resix) + dressum;               % add in the value
    resseries(m+1) = ncsorted(resix);                  % accumulate the records in resseries
    
    if abs(dres - dressum) <= drestol*dres      % if desired tolerance reached, quit
        break
    end
    if (dres-dressum) <= ncsorted(1)                   % quit if no smaller resistance can be found
        no_smaller_resistor = ('TRUE')
        break
    end    
                                        
end

  format shortE
  Actual_resistance_Found = dressum
  Use_These_Resistances= resseries'           % list out the series resistance values and composite resistors
  format bank
  Actual_Tolerance = ((dres - dressum)/dres)*100    % list the actual tolerance obtained
  format shortE                               % set format for demo
  % format shortEng                           % set format for full output
  % ncsorted                                    % list entire resistance list for demo
  
  %workspace
  
%end
%  semilogy(ncsorted(:,1),'.')                % have a look at the resister
%  hold on                                    % pair differences vs the
%  semilogy(r,'*')                            % resulting resistance.
%  hold off
