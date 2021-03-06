#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void openWav(double *, long * );
static double bytesToDouble(char , char ) ;


int main(){
	double *wav;
    long  filelen;
    wav =  malloc((filelen + 1) * sizeof (double*));
	openWav(wav,&filelen);
    int count = 0;

    printf("SIZE OF wefilelen = %d\n",filelen);
    printf("FIRST ELEMENT %f\n", *(wav + 1));
    for (int i = 0; i < filelen; i++)
    {
       
        if(count < 4){
            printf(": % 2.6f : ", wav[i]);
            count++;
        }
        else{
            count = 1;
            printf("\n");

            printf(": % 2.6f : ", wav[i]); 
            count++;

        }
    }
    
    
}

static double bytesToDouble(char firstByte, char secondByte) {
    // convert two bytes to one short (little endian)
    short s = (secondByte << 8) | firstByte;
    // convert to range from -1 to (just below) 1

    return s / 32768.0;
}

// Returns left and right double arrays. 'right' will be null if sound is mono.
 void openWav(double * left, long * filelen)
{
    File fileptr;
    File dataFile;
    char *buffer;
    double *databuffer;
  
    int i = 0;
    double check = 0;

  

    fileptr = SD.open("TEST.WAV", FILE_READ);// Open the file in binary mode
    * filelen = fileptr.size();             // Get the current byte offset in the file
   

    buffer = malloc((*filelen+1)*sizeof(char)); // Enough memory for file + \0
    fileptr.read(buffer, *filelen);// Read in the entire file
  
    fileptr.close();
    
    
   
    // Determine if mono or stereo
    int channels = buffer[22];     // Forget byte 23 as 99.999% of buffers are 1 or 2 channels

    // Get past all the other sub chunks to get to the data subchunk:
    int pos = 12;   // First Subchunk ID from 12 to 16

    // Keep iterating until we find the data chunk (i.e. 64 61 74 61 ...... (i.e. 100 97 116 97 in decimal))
    while(!(buffer[pos]==100 && buffer[pos+1]==97 && buffer[pos+2]==116 && buffer[pos+3]==97)) {
        pos += 4;
        int chunkSize = buffer[pos] + buffer[pos + 1] * 256 + buffer[pos + 2] * 65536 + buffer[pos + 3] * 16777216;
        pos += 4 + chunkSize;
    }
    pos += 8;

    // Pos is now positioned to start of actual sound data.
    int samples = (*filelen - pos)/2;     // 2 bytes per sample (16 bit sound mono)
    //Allocate memory for the array
    
    while (pos < *filelen) {

        left[i] = bytesToDouble(buffer[pos], buffer[pos + 1]);

        pos += 2;
        i++;
        
   
    }

    dataFile = SD.open("soundData.txt", FILE_WRITE);
    dataFile.write(left);
    dataFile.close();


  
   
}
		