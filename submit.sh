#!/bin/bash
## Directivas SBATCH que configuran el trabajo
## Nombre del trabajo
#SBATCH --job-name=af3_test
## Cola donde encolar (short: <2h, multi para el resto)
#SBATCH --partition=multi
## Cantidad de procesos MPI a lanzar por cada nodo (MPI puro: 64)
#SBATCH --ntasks=1
## Reservar medio nodo, AF3 usa únicamente 1 GPU
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
## Tiempo de ejecucion limite (dias-horas:minutos:segundos)
#SBATCH --time=2-00:00:00
## Job script

. /etc/profile

# Estas líneas nunca cambian
## TODO: cambiar las líneas hasta que exista este archivo
AF3_HOME=/home/shared/alphafold3
AF3_SIF=${AF3_HOME}/alphafold3.sif

module load gcc/11.2.0 nvhpc/22.3 #cargar módulos necesarios

## TODO: parametrizar el input

singularity exec \
    --nv \
    --bind ${AF3_HOME}:${AF3_HOME} \
    ${AF3_SIF} \
    python run_alphafold.py \
    --model_dir=${AF3_HOME}/alphafold3 \
    --db_dir=${AF3_HOME}/public_databases \
    --json_path=${HOME}/alphafold3/af_input/5NJX_merged.json \
    --output_dir=${HOME}/alphafold3/af_output

echo "All done."
