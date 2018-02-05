#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -t 10:00

module load intel
#make stream icc

computer_name='perseus'
max_threads=28
stream_summary_filename="${computer_name}_STREAM_results.txt"

echo "#n copy                              scale                              add                                triad" >> ${stream_summary_filename}
echo "#Best MB/s Avg time Min time Max time" >> ${stream_summary_filename}
for nthreads in $(seq 1 ${max_threads})
do
    export OMP_NUM_THREADS=$nthreads
    ./stream.omp.AVX2.18M.20x.icc 2>&1 | tee bare_STREAM_output.txt
    echo -n "${nthreads} " >> ${stream_summary_filename}
    tail -n 7 bare_STREAM_output.txt | head -n 4 | sed 's/[^.0-9][^.0-9]*/ /g' | xargs  >> ${stream_summary_filename}
done
