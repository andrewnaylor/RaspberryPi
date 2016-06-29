#!/bin/sh
DATE=`date +%Y-%m-%d`
EXT="_temp.csv"
FILE=log.txt
LOC=/home/pi
DIR=log_data

mv $LOC/$FILE $LOC/$DIR/$DATE$EXT
