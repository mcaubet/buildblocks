#!/bin/bash -e
# Relion Script '5.0.0-perf' v1.6.0 (2024-09-16)



# The following Relion variables were defined
# queue         XXXqueueXXX
# mpinodes      XXXmpinodesXXX
# threads       XXXthreadsXXX
# cores         XXXcoresXXX
# dedicated     XXXdedicatedXXX
# nodes         XXXnodesXXX
# extra1        XXXextra1XXX
# extra2        XXXextra2XXX
# extra3        XXXextra3XXX
# extra4        XXXextra4XXX

#SBATCH --job-name=r500p-I-cpu
#SBATCH --partition=XXXqueueXXX
#SBATCH --ntasks=XXXmpinodesXXX
#SBATCH --hint=nomultithread
#SBATCH --export=NONE
#SBATCH --cpus-per-task=30
#SBATCH --error=XXXerrfileXXX
#SBATCH --output=XXXoutfileXXX
#SBATCH --open-mode=append
#SBATCH --time=XXXextra1XXX
#SBATCH --nodes=XXXextra3XXX
#SBATCH --mem=XXXextra4XXX
#SBATCH XXXextra2XXX

module purge
module load relion/5.0.0-perf

if [ "$(uname -m)" = "x86_64" ]; then
    module load IMOD/5.0.0
fi

# capture some system information
echo "INFO: Getting system information" >&2
echo -n " Hostname => " >&2 && hostname >&2
echo " CPU      =>" >&2 && lscpu | grep -u 'Model name' | uniq >&2
echo " MEM      =>" >&2 && free -h >&2

# OpenMP setup
export OMP_PROC_BIND=close
export OMP_PLACES=cores
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

mpirun -np "${SLURM_NTASKS}" \
  --map-by node:PE=${SLURM_CPUS_PER_TASK} \
  --bind-to core --report-bindings \
  XXXcommandXXX
