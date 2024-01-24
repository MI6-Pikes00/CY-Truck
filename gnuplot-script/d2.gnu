# Configuration du terminal de sortie et de la taille du graphique
set terminal pngcairo size 1080,1920 enhanced font 'Arial,12'
set output './images/graph_d2.png'

# Séparateur de champs pour un fichier CSV
set datafile separator ';'

# Titre du graphique
set ylabel "Top 10 des conducteurs avec le plus de km parcourus"

# Axe x (conducteurs)
set xlabel "Conducteurs"
set xtics right rotate by 90 nomirror

# Axe y2 (nombre de kilomètres)
set y2label "Nombre de kilomètres"
set y2range [110000:*]
set y2tics center rotate by 90
set tics out
set grid y2

# Style des données en histogrammes
set style data histograms
set style fill solid border -1
set boxwidth 0.5
set tmargin 2.5

# Tracé du graphique
plot "./temp/top_distances_conducteurs.csv" using (2*$0+1):1:xticlabels(2) with boxes lc rgb "skyblue" axis x1y2 notitle