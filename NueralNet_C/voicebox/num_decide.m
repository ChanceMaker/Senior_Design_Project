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
y = 1:4;
for i=1:4
    if x(i) < .5
        y(i) = 0;   
    
    else
        y(i) = 1;
    end

end

c =  binaryVectorToDecimal(y) ;

switch c
    case 0
        disp('I heard zero')
    case 1
        disp('I heard one')
    case 2
        disp('I heard two')
    case 3
        disp('I heard three')
    case 4
        disp('I heard four')
    case 5
        disp('I heard five')
    case 6
        disp('I heard six')
    case 7
        disp('I heard seven')
    case 8
        disp('I heard eight')
    case 9
        disp('I heard nine')
    otherwise
        disp('Sorry try again I did not understand.')
end
end




