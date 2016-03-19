cp *.mrc mdff.mrc
cp *.pdb mdff.pdb
colores mdff.mrc mdff.pdb -res 5 -nopowell
mv col_best_001.pdb mdff-docked.pdb
mkdir tmp
mv col* tmp

