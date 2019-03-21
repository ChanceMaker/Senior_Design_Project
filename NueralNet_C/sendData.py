import serial

ser = serial.Serial('COM7', 9600)
filename = "data.txt"
a = 0
f = open(filename, "r")
for line in f:
	x =  line.split(" ")

#print(x)
for i in range(0,10):
	print(x[i])
	ser.write(x[i].encode('utf-8'))
	ser.write('#'.encode('utf-8'))


