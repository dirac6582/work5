#!/bin/sh
number=0
 
while test $number -le 500
do
    #データの抽出
    grep -A 4 'Final State' ./water_$number/h2o_bec.wout > ./water_$number/wan.txt
    #余計な行を削除
    sed -i '1d' ./water_$number/wan.txt
    #データの抽出
    awk '{ print $7,$8,$9 }' ./water_$number/wan.txt > ./result/wan2_$number.txt
    sed -i -e 's/,/ /g' ./result/wan2_$number.txt
         number=`expr $number + 1`
done