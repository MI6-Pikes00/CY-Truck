# Configuration du terminal de sortie et de la taille du graphique
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './images/graph_d2.png'

# Séparateur de champs pour un fichier CSV
set datafile separator ';'

# Titre du graphique
set title "Top 10 des conducteurs avec le plus de km parcourus"

# Configuration des axes x et y
set xlabel "Conducteurs"
set ylabel "Nombre de km"

# Style des données en histogrammes
set style data histograms
set style fill solid border -1

# Plages des axes x et y
set yrange [*:*]
set xrange [*:*]

# Configuration des ticmarks
set ytics nomirror 
set xtics nomirror
set xtics rotate by -45

# Configuration des lignes de grille
set grid y

# Largeur des barres
set boxwidth 0.5 relativ

# Tracé du graphique avec les données du fichier "top_distances_conducteurs.csv"
plot "./temp/top_distances_conducteurs.csv" using (2*$0+1):1:xticlabels(2) with boxes lc rgb "skyblue" notitle
