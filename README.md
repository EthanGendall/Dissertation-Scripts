## Using Computational Approaches to Investigate the Working Mechanism of Human Nicotinic Acetylcholine Receptors
---

### <u>Scripts</u>
The following are the scripts used during my project: 
- tryp_script.sh
    - Used to calculate the distance between ligand and  tryptophan residue. 
    - Residues Measured:
        - W152
        - W364
        - W783
- tyr_script.sh
    - Used to calculate distance between ligand and tyrosine residue. 
    - Residues Measured: 
        - Y96
        - Y308
        - Y727
- rmsd_script.sh
    - Used to calculate the Root Mean Square Deviation (RMSD) of the system. 
- visualisation_plots.ipynb
    - Used to visualise the distances and RMSD calculated. 

- An example script using acetylcholine with S531V and S950V mutations is provided, showing a practical application. 

### <u>Environment Setup</u>
- GROMACS Version 2024.2
- Python 3.8.20 
- Bristol's HPC BluePebble4 Cluster

<p><u>File Structrue</u><p>
<pre>
    trajectories/
    |-- S531V_S950V-ach/
        |--r1/
            |--md_10ns.tpr
            |--traj_pbc_corrected.xtc
        |--r2/
        |--r3/
        |--distance_results/
            |--hist_S531V_S950V-ach.xvg
        |--index.ndx
        |--tryp_script.sh
        |--tyr_script.sh
</pre>

- Once the script has been correctly setup, use:
    - <code>sbatch tryp_script.sh</code>


### <u>Nomenclature</u>
- Residues are named after their corresponding [one-letter value.](https://www.ebi.ac.uk/pdbe/docs/roadshow_tutorial/msdtarget/AAcodes.html)
- A mutation is denoted as (X123Y), Where X123 is the previous residue and location, and Y is the newly mutated residue.  
- Several mutations were applied to carried out distance measurements. 
- Four ligands were studied, being:
<br></br>
<t>
    <table>
        <tr><td>Acetylcholine</td></tr>
        <tr><td>Cytisine</td></tr>
        <tr><td>Nicotine</td></tr>
        <tr><td>Varenicline</td></tr>
    </table>
</t>

- For each of the ligands, they were measured against both tryptophan and tyrosine in the following systems: 
<br></br>
<t>
    <table>
        <tr><td>S531V + S950V</td></tr>
        <tr><td>T109V + T321V + T740V</td></tr>
        <tr><td>T153V + T365V + T784V + S531V + S950V</td></tr>
        <tr><td>T153V + T365V + T784V</td></tr>
        <tr><td>Wild Type</td></tr>
    </table>
</t>
<br>


