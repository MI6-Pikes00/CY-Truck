# Configuration du terminal de sortie et de la taille du graphique
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './images/graph_S.png'

# Titre du graphique
set title "Courbes Min-Max-Moyenne des distances par trajet"

# Style des données en lignes
set style data lines

# Configuration des plages des axes x et y
set xrange [0:*]
set yrange [0:*]

# Configuration de l'axe x (identifiants des trajets)
set xtics rotate by -60
set grid ytics lw 1 lt 0
set grid xtics lw 1 lt 0
set xlabel "Identifiants des trajets"
set ylabel "Distances en km"

# Séparateur de champs pour un fichier CSV
set datafile separator ";"

# Tracé des courbes pour les distances min, moyenne et max par trajet
plot 'adefinir' using 3:xticlabels(2) with lines lc "blue" title 'dMin', \
     '' using 4:xticlabels(2) with lines lc "black" title 'dMoy', \
     '' using 5:xticlabels(2) with lines lc "blue" title 'dMax', \
     '' using 1:3:5 with filledcurves lc "skyblue" fs transparent solid 0.5 notitle
