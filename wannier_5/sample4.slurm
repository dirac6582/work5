#!/bin/bash
#SBATCH -J JobName            # Job name
#SBATCH -o JobOutput_%j.out   # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1                  # Total number of nodes requested
#SBATCH -n 24                 # Total number of mpi tasks requested
#SBATCH -t 72:00:00           # Run time (hh:mm:ss) - 1.5 hours
#SBATCH -p sky6126            # partition name (node name) sky6126


# tanryo_test2でborn effective chargeの計算を行う．


# Assuming module load prun (as well as any mpi module e.g. impi)
module load oneapi/compiler
module load oneapi/mkl
module load oneapi/mpi


# unlimit the maximum number of the processors
ulimit -s unlimited



# output calculation settings
echo
echo    START DATE       : `date`
echo   SLURM_JOBID       : ${SLURM_JOBID}
echo SLURM_SUBMIT_DIR    : ${SLURM_SUBMIT_DIR}
echo SLURM_CPUS_PER_TASK : ${SLURM_CPUS_PER_TASK}
echo   SLURM_NTASKS      : ${SLURM_NTASKS}

#echo   PBS_NODENUM    : ${PBS_NODENUM}
#echo    PBS_O_HOST    : ${PBS_O_HOST}
#echo    PBS_SERVER    : ${PBS_SERVER}
#echo   PBS_O_QUEUE    : ${PBS_O_QUEUE}
#echo   PBS_ARRAYID    : ${PBS_ARRAYID}
#echo     PBS_QUEUE    : ${PBS_QUEUE}
#echo      used_nodes  : ${used_nodes}
#echo       num_nodes  : ${num_nodes}
#echo   proc_per_node  : ${proc_per_node}
#echo        num_proc  : ${num_proc}
echo     hostname     : `hostname`
echo


#
#######################  End of Initialization   ##############################
#

# move to working dir
cd $SLURM_SUBMIT_DIR


# which ifort


# コンパイル
# intel版のicpcだとうまくいかない？
#/usr/bin/g++
#/usr/bin/g++ -g ./dmqc_original.cpp -o ./dmqc_original
#icpc dmqc_original4.cpp -o dmqc_original4 -g -mkl


echo   SLURM_JOBID       : ${SLURM_JOBID}


# 保存用にdirを作成
mkdir ${SLURM_JOBID}


####################  Input (modify here) ######################################
scf=tanryo


####################  Input Files (modify here)######################################
#

# phin= ${とするとダメだった．spaceがあるとまずい？
scfin=${scf}.pw.in
phin=${scf}.ph.in
nscfin=${scf}.nscf.in


echo
echo "scf file name "${scfin}
#echo "nscf file name "${nscfin}
echo

#check if input file exists
if [ -f ${scfin} ]; then
    echo
    echo "入力ファイルが存在しています．"
    echo
else
    echo
    echo "!!!error:::入力ファイルが存在しません!!!"
    echo
    exit 1;
fi

####################  Output Files ######################################
#
scfout=${scf}.pw.out
phout=${scf}.ph.out
nscfout=${scf}.nscf.out

echo "scf file name "${scfout}
#echo "nscf file name "${nscfout}


# scfの実行
# 並列数の指定をもっと自動化できるはず．
#mpirun -machinefile ${SLURM_JOB_NODELIST} -np 16  ~/src/qe-6.4.1/bin/pw.x < ${scfin} > ${scfout} 2>&
mpirun -np ${SLURM_NTASKS}  ~/src/qe-6.4.1/bin/pw.x < ${scfin} > ${scfout} 2>&1


#scf calculation error check
check=$?

# ここ，-eqから=にしたら動くようになった．
# https://qiita.com/27ma4_ryusei/items/ae28c83777ea2d893f91
if [ check = 1 ]; then
    echo
    echo "!!!!! error:: scf calculation fails!!!!"
    echo
fi    

echo
echo "################"
echo "SCF calculation is DONE"
echo "################"
echo "Total Energy は"
grep ! ${scfout}
echo "Fermi Energyは"
grep "Fermi" ${scfout}



# scfの実行
mpirun -np ${SLURM_NTASKS}  ~/src/qe-6.4.1/bin/wannier90.x -pp tanryo 2>&1

#nscf
mpirun -np ${SLURM_NTASKS}  ~/src/qe-6.4.1/bin/pw2wannier90.x < tanryo.pw2wan > pw2wan.out 2>&1

#
mpirun -np ${SLURM_NTASKS}  ~/src/qe-6.4.1/bin/wannier90.x tanryo 2>&1



#nscf
#mpirun -np ${SLURM_NTASKS}  ~/src/qe-6.4.1/bin/pw.x < ${nscfin} > ${nscfout} 2>&1


echo
echo "PROGRAM END"
echo    END DATE       : `date`
