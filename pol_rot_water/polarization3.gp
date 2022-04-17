#
#
#


set term pdfcairo
set output "polarization_0418_2.pdf"
#set logscale xy
set xlabel "Angle [度]"
set ylabel "Dipole Moment [D]"
set xrange [0:90]

plot \
 "bec_pol5.txt" u 0:3 t "Pz by bec rot",\
 "wan_pol_360_2.txt" u 0:3 t "Pz by wan rot",\
 "wan_pol3.txt" u 0:3 t "Pz by wan",\
 "bec_pol3.txt" u 0:3 t "Pz by bec",\
 "bec_pol_new_20220217.txt" u 0:3 t "Pz by hokan",\
 "bec_pol_360_Zr.txt" u 0:3 t "Pz by Zr"