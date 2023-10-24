#!/bin/bash

while true
do
    ping -c 1 10.11.50.27
    if [ $? -eq 0 ]; then
        ares-launch --device tv_ti com.tvti.app
    fi

    sleep 1   # Atraso de 1 segundo

    ping -c 1 10.11.50.240
    if [ $? -eq 0 ]; then
        ares-launch --device farmacia com.tvindoor.app
    fi

    sleep 1   # Atraso de 1 segundo
done
