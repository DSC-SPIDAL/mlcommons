#!/bin/sh
#SBATCH --job-name=cloudmask-%j
#SBATCH --output=cloudmask-%j.log
#SBATCH --error=cloudmask-%j.error
#SBATCH --partition=gpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=59:00

## to run this say sbatch rivanna.sh

module load singularity tensorflow/2.8.0
module load cudatoolkit/11.0.3-py3.8
module load cuda/11.4.2
module load cudnn/8.2.4.15
module load anaconda/2020.11-py3.8

source activate MLBENCH

echo "# cloudmesh status=running progress=1 pid=$$"

#cd /project/bii_dsc/cloudmask/science/benchmarks/cloudmask

currentgpu=$(echo $(cms set currentgpu) | sed -e "s/['\"]//g" -e "s/^\(currentgpu=\)*//")
currentepoch=$(echo $(cms set currentepoch) | sed -e "s/['\"]//g" -e "s/^\(currentepoch=\)*//")

#python run_all_rivanna.py
cd /scratch/$USER/mlcommons/benchmarks/cloudmask/target/rivanna
python slstr_cloud.py --config ./cloudMaskConfig.yaml > output_$(echo $currentgpu)_$(echo $currentepoch).log 2>&1
#python mnist_with_pytorch.py > mnist_with_pytorch_py_$(echo $currentgpu).log 2>&1
echo "# cloudmesh status=done progress=100 pid=$$"
# python mlp_mnist.py