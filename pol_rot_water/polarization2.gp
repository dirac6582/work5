set term pdfcairo
set output "polarization.pdf"
#set logscale xy
set xlabel "Angle [度]"
set ylabel "Dipole Moment [D]"
set xrange [0:90]
set yrange [0:0.5]

plot \
 "bec_pol3.txt" u 0:3 t "Pz by bec",\
 "bec_pol_new_20220217.txt" u 0:3 t "Pz by hokan 10°",\
 "bec_pol_new2_20220217.txt" u 0:3 t "Pz by hokan 30°"


# "bec_pol_new3_20220217.txt" u 0:3 t "Pz by hokan 90°"




#  "wan_pol3.txt" u 0:3 t "Pz by wan",\
#  "wan_pol_360_2.txt" u 0:3 t "Pz by wan rot",\
#  "bec_pol5.txt" u 0:3 t "Pz by bec rot",\
