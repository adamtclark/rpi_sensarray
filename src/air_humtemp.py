#import RPi.GPIO as GPIO
import Adafruit_DHT as dht
import time
import datetime
tmp = datetime.datetime.now()

# initialize GPIO
#GPIO.setwarnings(True)
#GPIO.setmode(GPIO.BCM)

# read data using pin 12 and 1
#instance_12 = dht.DHT22(pin=12)
#instance_01 = dht.DHT22(pin=25)

#try:
#        trigger = True
#        while trigger:
#            result_12 = instance_12.read()
#            if result_12.is_valid():
#                trigger = False
#            else:
#                time.sleep(0.2)
#
#        trigger = True
#        while trigger:
#            result_01 = instance_01.read()
#            if result_01.is_valid():
#                trigger = False
#            else:
#                time.sleep(0.2)
#        print(tmp.strftime("%Y.%m.%d_%H.%M.%S")+"; "+"AT01: "+str(result_12.temperature)+"; AH01: "+str(result_12.humidity)+"; AT02: "+str(result_01.temperature)+"; AH02: "+str(result_01.humidity))
#
#except KeyboardInterrupt:
#        print("Cleanup")
#        GPIO.cleanup()

h1,t1 = dht.read_retry(dht.DHT22, 1)
h2,t2 = dht.read_retry(dht.DHT22, 12)

print(tmp.strftime("%Y.%m.%d_%H.%M.%S")+"; "+"AT01: "+str(t1)+"; AH01: "+str(h1)+"; AT02: "+str(t2)+"; AH02: "+str(h2))
