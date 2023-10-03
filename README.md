# pyflow-installation-script

## How to use the script
This script will create the directory and build the PyFlow conda environment as a sbatch job. 
When submitting the job, pass it the path to the directory you would like the conda environment 
to reside on the cluster that doesn't exist. If you pass it the path of a directory that exists,
it will error out and you will have to resubmit the job.

```{bash}
sbatch install_pyflow.sh /path/to/directory
```
