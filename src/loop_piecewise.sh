#!/bin/bash

rpid=`cat ../../idinfo/sensorid`

air_humtemp_name="../data/air_humtemp_data_${rpid}.txt"
soil_moist_name="../data/soil_moist_data_${rpid}.txt"
soil_temp_name="../data/soil_temp_data_${rpid}.txt"
time_name="../data/time_data_${rpid}.txt"
rpid=`cat ../../idinfo/sensorid`

while true
do
counter=1
while [ $counter -le 30 ]
do
    python3 air_humtemp.py >> ${air_humtemp_name}
    python3 soil_moist.py >> ${soil_moist_name}
    python3 soil_temp.py >> ${soil_temp_name}
    python3 gettime.py >> ${time_name}
    #date
    #git commit -m "auto upload from ${rpid}" -a || true
    #git push || true
    sleep 30
    ((counter++))
done

python3 takepic.py
#echo photo
git add ../data/photos/* || true
git commit -m "auto photo upload from ${rpid}" -a || true
git push || true
done
