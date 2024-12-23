# AF3 Cluster Tools

This repo contains information to build and run Alphafold 3 mainly in HPC clusters.

**UNC | Supercómputo** users don't need to do the full installation,
follow the [UNC | Supercómputo Users](#unc--supercómputo-users) steps
instead.

## Full Installation

The installation will (most likely) require to perform some steps on
your host computer, and finish in the remote computer (wherever you
will run AF3).

Before installing it's advised to let the cluster administrators know about
the installation of AF3, needing a container (`apptainer/singularity`)
and around 2~3 TiB of storage for the databases, maybe discuss the need of
a shared directory so that many users can use them.

### Building the container

In contrast with AF2, AF3 uses Docker, which may not be available in
all clusters since it requires users to have root access.
Instead we will be building a `.sif` to be runnable with
**singluarity/apptainer** which doesn't have such restrictions.
Docker is still required for this process but it can be done anywhere
you have root access.

Perform the following steps in a computer you have access to Docker.

```sh
git clone https://github.com/google-deepmind/alphafold3.git
docker build -t alphafold3 -f docker/Dockerfile .
docker save -o alphafold3.tar alphafold3
```

We can now build the `.sif` file, there's no more docker required,
you may transfer `alphafold3.tar` to the cluster and follow the rest of
the steps there, provided it has `apptainer/singularity` installed.

```sh
# transfer alphafold3.tar to the remote computer
# optional but you may as well move to the cluster now
scp alphafold3.tar <cluster_home>
ssh <cluster_home>

# build the sif file
singularity build alphafold3.sif docker-archive://alphafold3.tar
```

### Model parameters and Databases

From now on all steps have to be done where AF3 will be executed, if you
didn't transfer the files from the previous step, now is the time to do
that.

To obtain the model parameters, one must request them to google
filling a form, explicitly abiding to the respective terms and
conditions, for further information refer to
[AF3: Obtaining Model Parameters](https://github.com/google-deepmind/alphafold3?tab=readme-ov-file#obtaining-model-parameters).

For the last step you only need to get the databases, beware that they
weight 2~3 TiB, it's adviced to notify the sysadmins if you plan to run
this in a cluster.

The databases can be obtained using the `fetch_databases.sh` script.
Inside the cluster, you will need to clone the AF3 repo again.

```sh
git clone https://github.com/google-deepmind/alphafold3.git && cd alphafold3
./fetch_databases.sh
```

With that you're good to go to run Alphafold 3, for cluster users there's
an [example submit script](./submit.sh) made specifically for UNC
Supercómputo, feel free to modify it to follow your cluster requirements.

## UNC | Supercómputo Users

MendietaF2 from UNC Supercómputo already has `alphafold3.sif` and the
databases installed so most of the previous steps can be skipped,
requiring no steps involving the host machine and docker.

Firstly, request the model parameters to google, that is done by
filling a form, explicitly abiding to the respective terms and
conditions, for further information refer to
[AF3: Obtaining Model Parameters](https://github.com/google-deepmind/alphafold3?tab=readme-ov-file#obtaining-model-parameters).

After that just login to the cluster and clone the repository to have
access to the `run_alphafold.py` script.

```sh
ssh <cluster_home>
git clone https://github.com/google-deepmind/alphafold3.git && cd alphafold3
```

With that you can use the [example submit script](./submit.sh) to run
Alphafold.
