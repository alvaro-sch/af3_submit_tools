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
#SBATCH --time=00-02:30:00
## Job script

. /etc/profile

# Estas líneas nunca cambian
AF3_HOME=/home/shared/alphafold3
AF3_SIF=${AF3_HOME}/alphafold3_v300.sif
AF3_DBS=${AF3_HOME}/databases

# Estas líneas se pueden modificar para apuntar a los directorios de cada usuario
AF3_REPO=${HOME}/alphafold3   # Localización del repositorio clonado de alphafold3
AF3_MODELS=${AF3_REPO}/models # El usuario debe obtener los modelos de google por su cuenta

INPUT_PATH=${HOME}/af_input/input.json
OUTPUT_DIR=${HOME}/af_output

## TODO: parametrizar el input

singularity exec \
    --nv \
    --bind ${AF3_HOME}:${AF3_HOME} \
    ${AF3_SIF} \
    python ${AF3_REPO}/run_alphafold.py \
    --model_dir=${AF3_MODELS} \
    --db_dir=${AF3_DBS} \
    --json_path=${INPUT_PATH} \
    --output_dir=${OUTPUT_DIR}
