###
### Replace XXX here with name of system, e.g. ligand used and mutations measured. 
###

###
### Processing power requested for Bristols' HPC BluePebble4 cluster. 
###

#!/bin/bash
#SBATCH --job-name=XXX_distance
#SBATCH --output=/path/to/directory/XXX_distance_%j.out
#SBATCH --error=/path/to/directory/XXX_distance_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=03:00:00
#SBATCH --account=CHEM021482

###
### Loading modules necessary to run gmx_mpi commands.
### 

module load openmpi/5.0.3
module load gromacs

###
### Script used to measure distance of protonated nitrogen on ligand 
### to the specified tyrosine residues for each repeat. 
### One seperate distance command per binding site. 
###

BASE_DIR="/path/to/directory/"
OUTPUT_DIR1="${BASE_DIR}/tyrosine_distances/1"
OUTPUT_DIR2="${BASE_DIR}/tyrosine_distances/2"
OUTPUT_DIR3="${BASE_DIR}/tyrosine_distances/3"

for rep in r1 r2 r3
do

    echo ""
    echo "R${rep}"
    echo "all residues"

    mkdir -p ${OUTPUT_DIR1}/xvg/
    mkdir -p ${OUTPUT_DIR2}/xvg/
    mkdir -p ${OUTPUT_DIR3}/xvg/

    ###
    ### Replace "Lig" here with ligand used in simulation, for this study, 
    ### acetylcholine, cytisine, nicotine, and varenicline were used. 
    ###

    gmx_mpi distance -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                     -oall ${OUTPUT_DIR1}/xvg/${rep}_XXX-Lig.xvg \
                     -oh ${OUTPUT_DIR1}/xvg/hist_${rep}_XXX-Lig.xvg \
                     -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                     -n ${BASE_DIR}/index.ndx \
                     -select 'group "positiveN_Lig1" plus com of group "Y96_sidechain"' \
                     -len 1.0 \
                     -binw 0.01

    gmx_mpi distance -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                    -oall ${OUTPUT_DIR2}/xvg/${rep}_XXX_Lig2.xvg \
                    -oh ${OUTPUT_DIR2}/xvg/hist_${rep}_XXX_Lig2.xvg \
                    -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                    -n ${BASE_DIR}/index.ndx \
                    -select 'group "positiveN_Lig2" plus com of group "Y308_sidechain"' \
                    -len 1.0 \
                    -binw 0.01

    gmx_mpi distance -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                     -oall ${OUTPUT_DIR3}/xvg/${rep}_XXX_Lig3.xvg \
                     -oh ${OUTPUT_DIR3}/xvg/hist_${rep}_XXX_Lig3.xvg \
                     -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                     -n ${BASE_DIR}/index.ndx \
                     -select 'group "positiveN_Lig3" plus com of group "Y727_sidechain"' \
                     -len 1.0 \
                     -binw 0.01


    echo ""
    echo ""

done
 
   
echo "KEEP CALM! No problems with this script..."

exit
