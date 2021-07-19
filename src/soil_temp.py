from w1thermsensor import W1ThermSensor
tmp1 =  W1ThermSensor.get_available_sensors()[len(W1ThermSensor.get_available_sensors())-1]

for sensor in W1ThermSensor.get_available_sensors():
    if tmp1.id != sensor.id:
    	print("ST%s: %.2f" % (sensor.id, sensor.get_temperature()), end ="; ")
    else:
        print("ST%s: %.2f" % (sensor.id, sensor.get_temperature()))