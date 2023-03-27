from w1thermsensor import W1ThermSensor
import datetime
tmp = datetime.datetime.now()


print(tmp.strftime("%Y.%m.%d_%H.%M.%S"), "; ")

for sensor in W1ThermSensor.get_available_sensors():
    print("ST %s: %.2f" % (sensor.id, sensor.get_temperature()))
 

