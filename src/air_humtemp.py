import RPi.GPIO as GPIO
import dht11
import time

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
                trigger = False
            else:
                time.sleep(0.2)
                #print("error H1")

        trigger = True
        while trigger:
            result_01 = instance_01.read()
            if result_01.is_valid():
                trigger = False
            else:
                time.sleep(0.2)
        print(str(result_12.temperature)+"; "+str(result_12.humidity)+"; "+str(result_01.temperature)+"; "+str(result_01.humidity))

except KeyboardInterrupt:
        print("Cleanup")
        GPIO.cleanup()
