output_image="./graph/trajets.png"
           
# Configuration du tracé
set terminal pngcairo enhanced font 'Arial,12'
set output '$output_image'
set title "Les 10 trajets les plus longs"
set xlabel "Identifian du trajet"
set ylabel "Nombre de KM"
set style data histogram
set style histogram rowstacked
set style fill solid border -1
set ytics nomirror
set boxwidth 0.5

# Chargement des données depuis le fichier texte
plot '../temp/top_conducteurs.csv' 