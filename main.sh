#!/bin/bash

# Vérifier s'il y a au moins un argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-h] fichier_csv [options]"
    exit 1
fi

# Vérification de l'option d'aide
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 [-h] fichier_csv [options]"
    echo "Options:"
    echo "  -h, --help  Afficher cette aide."
    echo "  -d1         Conducteurs avec le plus de trajets."
    echo "  -d2         Conducteurs et la plus grande distance."
    echo "  -l          Les 10 trajets les plus longs."
    exit 0
fi

# Récupération du fichier à analyser
fichier_csv="$1"

shift # Passer au prochain argument

# Parcourir tous les arguments restants
while [ "$#" -gt 0 ]; do
    case "$1" in

        "-d1")
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            echo "Traitement des conducteurs avec le plus de trajets en cours..."
            ## Vérification de l'existance du fichier
            if [ ! -f "$fichier_csv" ]; then
                echo "Le fichier $fichier_csv n'existe pas."
                exit 1
            fi
            
            ## Tri des données de fichier_csv avec awk
            awk -F';' '$2 == 1 {count[$6]+=1} END {for (name in count) printf "%d;%s\n", count[name], name}' "$fichier_csv" | sort -nr | head -n 10 > "./temp/top_conducteurs.csv"
            echo "Traitement des conducteurs avec le plus de trajets terminé. Résultats stockés dans ./temp/top_conducteurs.csv"
            ## Création du graphique 
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/d1.gnu
            echo "Création du graphique terminé"
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            ## On calcule la durée d'exécution
            duree=$(fin - debut)
            ## On affiche le résultat            
            echo "Temps d'éxecution: $duree secondes"
            ## Ouverture du graphique 
            open ./graph_output/top_conducteurs.png
            ;;

        "-d2")
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            echo "Traitement des conducteurs et la plus grande distance en cours..."
            ## Vérification de l'existance du fichier
            if [ ! -f "$fichier_csv" ]; then
                echo "Le fichier $fichier_csv n'existe pas."
                exit 1
            fi
            ## Tri des données de fichier_csv avec awk
            awk -F';' 'NR>1 {distance[$6] += $5} END {for (name in distance) printf "%d;%s\n", distance[name], name}' "$fichier_csv" | sort -t';' -nr | head -n 10 > "./temp/top_distances_conducteurs.csv"
            echo "Traitement des conducteurs et la plus grande distance terminé. Résultats stockés dans ./temp/top_distances_conducteurs.csv"
            ## Création du graphique 
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/d2.gnu
            echo "Création du graphique terminé"
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            duree=$(fin - debut)
            ## On affiche le résultat
            echo "Temps d'éxecution: $duree secondes"
            ## Ouverture du graphique
            open ./graph_output/top_distances_conducteurs.png
            ;;

        "-l")
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            echo "Traitement des 10 trajets les plus longs en cours..."
            ## Vérification de l'existance du fichier
            if [ ! -f "$fichier_csv" ]; then
                echo "Le fichier $fichier_csv n'existe pas."
                exit 1
            fi
            ## Tri des données de fichier_csv avec awk
            awk -F';' 'NR>1 {distance[$1] += $5} END {for (name in distance) printf "%s;%d\n", name, distance[name]}' "$fichier_csv" | sort -t';' -k2,2nr | head -n 10 | sort -nr > "./temp/trajets_long.csv"
            echo "Traitement des 10 trajets les plus longs terminé. Résultats stockés dans ./temp/trajets_long.csv"
            ## Création du graphique 
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/l.gnu
            echo "Création du graphique terminé"
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            duree=$(fin - debut)
            ## On affiche le résultat
            echo "Temps d'éxecution: $duree secondes"
            ## Ouverture du graphique
            open ./graph_output/top_trajets.png
            ;;

        *)
            echo "Option non reconnue ou manquante: $1. Utilisez -d1, -d2 ou -l pour effectuer les traitements spécifiques. Utilisez -h pour l'aide."
            exit 1
            ;;
    esac
    shift # Passer au prochain argument
done
