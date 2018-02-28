function outString = buildCallStack(exception)
% Creates a string revealing the call stack. To help trace the errors in a
% catch event.

% *************************************************************************
% Copyright (C) 2018 Javier Mazzaferri and Santiago Costantino
% <javier.mazzaferri@gmail.com>
% <santiago.costantino@umontreal.ca>
% Hopital Maisonneuve-Rosemont,
% Centre de Recherche
% www.biophotonics.ca
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
% *************************************************************************

outString = [];

if ~ismember('stack',fieldnames(exception)), return, end

for s = 1:numel(exception.stack)
    thisText = [' | Function: ' exception.stack(s).name ' (at: ' num2str(exception.stack(s).line) ').'];
    outString = [outString, thisText];
end

end