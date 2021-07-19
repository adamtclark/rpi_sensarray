from w1thermsensor import W1ThermSensor
import datetime
tmp = datetime.datetime.now()

tmp1 =  W1ThermSensor.get_available_sensors()[len(W1ThermSensor.get_available_sensors())-1]
trigger = True

for sensor in W1ThermSensor.get_available_sensors():
    if tmp1.id != sensor.id:
    	print(tmp.strftime("%Y.%m.%d_%H.%M.%S")+"; "+"ST%s: %.2f" % (sensor.id, sensor.get_temperature()), end ="; ")
    else:
        print("ST%s: %.2f" % (sensor.id, sensor.get_temperature()))
        trigger = False

if trigger:
    print("\n")
