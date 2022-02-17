gnuplot> set xlabel "steps[times 10]"
gnuplot> set ylabel "dipole-moment_y"
gnuplot> replot "bec_pol.txt" u 1:3 ps 2
gnuplot> plot "wan_pol.txt" u 1:3 ps 2
gnuplot> replot "bec_pol.txt" u 1:3 ps 2
gnuplot> plot "wan_pol.txt" u 1:3 ps 2 t "wan"
gnuplot> replot "bec_pol.txt" u 1:3 ps 2 "bec"

gnuplot> plot "wan_pol.txt" u 1:3 ps 2 t "wan", "bec_pol.txt" u 1:3 ps 2 "bec"
                                                                         ^
         unexpected or unrecognized token: "bec"

gnuplot> replot "bec_pol.txt" u 1:3 ps 2 t "bec"
gnuplot> plot "wan_pol.txt" u 1:3 ps 2 t "wan"
gnuplot> replot "bec_pol.txt" u 1:3 ps 2 t "bec"
gnuplot> set ylabel "dipole-moment_x"
gnuplot> plot "wan_pol.txt" u 1:3 ps 2 t "wan"
gnuplot> plot "wan_pol.txt" u 1:2 ps 2 t "wan"
gnuplot> replot "bec_pol.txt" u 1:2 ps 2 t "bec"
gnuplot> exit