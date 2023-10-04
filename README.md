# pyflow-installation-script

## How to use the script
This script will create the directory and build the PyFlow conda environment as a sbatch job. 
When submitting the job, pass it the path to the directory you would like the conda environment 
to reside on the cluster that doesn't exist. If you pass it the path of a directory that exists,
it will error out and you will have to resubmit the job.

```{bash}
sbatch install_pyflow.sh /path/to/directory
```

## Setting up PyFlow environment
There is a helper script that is generated when running the build script. The helper script 
can be used to setup the environment to use PyFlow. The helper script is called "pyflow_env.sh"
and is stored in the PyFlow repository directory. 

```{bash}
[j.smith@login-00 PyFlow]$ ls
environment.yml  pyflow  pyflow.egg-info  pyflow_env.sh  README.md  setup.py
```

The script can be sourced in your srun job or sbatch script
```{bash}
source pyflow_env.sh
```
