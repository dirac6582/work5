#!/bin/sh
number=0
while test $number -le 14
do
      cp sample4.slurm ./water_$number/
      number=`expr $number + 1`
done