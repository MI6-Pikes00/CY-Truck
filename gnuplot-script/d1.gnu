# Terminal de sortie pour l'image PNG
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './images/graph_d1.png'

# Format du fichier de données
set datafile separator ';'

# Titre du graphique
set title "Top 10 des conducteurs avec le plus de trajets"

# Axe x (conducteurs)
set xlabel "Nombre de trajets"
set xrange [*:*]
set xtics rotate by -45

# Axe y (nombre de trajets)
set ylabel "Conducteurs"
set yrange [*:*]
set ytics nomirror 
set grid y

# Style des données en histogrammes
set style data histograms
set style fill solid border -1
set boxwidth 0.5

# Tracé du graphique
plot "./temp/top_conducteurs.csv" using 1:xtic(2) with boxes lc rgb "skyblue" notitle
