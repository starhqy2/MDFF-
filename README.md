# MDFF-quickly configuration

step1
=====
Upload your *.pdb, *.mrc files and this repository files.

step2
=====
sh mdff.sh

step3
=====
generate ionized.psf and ionized.pdb files, with newly produced **mdff-docked.pdb** file.

step4
=====
source Second_mdff_after_ionized.tcl file in **tk console**.

step5
=====
qsub namd.pbs
