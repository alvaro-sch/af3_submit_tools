# Alphafold3 en MendietaF2

⚠️ This script details the install steps for UNC | Supercómputo users
if that's not the case for you, refer to the root README at
https://github.com/alvaro-sch/af3_submit_tools/blob/main/README.md.

MendietaF2 ya tiene (casi) todos los archivos necesarios para poder
correr Alphafold3, requiriendo únicamente clonar el repositorio para
tener acceso al script para ejecutar Alphafold, y los model parameters
que no podemos proveer directamente por razones legales.

Para solicitar los model parameters, es necesario pedirselos a google
llenando un formulario, aceptando los términos y condiciones respectivos,
para más información dirigirse a
https://github.com/google-deepmind/alphafold3?tab=readme-ov-file#obtaining-model-parameters.

Hecho eso, subir los modelos obtenidos a su home en el cluster y clonar
el repositorio.

```sh
scp <ruta/a/model_params> <cluster_home>
ssh <cluser_home>
git clone https://github.com/google-deepmind/alphafold3.git && cd alphafold3
```

Para ejecutar Alphafold, referirse al submit de ejemplo disponible en
/home/shared/alphafold3/submit.sh en MendietaF2.
