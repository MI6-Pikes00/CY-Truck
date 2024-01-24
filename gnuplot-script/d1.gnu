# Configuration du terminal de sortie et de la taille du graphique
set terminal pngcairo size 1080,1920 enhanced font 'Arial,12'
set output './images/graph_d1.png'

# Séparateur de champs pour un fichier CSV
set datafile separator ';'

# Titre du graphique
set ylabel "Top 10 des conducteurs avec le plus de trajets"

# Axe x (conducteurs)
set xlabel "Conducteurs"
set xtics right rotate by 90 nomirror

# Axe y (nombre de trajets)
set y2label "Nombre de trajets"
set y2range [100:*]
set y2tics center rotate by 90
set tics out
set grid y

# Style des données en histogrammes
set style data histograms
set style fill solid border -1
set boxwidth 0.5
set tmargin 2.5

# Tracé du graphique
plot "./temp/top_conducteurs.csv" using 1:xtic(2) with boxes lc rgb "skyblue" axis x1y2 notitle
