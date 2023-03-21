import RPi.GPIO as GPIO
import time

exec(open("takepic_NIR.py").read())

GPIO.setmode(GPIO.BCM)

#GPIO  5  als output
GPIO.setup(6, GPIO.OUT)
GPIO.setup(5, GPIO.OUT)


#GPIO 5 auf HIGH setzen
GPIO.output(5, GPIO.HIGH)

#GPIO 6 auf LOW
GPIO.output(6, GPIO.LOW)

time.sleep(2)

exec(open("takepic_RGB.py").read())

time.sleep(2)

#change direction
GPIO.output(5, GPIO.LOW)
GPIO.output(6, GPIO.HIGH)

time.sleep(2)

#remove all GPIO settings
GPIO.cleanup()
