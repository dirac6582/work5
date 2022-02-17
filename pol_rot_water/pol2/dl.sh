#!/bin/bash

# folder prefix
PREFIX=water

# folder name
FOLDER=md_h2o_bec
# number
number=0
while test $number -le 14
do
    expect -c "
      set timeout 1
      spawn scp amano@sauron:/home/amano/research/yuuden/${FOLDER}/${PREFIX}_$number/bec_*.txt ./
      expect \"password:\"
      send \"amano\n\"
      interact
    "
    number=`expr $number + 1`
done
