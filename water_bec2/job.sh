#!/bin/sh
number=0
 
# 現在のdirを取得
CURRENT_DIR=$(pwd)
 
while test $number -le 30
do
 
    #working dirへ移動
    cd ${CURRENT_DIR}/water_$number/
 
    #jobファイルの実行
    sbatch sample4.slurm
 
    number=`expr $number + 1`
done