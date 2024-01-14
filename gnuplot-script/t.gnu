# Définit le type de terminal et la sortie du graphique en PNG
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './images/graph_T.png'

# Séparateur de champs pour un fichier CSV
set datafile separator ";"

# Titre du graphique
set title "Nombre de trajets par ville"

# Configuration des styles de remplissage
set style fill solid border -1
set style histogram clustered
set style fill solid noborder

# Configuration de l'axe x (noms des villes)
set xtics nomirror rotate by -45
set xrange [*:*]
set xlabel "Villes"

# Configuration de l'axe y (nombre de trajets)
set yrange [*:*]
set ylabel "Nombre de trajets"

# Configuration des barres verticales pour chaque ville
set boxwidth 2 relative
set key autotitle columnheader

# Traçage des barres verticales pour le nombre total de trajets et les départs par ville
plot 'adefinir' using 2:xticlabels(1) with histogram title "Total trajets" lc rgb "blue", \
     '' using 3 with histogram title "Ville de départ" lc rgb "skyblue"

