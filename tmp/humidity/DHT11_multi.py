import RPi.GPIO as GPIO
import dht11
import time
import datetime

# initialize GPIO
GPIO.setwarnings(True)
GPIO.setmode(GPIO.BCM)

# read data using pin 12 and 1
instance_12 = dht11.DHT11(pin=12)
instance_01 = dht11.DHT11(pin=1)

try:
  while True:
      result_12 = instance_12.read()
      result_01 = instance_01.read()
      if result_12.is_valid():
          print("Last valid input: " + str(datetime.datetime.now()))

          print("Temperature 01: %-3.1f C" % result_12.temperature)
          print("Humidity 01: %-3.1f %%" % result_12.humidity)

          if result_01.is_valid():
              print("Temperature 02: %-3.1f C" % result_01.temperature)
              print("Humidity 02: %-3.1f %%" % result_01.humidity)

      time.sleep(10)

except KeyboardInterrupt:
    print("Cleanup")
    GPIO.cleanup()
