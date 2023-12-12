#!/bin/bash

# Vérifier s'il y a au moins un argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-h] fichier_csv [options]"
    exit 1
fi

# Vérifier si l'option -h est fournie
if [ "$1" = "-h" ]; then
    echo "Aide :"
    echo " -d1 : conducteurs avec le plus de trajets"
    echo " -d2 : conducteurs et la plus grande distance"
    echo " -l : les 10 trajets les plus longs"
    echo " -t : les 10 villes les plus traversées"
    echo " -s : statistiques sur les étapes"
    exit 0
fi

fichier_csv="data.csv"

if [ "$2" = "-d1" ]; then
    # Récupérer la liste des conducteurs avec le nombre de trajets
    conducteurs_trajets=$(tail -n +2 "$fichier_csv" | cut -d ',' -f 2 | sort | uniq -c | sort -rn)

    # Garder les 10 premiers conducteurs avec le plus de trajets
    top_10_conducteurs=$(echo "$conducteurs_trajets" | head -n 10)

    # Créer un fichier temporaire pour stocker les données pour le graphique
    temp_file=$(mktemp)
    echo "$top_10_conducteurs" > "$temp_file"

    # Créer un graphique d'histogramme horizontal en utilisant gnuplot
    gnuplot -persist <<-EOF
        set title "Top 10 des conducteurs avec le plus de trajets"
        set xlabel "Nombre de trajets"
        set ylabel "Conducteurs"
        set style data histograms
        set style fill solid border -1
        set yrange [0.5:10.5]
        set xrange [0:*]
        set ytics nomirror
        set xtics nomirror
        set grid y
        set boxwidth 0.5
        set terminal pngcairo size 800,600 enhanced font 'Arial,12'
        set output 'top_conducteurs.png'
        plot "$temp_file" using 1:xticlabels(2) with boxes lc rgb "skyblue" title "", \
             '' using (\$1):(\$0):(\$1) with labels offset char 0,1 notitle
EOF

    # Nettoyer le fichier temporaire
    rm "$temp_file"

    echo "Le graphique a été généré sous le nom 'top_conducteurs.png'"
    exit 0
fi

echo "Option non reconnue ou pas d'option spécifiée. Utilisez -d1 pour le traitement spécifié."
exit 1