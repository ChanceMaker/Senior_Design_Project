function [nw1,nb1,nw2,nb2,nw3,nb3,te,tr] = ...
  tbp3(w1,b1,f1,w2,b2,f2,w3,b3,f3,p,t,tp)
%TBP3     Trains a 3-layer network with backpropagation.
%         (Called by TRAINBP)
%         
%         [NW1,NB1,NW2,NB2,NW3,NB3,TE,TR]
%           = TBP2(W1,B1,F1,W2,B2,F2,W3,B3,F3,P,T,TP)
%           W1 - S1xR layer-1 weight matrix.
%           B1 - S1x1 layer-1 bias vector.
%           F1 - name of layer-1 transfer function (string).
%           W2 - S2xS1 layer-2 weight matrix.
%           B2 - S2x1 layer-2 bias vector.
%           F2 - name of layer-2 transfer function (string).
%           W3 - S3xS2 layer-3 weight matrix.
%           B3 - S3x1 layer-3 bias vector.
%           F3 - name of layer-3 transfer function (string).
%           P  - RxQ matrix of input vectors.
%           T  - S2xQ matrix of target vectors.
%           TP - row vector of 4 training parameters:
%                [disp_freq max_epoch err_goal lr]
%         Returns:
%           NW1,NB1 - new weights & biases for layer 1.
%           NW2,NB2 - new weights & biases for layer 2.
%           NW2,NB2 - new weights & biases for layer 3.
%           TE  - the actual number of epochs trained.
%           TR - training record: [row of errors]

%         M.H. Beale & H.B. Demuth, 1-31-92
%         Copyright (c) 1992-93 by the MathWorks, Inc.

if nargin ~= 12
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
W3 = w3;
B3 = b3;
DF3 = getdelta(f3);

% PRESENTATION PHASE
A1 = feval(f1,W1*p,B1);
A2 = feval(f2,W2*A1,B2);
A3 = feval(f3,W3*A2,B3);
E = t-A3;
SSE = sumsqr(E);

% TRAINING RECORD
TR = zeros(1,me);
SSE0 = SSE;

for epoch=1:me

  % CHECK PHASE
  if SSE < eg, epoch=epoch-1; break, end

  % BACKPROPAGATION PHASE
  D3 = feval(DF3,A3,E);
  D2 = feval(DF2,A2,D3,W3);
  D1 = feval(DF1,A1,D2,W2);

  % LEARNING PHASE
  [dW1,dB1] = learnbp(p,D1,lr);
  [dW2,dB2] = learnbp(A1,D2,lr);
  [dW3,dB3] = learnbp(A2,D3,lr);
  W1 = W1 + dW1; B1 = B1 + dB1;
  W2 = W2 + dW2; B2 = B2 + dB2;
  W3 = W3 + dW3; B3 = B3 + dB3;

  % PRESENTATION PHASE
  A1 = feval(f1,W1*p,B1);
  A2 = feval(f2,W2*A1,B2);
  A3 = feval(f3,W3*A2,B3);
  E = t-A3;
  SSE = sumsqr(E);

  % TRAINING RECORD
  TR(epoch) = SSE;

  % DISPLAY RESULTS
  if rem(epoch,df) == 0
    plottr([SSE0 TR(1,1:epoch)],'3-Layer Backpropagation')
    end
  end

if rem(epoch,df)
  plottr([SSE0 TR(1,1:epoch)],'3-Layer Backpropagation')
  end

% RETURN RESULTS

nw1 = W1;
nb1 = B1;
nw2 = W2;
nb2 = B2;
nw3 = W3;
nb3 = B3;
te = epoch;
tr = [SSE0 TR(1:epoch)];

