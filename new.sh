#!/bin/bash

# Vérifier s'il y a au moins un argument
if [ "$#" -eq 0 ]; then  # Le $# -lt 1 vérifie si il existe un argument
    echo "Usage: $0 [-h] fichier_csv [options]"
    exit 1
fi

fichier_csv="$1"

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

if [ "$2" = "-d1" ]; then
    echo "traitement d1 en cours..."
    if [ ! -f "$fichier_csv" ]; then
        echo "Le fichier $fichier_csv n'existe pas."
        exit 1
    fi

    awk -F';' '$2 == 1 {count[$6]++} END {for (name in count) print count[name], name}' "$fichier_csv" | sort -nr | head -n 10 > "./temp/conducteur.txt"
    echo "Traitement d1 terminé. Résultats stockés dans ./temp/conducteur.txt"
elif [ "$3" = "-d2" ]; then
    echo "traitement d2 en cours..."
    if [ ! -f "$fichier_csv" ]; then
        echo "Le fichier $fichier_csv n'existe pas."
        exit 1
    fi

    awk -F';' 'NR>1 {distance[$6] += $5} END {for (name in distance) printf "%s;%d\n", name, distance[name]}' "$fichier_csv" > "./temp/doudoutance.txt"
    sort -t';' "./temp/doudoutance.txt" -k2,2nr | head -n 10 > "./temp/distance.txt"
    echo "Traitement d2 terminé. Résultats stockés dans ./temp/distance.txt"
else
    echo "Option non reconnue ou manquante. Utilisez -d1 ou -d2 pour effectuer les traitements spécifiques."
    exit 1
fi