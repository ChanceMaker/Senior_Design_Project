% num_decide Decides which number is predicted
%
% Usage
%	[ c ] = num_decide( x )
%
% Input
%	x (INT): Reads the network out value in vector format 
%
% Output
%	out1 (type): displays the value of the binary input into integer
%
% Description
%	This function is a helper function to melbetavoice in that it looks at
%	the output of the prediction and comes up with a integer representation
%	for what the prediciton algorithm predicted
%
% See also
%	melbetavoice 
%

function num_decide(x)
%Converting the vector to strict decimal vector to an integer vector.
y = 1:2;
for i=1:2
    if x(i) < .5
        y(i) = 0;   
    
    else
        y(i) = 1;
    end

end

c =  binaryVectorToDecimal(y) ;

switch c
    case 0
        disp('I heard one')
    case 1
        disp('I heard two')
    case 2
        disp('I heard three')
    case 3
        disp('I heard four')
   
    otherwise
        disp('Sorry try again I did not understand.')
end
end




