#!/bin/bash
# Basic while loop
counter=1
while [ $counter -le 3 ]
do
    python3 air_humtemp.py
    python3 soil_moist.py
    python3 soil_temp.py
    python3 gettime.py
    sleep 10
    ((counter++))
done
python3 takepic.py