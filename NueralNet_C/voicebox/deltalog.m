function d = deltalog(a,d,w)
%DELTALOG Logistic Delta Function.
%         Returns the delta values for log-sigmoid neurons.
%         (See DELTALIN, DELTATAN, LEARNBP, LOGSIG, TRAINBP)
%         
%         DELTALOG(A,E)
%           A - S1xQ matrix of output vectors
%           E - S1xQ matrix of associated errors
%         Returns an SxQ matrix of output layer delta vectors.
%
%         DELTALOG(A,D,W)
%           D - S2xQ matrix of next layer delta vectors
%           W - S2xS1 weight matrix between layers.
%         Returns an SxQ matrix of hidden layer delta vectors.

%         M.H. Beale & H.B. Demuth, 1-31-92
%         Copyright (c) 1992-93 by the MathWorks, Inc.

if nargin < 2 | nargin > 3
  error('Wrong number of arguments.');
  end

if nargin == 2
  d = a.*(1-a).*d;
else
  d = a.*(1-a).*(w'*d);
end

