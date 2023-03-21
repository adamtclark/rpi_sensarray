import RPi.GPIO as GPIO

from picamera import PiCamera
from time import sleep
import datetime


GPIO.setmode(GPIO.BCM)

#GPIO  5  als output
GPIO.setup(6, GPIO.OUT)
GPIO.setup(5, GPIO.OUT)


#GPIO 5 auf HIGH setzen
GPIO.output(5, GPIO.HIGH)

#GPIO 6 auf LOW
GPIO.output(6, GPIO.LOW)

sleep(2)


camera = PiCamera()
camera.start_preview()
sleep(5)
tmp = datetime.datetime.now()
with open('../../idinfo/sensorid') as f:
    contents = f.read()

camera.capture('../data/photos/picture_RGB_'+contents.strip()+"_"+tmp.strftime("%Y.%m.%d_%H.%M.%S")+'.jpg')
camera.stop_preview()

sleep(2)

#change direction
GPIO.output(5, GPIO.LOW)
GPIO.output(6, GPIO.HIGH)

sleep(2)

#remove all GPIO settings
GPIO.cleanup()

