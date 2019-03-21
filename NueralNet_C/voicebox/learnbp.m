function [dw,db] = learnbp(p,d,lr)
%LEARNBP  Backpropagation Learning Rule:
%           dW(i,j) = lr*D(i)*P(j)
%         (See PURELIN, LOGSIG, TANSIG, TRAINBP)
%
%         LEARNBP(P,D,LR)
%           P  - RxQ matrix of input vectors.
%           E  - SxQ matrix of error vectors.
%           LR - the learning rate.
%         Returns a weight change matrix.
%
%         [dW,dB] = LEARNBP(P,D,LR)
%         Returns:
%           dW - a weight change matrix.
%           dB - a bias change vector.

%         M.H. Beale & H.B. Demuth, 1-31-92
%         Copyright (c) 1992-93 by the MathWorks, Inc.

if nargin ~= 3
  error('Wrong number of arguments.');
  end

x = lr*d;
dw = x*p';
if nargout == 2
  [pr,pc] = size(p);
  db = x*ones(pc,1);
  end

