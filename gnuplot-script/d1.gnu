set title "Top 10 des conducteurs avec le plus de trajets"
set xlabel "Nombre de trajets"
set ylabel "Conducteurs"
set style data histograms
set style fill solid border -1
set yrange [0.5:10.5]
set xrange [0:*]
set ytics nomirror
set xtics nomirror
set grid y
set boxwidth 0.5
set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output 'top_conducteurs.png'
plot "../temp/top_conducteurs.csv" using 1:xticlabels(2) with boxes lc rgb "skyblue" title "", \
     '' using ($1):($0):($1) with labels offset char 0,1 notitle
