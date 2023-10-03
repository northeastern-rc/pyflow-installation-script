#!/bin/bash
#SBATCH -J PyFlow_Env_Build
#SBATCH --partition=short 
#SBATCH -o PyFlow_Conda_Env.o 
#SBATCH	-e PyFlow_Conda_Env.e
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --time=4:00:00
#SBATCH --mem=8G

## Usage for the installation script
# sbatch pyflow_install.sh /path/to/store/conda_env

# This script will git clone the PyFlow repository to the current working directory
# and build the conda environment in the location you set the PYFLOW_CONDA_DIRECTORY 
# variable or enter after the script name. It will also create a helper script 
# that can be sourced to setup your PyFlow environment. This script will be saved in 
# repository directory.
# The SLURM job will create a PyFlow conda directory and will exit if this directory 
# exists. 

#-------------------------------------------------------------------------------------
# Logic to check if a directory name is passed in the script, if not 
# defaults to "/scratch/$USER/pyflow_conda".

INPUT=$1
PYFLOW_CONDA_DIRECTORY=${INPUT:="/scratch/$USER/pyflow_conda"}
echo $PYFLOW_CONDA_DIRECTORY

if [ -d "$PYFLOW_CONDA_DIRECTORY" ]; then
    echo "Please select a new directory path for the PyFlow environment"
    exit 1
fi 

mkdir -p $PYFLOW_CONDA_DIRECTORY
#-------------------------------------------------------------------------------------

module load anaconda3/2022.05
conda config --set channel_priority disabled
git clone https://github.com/kuriba/PyFlow.git
cd PyFlow
export PYFLOW_SRC=$(pwd)
conda env create --prefix=$PYFLOW_CONDA_DIRECTORY --file environment.yml
source activate $PYFLOW_CONDA_DIRECTORY
pip install -e .

touch pyflow_env.sh
echo '#!/bin/bash' >> pyflow_env.sh
echo module load anaconda3/2022.05 >> pyflow_env.sh
echo source activate $PYFLOW_CONDA_DIRECTORY >> pyflow_env.sh
echo export PYFLOW=$PYFLOW_SRC >> pyflow_env.sh
echo export SCRATCH=/scratch/$USER >> pyflow_env.sh
chmod 755 pyflow_env.sh
