#!/bin/bash

rpid=`cat ../../idinfo/sensorid`

air_humtemp_name="../data/air_humtemp_data_${rpid}.txt"
soil_moist_name="../data/soil_moist_data_${rpid}.txt"
soil_temp_name="../data/soil_temp_data_${rpid}.txt"
time_name="../data/time_data_${rpid}.txt"
co2_name="../data/co2_data_${rpid}.txt"

sudo pigpiod

while true
do

python3 takepic_NIR.py
python3 takepic_RGB.py

counter=1
while [ $counter -le 30 ]
do
    date
    python3 air_humtemp.py >> ${air_humtemp_name}
    python3 soil_moist_array.py >> ${soil_moist_name}
    python3 soil_temp.py >> ${soil_temp_name}
    python3 gettime.py >> ${time_name}
    python3 co2_reading/get_co2.py >> ${co2_name}
    sleep 120
    ((counter++))
done

rpid=`cat ../../idinfo/sensorid`
git add ../data/photos/*
git commit -m "auto upload from ${rpid}" -a
git push
done
