# Terminal de sortie pour l'image PNG
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './graph_output/top_conducteurs.png'

# Format du fichier de données
set datafile separator ';'

# Titre du graphique
set title "Top 10 des conducteurs avec le plus de trajets"

# Axe x (conducteurs)
set xlabel "Conducteurs"
set xtics rotate by -45

# Axe y (nombre de trajets)
set ylabel "Nombre de trajets"
set yrange [*:*]
set ytics nomirror 
set grid y

# Style des données en histogrammes
set style data histograms
set style fill solid border -1
set boxwidth 0.5 relative


# Tracé du graphique
plot "./temp/top_conducteurs.csv" using (2*$0+1):1:xticlabels(2) with boxes lc rgb "skyblue" notitle
