#!/bin/bash

rpid=`cat ../../idinfo/sensorid`

air_humtemp_name="../data/air_humtemp_data_${rpid}.txt"
soil_moist_name="../data/soil_moist_data_${rpid}.txt"
soil_temp_name="../data/soil_temp_data_${rpid}.txt"
time_name="../data/time_data_${rpid}.txt"

while true
do
counter=1
while [ $counter -le 10 ]
do
    date
    python3 air_humtemp.py >> ${air_humtemp_name}
    python3 soil_moist.py >> ${soil_moist_name}
    python3 soil_temp.py >> ${soil_temp_name}
    python3 gettime.py >> ${time_name}
    sleep 10
    ((counter++))
done

python3 takepic.py

rpid=`cat ../../idinfo/sensorid`
git add ../data/photos/*
git commit -m "auto upload from ${rpid}" -a
git push
done
