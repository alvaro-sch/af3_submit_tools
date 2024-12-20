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
## TODO: solicitar el directorio compartido 'alphafold3'
AF3_SHARED_HOME=/home/shared/alphafold3
AF3_SIF=${AF3_SHARED_HOME}/alphafold3_v300.sif

# Esta línea es a modificar por el usuario, dirigir a su copia del repositorio de AF3
YOUR_AF3_DIRECTORY=/${HOME}/alphafold3

## TODO: parametrizar el input

singularity exec \
    --nv \
    --bind ${AF3_SHARED_HOME}:${AF3_SHARED_HOME} \
    ${AF3_SIF} \
    python ${YOUR_AF3_DIRECTORY}/run_alphafold.py \
    --model_dir=${YOUR_AF3_DIRECTORY}/models \ # Nota: se espera que el usuario consiga los modelos por su cuenta
    --db_dir=${AF3_SHARED_HOME}/databases \
    --json_path=${HOME}/af_input/input.json \ 
    --output_dir=${YOUR_AF3_DIRECTORY}/af_output

echo "All done."
