#!/bin/sh
number=0
 
while test $number -le 500
do
    #データの抽出
    # zueかzeuかで変わる点にも注意．(modify here)
    #grep -A 6 ' Effective charges (d Force / dE) in cartesian axis' ./water_$number/h2o_bec.wout > ./water_$number/wan.txt
    grep -A 6 ' Effective charges (d P / du) in cartesian axis' ./water_$number/h2o_bec.wout > ./water_$number/wan.txt
    #余計な行を削除
    sed -i '1,2d' ./water_$number/bec.txt
    sed -i '/atom/d' ./water_$number/bec.txt
    #データの抽出
    awk '{ print $3,$4,$5 }' ./water_$number/bec.txt > ./result/bec_$number.txt         number=`expr $number + 1`
done