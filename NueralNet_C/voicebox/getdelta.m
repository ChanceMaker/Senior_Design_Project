function df = getdelta(f)
%GETDELTA Transfer function ==> Delta function lookup.
%         (See DELTALIN, DELTALOG, DELTATAN, LOGSIG,
%         PURELIN, TANSIG)
%
%         GETDELTA(F), F is a function name (string).
%         Returns the delta function associated with
%           the given differentiable transfer function F.
%
%         You may add your own differentiable transfer
%           functions and corresponding delta functions to
%           the table in this function.  Make sure your
%           functions are called with the same arguments
%           as the supplied transfer and delta functions.

%         M.H. Beale & H.B. Demuth, 1-31-92
%         Copyright (c) 1992-93 by the MathWorks, Inc.

if nargin ~= 1
  error('Wrong number of arguments.');
  end

df = '';

% THE TRANSFER/DELTA FUNCTION TABLE:

if strcmp(f,'purelin'), df = 'deltalin'; end
if strcmp(f,'logsig'), df = 'deltalog'; end
if strcmp(f,'tansig'), df = 'deltatan'; end

if length(df) == 0
  fprintf('??? Not in GETDELTA table: '); fprintf(f); fprintf('\n');
  error('Unrecognized differentiable transfer function.');
  end

