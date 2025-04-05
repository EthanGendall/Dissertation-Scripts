###
### Replace XXX with name of system, e.g. ligand used and mutations
### applied/measured
###


###
### Processing power requested from Bristol's HPC BluePebble4 cluster. 
###

#!/bin/bash
#SBATCH --job-name=XXX_Lig_rmsd
#SBATCH --output=/path/to/directory/XXX_Lig/XXX_Lig_rmsd_%j.out
#SBATCH --error=/path/to/directory/XXX_Lig/XXX_Lig_rmsd_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=03:00:00
#SBATCH --account=CHEM021482

### Loading modules necessary to run gmx_mpi commands. 
module load openmpi/5.0.3
module load gromacs

# Define base and output directories
BASE_DIR="/path/to/directory/XXX_Lig"
OUTPUT_DIR="${BASE_DIR}/rmsd_results"

mkdir -p ${OUTPUT_DIR}/xvg/

for rep in r1 r2 r3
do
    echo "Processing RMSD for replicate ${rep}"

    ###
    ### Script used to calculate room mean square deviation, using the backbone (4 4)
    ### of the protein as the frame of reference. 
    ###

    gmx_mpi rms -f ${BASE_DIR}/${rep}/traj_pbc_corrected.xtc \
                -s ${BASE_DIR}/${rep}/md_10ns.tpr \
                -n ${BASE_DIR}/index.ndx \
                -o ${OUTPUT_DIR}/xvg/${rep}_XXX_Lig_rmsd.xvg \
                -fit rot+trans <<EOF
4 4
EOF

    echo "Completed RMSD analysis for replicate ${rep}"
done

echo "RMSD analysis completed successfully"
exit
