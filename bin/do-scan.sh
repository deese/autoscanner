#!/bin/bash
OUTPUT_FOLDER="/usr/share/hassio/share/paperless/consume"
DEVICE="airscan:e0:HP ENVY Inspire 7200 series [D30663]"
DATE=$(/usr/bin/date +"%Y-%m-%d-%H%M%S")
PAGES=1
SCANIMAGE=/usr/bin/scanimage

if [ -z $1 ]; then
	echo usage: $0 user [pages]
	exit
fi

if [ ! -z $2 ]; then
	if [[ $2 != ?(-)+([0-9]) ]]; then
		echo Page must be an integer.
		exit
	fi
	PAGES=$2
fi

FNAME=$DATE-ha-scan-$1.pdf

if [ $PAGES -gt 1 ]; then
	FNAME=${FNAME%.*}"-%d.pdf"
	$SCANIMAGE --format=pdf --device "$DEVICE" --batch-prompt --batch="/tmp/$FNAME"
else
	$SCANIMAGE --format=pdf --output-file /tmp/$FNAME --device "$DEVICE"
fi
exit
if [ -f "/tmp/$FNAME" ]; then
	mv /tmp/$FNAME $OUTPUT_FOLDER
	echo "Scan completed."
else
	echo "File doesn't exist: $FNAME"
fi

