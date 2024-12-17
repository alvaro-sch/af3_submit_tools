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
## TODO: ¿crear el directorio compartido 'alphafold3' y destinar todo allí?
AF3_HOME=/home/shared/alphafold/AF3/alphafold3
AF3_SIF=${AF3_HOME}/alphafold3.sif

## TODO: parametrizar el input

singularity exec \
    --nv \
    --bind ${AF3_HOME}:${AF3_HOME} \
    ${AF3_SIF} \
    python ${AF3_HOME}/run_alphafold.py \
    --model_dir=${AF3_HOME}/models \
    --db_dir=${AF3_HOME}/dbs \
    --json_path=${HOME}/alphafold3/af_input/5NJX_merged.json \
    --output_dir=${HOME}/alphafold3/af_output

echo "All done."
