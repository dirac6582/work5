#!/bin/sh
# polファイルのデータを抽出

# 書き出されているステップ数
number=15
# 最初にひとつ引く
number=`expr $number - 1`

de=0
# numberが大きい方から始める
while test $number -ge 0
do
    de=$((4*number+1))
    echo $de
    #4N+1行目を削除
    sed -i -e ''${de}'d' h2o_mol.pos


    number=`expr $number - 1`
done
