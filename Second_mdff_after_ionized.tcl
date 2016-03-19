mol new ionized.psf
mol addfile ionized.pdb
# mrc to dx
package require mdff
mdff griddx -i mdff.mrc -o mdff-grid.dx

# trim dx into water box
package require volutil
set all [atomselect top all]

set minmax [ measure minmax $all ]

foreach { n1 n2 } $minmax { break }
foreach { x0 y0 z0 } $n1 { break }
foreach { x1 y1 z1 } $n2 { break }

volutil mdff-grid.dx -crop [expr $x0+7] [expr $y0+7] [expr $z0+7] [expr $x1-7] [expr $y1-7] [expr $z1-7] -o mdff-grid-trimmed.dx

#namd files product
mdff gridpdb -psf ionized.psf -pdb ionized.pdb -o ionized-grid.pdb

package require ssrestraints
ssrestraints -psf ionized.psf -pdb ionized.pdb -o ionized-extrabonds.txt -hbonds -k_prot 100
cispeptide restrain -o ionized-extrabonds-cispeptide.txt 
chirality restrain -o ionized-extrabonds-chirality.txt

mdff setup -pbc -o adk-solvent -psf ionized.psf -pdb ionized.pdb -griddx mdff-grid-trimmed.dx -gridpdb ionized-grid.pdb -extrab {ionized-extrabonds.txt ionized-extrabonds-cispeptide.txt ionized-extrabonds-chirality.txt} -gscale 1 -numsteps 2000000 -minsteps 20000 -temp 310
mdff setup -pbc -o adk-solvent -psf ionized.psf -pdb ionized.pdb -griddx mdff-grid-trimmed.dx -gridpdb ionized-grid.pdb -extrab {ionized-extrabonds.txt ionized-extrabonds-cispeptide.txt ionized-extrabonds-chirality.txt} -gscale 10 -numsteps 0 -minsteps 200000 -temp 310 -step 2