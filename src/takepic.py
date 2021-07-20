from picamera import PiCamera
from time import sleep
import datetime

camera = PiCamera()
camera.rotation = 180
camera.start_preview()
sleep(5)
tmp = datetime.datetime.now()
with open('../../idinfo/sensorid') as f:
    contents = f.read()

camera.capture('../data/photos/picture_'+contents.strip()+"_"+tmp.strftime("%Y.%m.%d_%H.%M.%S")+'.jpg')
camera.stop_preview()
