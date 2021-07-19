#!/usr/bin/python3
from time import sleep
import datetime
import serial
from w1thermsensor import W1ThermSensor
from picamera import PiCamera

# Temperature:
for sensor in W1ThermSensor.get_available_sensors():
    print("Sensor %s has temperature %.2f" % (sensor.id, sensor.get_temperature()))
sleep(1)

# Moisture:
if __name__ == '__main__':
    ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)
    ser.flush()
    trigger = True
    while trigger:
        if ser.in_waiting > 0:
            line = ser.readline().decode('utf-8').rstrip()
            print(line)
            trigger = False
sleep(1)

# Camera
camera = PiCamera()
camera.start_preview()
sleep(5)
tmp = datetime.datetime.now()

camera.capture('out/picture_'+tmp.strftime("%d.%m.%Y_%H.%M.%S")+'.jpg')
camera.stop_preview()



# Humidity
import RPi.GPIO as GPIO
import dht11

# initialize GPIO
GPIO.setwarnings(True)
GPIO.setmode(GPIO.BCM)

# read data using pin 12 and 1
instance_12 = dht11.DHT11(pin=12)
instance_01 = dht11.DHT11(pin=1)

try:
    trigger = True
    while trigger:
        result_12 = instance_12.read()
        result_01 = instance_01.read()
        if result_12.is_valid():
            print("Last valid input: " + str(datetime.datetime.now()))
            print("Temperature 01: %-3.1f C" % result_12.temperature)
            print("Humidity 01: %-3.1f %%" % result_12.humidity)

            if result_01.is_valid():
                print("Temperature 02: %-3.1f C" % result_01.temperature)
                print("Humidity 02: %-3.1f %%" % result_01.humidity)
                trigger = False
        time.sleep(2)

except KeyboardInterrupt:
    print("Cleanup")
    GPIO.cleanup()