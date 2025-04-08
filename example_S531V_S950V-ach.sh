#
# Exampe script used to analyse ligand-residue distances for the S531V, S950V
# mutations with acetylcholine as the ligand. Highlighting necessary input files
# required to run the simulation. 
# 
# Request necessary computational resources to run gromacs commands. 
#!/bin/bash
#SBATCH --job-name=S531V_S950V_distance
#SBATCH --output=/user/work/yv22391/Project/Data/trajectories_for_ethan/S531V_S950V-ach/S531V_S950V_distance_%j.out
#SBATCH --error=/user/work/yv22391/Project/Data/trajectories_for_ethan/S531V_S950V-ach/S531V_S950V_distance_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=03:00:00
#SBATCH --account=CHEM021482


# Load necessary modules to run gmx_mpi commands. 
module load openmpi/5.0.3
module load gromacs

# Define the directories for inputs and outputs for this system. 
BASE_DIR="/user/work/yv22391/Project/Data/trajectories_for_ethan/S531V_S950V-ach"
OUTPUT_DIR1="${BASE_DIR}/distances_Tryp/1"
OUTPUT_DIR2="${BASE_DIR}/distances_Tryp/2"
OUTPUT_DIR3="${BASE_DIR}/distances_Tryp/3"

# One run simulation per repeat folder (r1, r2, r3)
for rep in r1 r2 r3
do

    echo ""
    echo "R${rep}"
    echo "all residues"

    mkdir -p ${OUTPUT_DIR1}/xvg/
    mkdir -p ${OUTPUT_DIR2}/xvg/
    mkdir -p ${OUTPUT_DIR3}/xvg/

    # Run distance command with necessary inputs, selecting the appropriate ligand and residue.
    # Repeat for each tryptophan residue in each binding site. 
    gmx_mpi distance -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                     -oall ${OUTPUT_DIR1}/xvg/${rep}_S531V_S950V-ach.xvg \
                     -oh ${OUTPUT_DIR1}/xvg/hist_${rep}_S531V_S950V-ach.xvg \
                     -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                     -n ${BASE_DIR}/index.ndx \
                     -select 'group "positiveN_ACH1" plus com of group "W152_sidechain"' \
                     -len 1.0 \
                     -binw 0.01

    gmx_mpi distance -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                    -oall ${OUTPUT_DIR2}/xvg/${rep}_S531V_S950V2.xvg \
                    -oh ${OUTPUT_DIR2}/xvg/hist_${rep}_S531V_S950V2.xvg \
                    -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                    -n ${BASE_DIR}/index.ndx \
                    -select 'group "positiveN_ACH2" plus com of group "W364_sidechain"' \
                    -len 1.0 \
                    -binw 0.01

    gmx_mpi distance -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                     -oall ${OUTPUT_DIR3}/xvg/${rep}_S531V_S950V3.xvg \
                     -oh ${OUTPUT_DIR3}/xvg/hist_${rep}_S531V_S950V3.xvg \
                     -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                     -n ${BASE_DIR}/index.ndx \
                     -select 'group "positiveN_ACH3" plus com of group "W783_sidechain"' \
                     -len 1.0 \
                     -binw 0.01


    echo ""
    echo ""

done
 
   
echo "KEEP CALM! No problems with this script..."

exit
