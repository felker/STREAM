#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -t 10:00

module load intel
#make stream icc

for nthreads in 1 2 # 3 4 5 6 7 8
do
    export OMP_NUM_THREADS=$nthreads
    ./stream.omp.AVX2.18M.20x.icc
done
