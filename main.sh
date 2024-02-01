#!/bin/bash

# Vérifier et créer le dossier temp s'il n'existe pas
if [ ! -d "temp" ]; then
    mkdir temp
else
    # Vider le dossier temp s'il existe déjà
    rm -rf temp/*
fi

# Vérifier et créer le dossier images s'il n'existe pas
if [ ! -d "images" ]; then
    mkdir images
else
    # Vider le dossier images s'il existe déjà
    rm -rf images/*
fi

# Vérification de l'existence de l'exécutable
if [ ! -f "option" ]; then
    echo "Le programme exécutable n'est pas présent. Lancement de la compilation..."

    # Compilation du programme C
    make

    # Vérification si la compilation a réussi
    if [ $? -ne 0 ] || [ ! -f "option" ]; then
        echo "La compilation a échoué ou l'exécutable n'a pas été généré."
        exit 1
    else
        echo "Compilation réussie."
    fi
else
    #Reset si l'executable existe déja
    make
fi


# Vérifier s'il y a au moins un argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-h] fichier_csv [options]"
    exit 1
fi

# Récupération du fichier à analyser
fichier_csv="$1"


# Vérification de l'option d'aide
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 [-h] fichier_csv [options]"
    echo "Options:"
    echo "  -h, --help  Afficher cette aide."
    echo "  -d1         Conducteurs avec le plus de trajets."
    echo "  -d2         Conducteurs et la plus grande distance."
    echo "  -l          Les 10 trajets les plus longs."
    echo "  -t          Les 10 villes les plus traversées."
    echo "  -s          Statistiques sur les étapes."
    exit 0

fi

## Vérification de l'existance du fichier
            if [ ! -f "$fichier_csv" ]; then
                echo "Le fichier $fichier_csv n'existe pas."
                exit 1
            fi

# Parcourir tous les arguments restants
while [ "$#" -gt 1 ]; do
    case "$2" in
        "-d1")
            echo "Traitement des conducteurs avec le plus de trajets en cours..."
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            ## Tri des données de fichier_csv avec awk
            awk -F';' '$2 == 1 {count[$6]+=1} END {for (name in count) printf "%d;%s\n", count[name], name}' "$fichier_csv" | sort -nr | head -n 10 > "./temp/top_conducteurs.csv"
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            echo "Traitement des conducteurs avec le plus de trajets terminé. Résultats stockés dans ./temp/top_conducteurs.csv"
            ## Création du graphique 
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/d1.gnu
            convert -rotate 90 ./images/graph_d1.png ./images/graph_d1.png
            echo "Création du graphique terminé"
            ## On calcule la durée d'exécution
            duree=$((fin - debut))
            ## On affiche le résultat            
            echo "Temps d'éxecution: $(tput bold)$duree $(tput sgr0)secondes"
            ## Ouverture du graphique
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open ./images/graph_d1.png
            fi
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open ./images/graph_d1.png
            fi
            ;;

        "-d2")
            echo "Traitement des conducteurs et la plus grande distance en cours..."
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            ## Tri des données de fichier_csv avec awk
            awk -F';' 'NR>1 {distance[$6] += $5} END {for (name in distance) printf "%d;%s\n", distance[name], name}' "$fichier_csv" | sort -t';' -nr | head -n 10 > "./temp/top_distances_conducteurs.csv"
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            echo "Traitement des conducteurs et la plus grande distance terminé. Résultats stockés dans ./temp/top_distances_conducteurs.csv"
            ## Création du graphique 
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/d2.gnu
            convert -rotate 90 ./images/graph_d2.png ./images/graph_d2.png
            echo "Création du graphique terminé"
            ## On calcule la durée d'exécution
            duree=$((fin - debut))
            ## On affiche le résultat
            echo "Temps d'éxecution: $(tput bold)$duree $(tput sgr0)secondes"
            ## Ouverture du graphique
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open ./images/graph_d2.png
            fi
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open ./images/graph_d2.png
            fi
            ;;

        "-l")
            echo "Traitement des 10 trajets les plus longs en cours..."
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            ## Tri des données de fichier_csv avec awk
            awk -F';' 'NR>1 {distance[$1] += $5} END {for (name in distance) printf "%s;%d\n", name, distance[name]}' "$fichier_csv" | sort -t';' -k2 -nr | head -n 10 | sort -nr > "./temp/trajets_long.csv"
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            echo "Traitement des 10 trajets les plus longs terminé. Résultats stockés dans ./temp/trajets_long.csv"
            ## Création du graphique 
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/l.gnu
            echo "Création du graphique terminé"
            ## On calcule la durée d'exécution
            duree=$((fin - debut))
            ## On affiche le résultat
            echo "Temps d'éxecution: $(tput bold)$duree $(tput sgr0)secondes"
            ## Ouverture du graphique
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open ./images/graph_l.png
            fi
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open ./images/graph_l.png
            fi
            ;;

        "-t")
            echo "Traitement des 10 villes les plus traversées en cours..."
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            ## Tri des données de fichier_csv avec un programme C
            ./option "$fichier_csv" 1
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            echo "Traitement des 10 villes les plus traversées terminé. Résultats stockés dans ./temp/tempS.csv"
            ## On calcule la durée d'exécution
            duree=$((fin - debut))
            ## On affiche le résultat
            echo "Temps d'éxecution: $(tput bold)$duree $(tput sgr0)secondes"
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/t.gnu
            echo "Création du graphique terminé"
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open ./images/graph_T.png
            fi
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open ./images/graph_T.png
            fi
            ;;
            
        "-s")
            echo "Traitement des statistiques sur les étapes en cours..."
            ## On récupère le timestamp actuel au lancement du script
            debut=$(date +%s)
            ## Tri des données de fichier_csv avec un programme C
            ./option "$fichier_csv" 2
            ## On récupère le timestamp actuel à la fin du script
            fin=$(date +%s)
            echo "Traitement des statistiques sur les étapes terminé. Résultats stockés dans ./temp/tempS.csv"
            ## On calcule la durée d'exécution
            duree=$((fin - debut))
            ## On affiche le résultat
            echo "Temps d'éxecution: $(tput bold)$duree $(tput sgr0)secondes"
            echo "Création du graphique en cours ..."
            gnuplot gnuplot-script/s.gnu
            echo "Création du graphique terminé"
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open ./images/graph_S.png
            fi
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open ./images/graph_S.png
            fi
            ;;
        *)
            echo "Option non reconnue ou manquante: $2. Utilisez -d1, -d2 -l, -t ou -s pour effectuer les traitements spécifiques. Utilisez -h pour l'aide."
            exit 1
            ;;
    esac
    shift # Passer au prochain argument
## Liberation de tout les fichiers temporaires
rm -rf temp/*
done