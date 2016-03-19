mol new ionized.psf
mol addfile ionized.pdb
package require volutil
set all [atomselect top all]

set minmax [ measure minmax $all ]

foreach { n1 n2 } $minmax { break }
foreach { x0 y0 z0 } $n1 { break }
foreach { x1 y1 z1 } $n2 { break }

volutil 6H8.dx -crop [expr $x0+7] [expr $y0+7] [expr $z0+7] [expr $x1-7] [expr $y1-7] [expr $z1-7] -o 6H8-trimmed.dx