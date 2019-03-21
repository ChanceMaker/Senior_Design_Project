import serial

ser = serial.Serial('COM7', 9600)


while (True):
    if (ser.inWaiting()>0): #if incoming bytes are waiting to be read from the serial input buffer
        data_str = ser.read(ser.inWaiting()).decode('ascii') #read the bytes and convert from binary array to ASCII
        print(data_str, end='')