rpid=`cat ../../idinfo/sensorid`

air_humtemp_name="../data/air_humtemp_data_${rpid}.txt"
soil_moist_name="../data/soil_moist_data_${rpid}.txt"
soil_temp_name="../data/soil_temp_data_${rpid}.txt"
time_name="../data/time_data_${rpid}.txt"

if [ ! -f "$air_humtemp_name" ]; then
    touch ${air_humtemp_name}
fi
if [ ! -f "$soil_moist_name" ]; then
    touch ${soil_moist_name}
fi
if [ ! -f "$soil_temp_name" ]; then
    touch ${soil_temp_name}
fi
if [ ! -f "$time_name" ]; then
    touch ${time_name}
fi
