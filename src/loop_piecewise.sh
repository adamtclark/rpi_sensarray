#!/bin/bash

counter=1
while [ $counter -le 10 ]
do
    python3 air_humtemp.py
    python3 soil_moist.py
    python3 soil_temp.py
    python3 gettime.py
    sleep 10
    ((counter++))
done

python3 takepic.py

rpid=`cat ../../idinfo/sensorid`
git commit -m "auto upload from ${rpid}" -a
