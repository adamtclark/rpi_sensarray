# load imports
import RPi.GPIO as GPIO
import dht11
import time
import datetime
import serial
from w1thermsensor import W1ThermSensor
from picamera import PiCamera

# Loop
while True:
    # Humidity
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
            if result_12.is_valid():
                print("Last valid input: " + str(datetime.datetime.now()))
                print("Temperature 01: %-3.1f C" % result_12.temperature)
                print("Humidity 01: %-3.1f %%" % result_12.humidity)
                trigger = False
            else:
                time.sleep(0.2)
                #print("error H1")

        trigger = True
        while trigger:
            result_01 = instance_01.read()
            if result_01.is_valid():
                print("Last valid input: " + str(datetime.datetime.now()))
                print("Temperature 02: %-3.1f C" % result_01.temperature)
                print("Humidity 02: %-3.1f %%" % result_01.humidity)
                trigger = False
            else:
                time.sleep(0.2)
                #print("error H2")

    except KeyboardInterrupt:
        print("Cleanup")
        GPIO.cleanup()


    # Temperature:
    for sensor in W1ThermSensor.get_available_sensors():
        print("Sensor %s has temperature %.2f" % (sensor.id, sensor.get_temperature()))
    time.sleep(0.2)

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
    time.sleep(0.2)

    # Camera
    camera = PiCamera()
    camera.start_preview()
    time.sleep(5)
    tmp = datetime.datetime.now()

    camera.capture('out/picture_'+tmp.strftime("%d.%m.%Y_%H.%M.%S")+'.jpg')
    camera.stop_preview()
    print("picture taken")
