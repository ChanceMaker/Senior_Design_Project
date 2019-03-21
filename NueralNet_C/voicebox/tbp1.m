function [nw,nb,te,tr] = tbp1(w,b,f,p,t,tp)
%TBP1     Trains a 1-layer network with backpropagation.
%         (Called by TRAINBP)
%         
%         [NW,NB,TE,TR] = TBP1(W,B,F,P,T,TP)
%           W  - SxR weight matrix.
%           B  - Sx1 bias vector.
%           F  - name of the transfer function (string).
%           P  - RxQ matrix of input vectors.
%           T  - SxQ matrix of target vectors.
%           TP - row vector of 4 training parameters:
%                [disp_freq max_epoch err_goal lr]
%         Returns:
%           NW,NB - new weights & biases.
%           TE - the actual number of epochs trained.
%           TR - training record: [row of errors]

%         M.H. Beale & H.B. Demuth, 1-31-92
%         Copyright (c) 1992-93 by the MathWorks, Inc.

if nargin ~= 6
  error('Wrong number of arguments.');
  end

% TRAINING PARAMETERS
df = tp(1);
me = tp(2);
eg = tp(3);
lr = tp(4);

% NETWORK PARAMETERS
W = w;
B = b;
FP = getdelta(f);

% PRESENTATION PHASE
A = feval(f,W*p,B);
E = t-A;
SSE = sumsqr(E);

% TRAINING RECORD
TR = zeros(1,me);
SSE0 = SSE;

for epoch=1:me

  % CHECK PHASE
  if SSE < eg, epoch=epoch-1; break, end

  % BACKPROPAGATION PHASE
  D = feval(FP,A,E);

  % LEARNING PHASE
  [dW,dB] = learnbp(p,D,lr);
  W = W + dW; B = B + dB;

  % PRESENTATION PHASE
  A = feval(f,W*p,B);
  E = t-A;
  SSE = sumsqr(E);

  % TRAINING RECORD
  TR(epoch) = SSE;

  % DISPLAY RESULTS
  if rem(epoch,df) == 0
    plottr([SSE0 TR(1,1:epoch)],'1-Layer Backpropagation')
    end
  end

if rem(epoch,df)
  plottr([SSE0 TR(1,1:epoch)],'1-Layer Backpropagation')
  end

% RETURN RESULTS
nw = W;
nb = B;
te = epoch;
tr = [SSE0 TR(1:epoch)];

