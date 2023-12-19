set title "Top 10 trajets les plus longs"
set xlabel "Identifiant du trajet"
set ylabel "Distance en km"
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
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './graph_output/top_trajets.png'
plot "./temp/trajets_long.csv" using (2*$0+1):2:xticlabels(1)  with boxes lc rgb "skyblue" notitle