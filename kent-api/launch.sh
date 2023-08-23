#!/usr/bin/bash
while :
do
	CURRENTDATE=`date +"%Y-%m-%d %T"`
	cat ./MOTD
    echo "[1;32m${CURRENTDATE} | Starting app..."
	npm run production

	CURRENTDATE=`date +"%Y-%m-%d %T"`
    echo "[1;31m${CURRENTDATE} | App suddently stopped :/"
    echo "[1;30mRestarting app in 5 seconds..."
    sleep 5
done
