# scf 
mpirun -np 24 pw.x < h2o_bec.pw.in > h2o_bec.pw.out 2>&1
# ph 
mpirun -np 24 ph.x < h2o_bec.pw.in > h2o_bec.pw.out 2>&1
# pre wannier90
mpirun -np 24  wannier90.x -pp h2o_bec 2>&1
# pw2wan
mpirun -np 24  pw2wannier90.x < h2o_bec.pw2wan > pw2wan.out 2>&1
# wannier90
mpirun -np 24  wannier90.x h2o_bec 2>&1