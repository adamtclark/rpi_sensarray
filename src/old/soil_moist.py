import serial
import datetime
tmp = datetime.datetime.now()

if __name__ == '__main__':
    trigger = True
    while trigger:
        ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)
        ser.flush()
        if ser.in_waiting > 0:
            try:
                line = ser.readline().decode('utf-8').rstrip()
                print(tmp.strftime("%Y.%m.%d_%H.%M.%S")+"; "+line)
                trigger = False
            except:
                pass
