# Configuration du terminal de sortie et de la taille du graphique
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './images/graph_l.png'

# Séparateur de champs pour un fichier CSV
set datafile separator ';'

# Titre du graphique
set title "Top 10 trajets les plus longs"

# Configuration des axes x et y
set xlabel "Identifiant du trajet"
set ylabel "Distance en km"

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

# Tracé du graphique avec les données du fichier "trajets_long.csv"
plot "./temp/trajets_long.csv" using (2*$0+1):2:xticlabels(1) with boxes lc rgb "skyblue" notitle
