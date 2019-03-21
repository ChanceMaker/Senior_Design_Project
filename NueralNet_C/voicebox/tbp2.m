function [nw1,nb1,nw2,nb2,te,tr]=tbp2(w1,b1,f1,w2,b2,f2,p,t,tp)
%TBP2     Trains a 2-layer network with backpropagation.
%         (Called by TRAINBP)
%         
%         [NW1,NB1,NW2,NB2,TE,TR]
%           = TBP2(W1,B1,F1,W2,B2,F2,P,T,TP)
%           W1 - S1xR layer-1 weight matrix.
%           B1 - S1x1 layer-1 bias vector.
%           F1 - name of layer-1 transfer function (string).
%           W2 - S2xS1 layer-2 weight matrix.
%           B2 - S2x1 layer-2 bias vector.
%           F2 - name of layer-2 transfer function (string).
%           P  - RxQ matrix of input vectors.
%           T  - S2xQ matrix of target vectors.
%           TP - row vector of 4 training parameters:
%                [disp_freq max_epoch err_goal lr]
%         Returns:
%           NW1,NB1 - new weights & biases for layer 1.
%           NW2,NB2 - new weights & biases for layer 2.
%           TE  - the actual number of epochs trained.
%           TR - training record: [row of errors]

%         M.H. Beale & H.B. Demuth, 1-31-92
%         Copyright (c) 1992-93 by the MathWorks, Inc.

if nargin ~= 9
  error('Wrong number of arguments.');
  end

% TRAINING PARAMETERS
df = tp(1);
me = tp(2);
eg = tp(3);
lr = tp(4);

% NETWORK PARAMETERS
W1 = w1;
B1 = b1;
DF1 = getdelta(f1);
W2 = w2;
B2 = b2;
DF2 = getdelta(f2);

% PRESENTATION PHASE
A1 = feval(f1,W1*p,B1);
A2 = feval(f2,W2*A1,B2);
E = t-A2;
SSE = sumsqr(E);

% TRAINING RECORD
TR = zeros(1,me);
SSE0 = SSE;

for epoch=1:me

  % CHECK PHASE
  if SSE < eg, epoch=epoch-1; break, end

  % BACKPROPAGATION PHASE
  D2 = feval(DF2,A2,E);
  D1 = feval(DF1,A1,D2,W2);

  % LEARNING PHASE
  [dW1,dB1] = learnbp(p,D1,lr);
  [dW2,dB2] = learnbp(A1,D2,lr);
  W1 = W1 + dW1; B1 = B1 + dB1;
  W2 = W2 + dW2; B2 = B2 + dB2;

  % PRESENTATION PHASE
  A1 = feval(f1,W1*p,B1);
  A2 = feval(f2,W2*A1,B2);
  E = t-A2;
  SSE = sumsqr(E);

  % TRAINING RECORD
  TR(epoch) = SSE;

  % DISPLAY RESULTS
  if rem(epoch,df) == 0
    plottr([SSE0 TR(1,1:epoch)],'2-Layer Backpropagation')
    end
  end

if rem(epoch,df)
  plottr([SSE0 TR(1,1:epoch)],'2-Layer Backpropagation')
  end

% RETURN RESULTS

nw1 = W1;
nb1 = B1;
nw2 = W2;
nb2 = B2;
te = epoch;
tr = [SSE0 TR(1:epoch)];

