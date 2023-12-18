set title "Top 10 des conducteurs avec le plus de trajets"
set xlabel "Conducteurs"
set ylabel "Nombre de trajets"
set datafile separator ';'
set style data histograms
set style fill solid border -1
set yrange [*:*]
set xrange [*:*]
set ytics nomirror 
set xtics nomirror
set xtics rotate by -45
set grid y
set boxwidth 0.5 relativ
set terminal pngcairo size 1200,1000 enhanced font 'Arial,12'
set output './graph_output/top_conducteurs.png'
plot "./temp/top_conducteurs.csv" using (2*$0+1):1:xticlabels(2)  with boxes lc rgb "skyblue" notitle