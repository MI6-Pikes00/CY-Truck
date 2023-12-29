# Script projet de preing-2 : CY_Truck

Ce script shell a été conçu pour effectuer des traitements spécifiques sur des fichiers CSV contenant des données sur les trajets effectués par des conducteurs.

## Utilisation :

### Prérequis :

Assurez-vous que votre environnement exécute Bash et dispose des outils nécessaires tels que `awk`, `gnuplot` pour la génération des graphiques.

- Pour gnuplot: https://doc.ubuntu-fr.org/gnuplot
- Pour awk: présente par defaut sous Unix

### Option :
  Le script Shell offre plusieurs options pour traiter et analyser les données des fichiers CSV de trajets de conducteurs. Voici un résumé des options disponibles :

#### [D1] : Conducteurs avec le Plus de Trajets
- Option : `-d1`
  
- Description : Ce traitement vise à extraire la liste des conducteurs avec le nombre de trajets différents qu'ils ont effectués. Cette liste est ensuite triée par ordre décroissant en fonction du nombre de trajets, et seuls les 10 premiers conducteurs sont conservés.
Le résultat sera représenté sous forme d'un histogramme horizontal où les noms complets des conducteurs seront disposés en ordonnée, et le nombre de trajets effectués sera en abscisse. Le conducteur ayant effectué le plus grand nombre de trajets sera positionné en haut du graphique.

- Temps d'exécution ciblé : Environ 8 secondes.

#### [D2] : Conducteurs et la Plus Grande Distance
- Option : `-d2`
  
- Description : Ce traitement a pour objectif de calculer la distance totale parcourue par chaque conducteur en effectuant la somme des distances de toutes les étapes associées à ces conducteurs. Parmi toutes ces distances, seules les 10 plus grandes seront conservées et classées par ordre décroissant.
Le résultat sera représenté sous forme d'un histogramme horizontal où les noms complets des conducteurs seront affichés en ordonnée, et la distance totale parcourue sera en abscisse. Le conducteur ayant parcouru la plus grande distance sera positionné en haut du graphique.

- Temps d'exécution ciblé : Environ 7 secondes.

#### [L] : Les 10 Trajets les Plus Longs
- Option : `-l`
  
- Description : Ce traitement vise à obtenir la distance totale de chaque trajet, calculée comme la somme des distances de chaque étape pour ces trajets spécifiques. Parmi toutes les distances calculées, seules les 10 distances les plus importantes seront conservées. Ces distances seront ordonnées par numéro croissant d'identifiant de trajet.
Le résultat sera représenté dans un histogramme vertical où l'abscisse indiquera l'identifiant du trajet et l'ordonnée présentera la distance en kilomètres. Ce traitement doit être réalisé uniquement à l'aide d'un script Shell et de commandes Unix, avec une contrainte de temps d'exécution ne dépassant pas approximativement 8 secondes.

- Temps d'exécution ciblé : Environ 8 secondes.

#### [T] : Les 10 Villes les Plus Traversées
- Option : `-t`
  
- Description : Ce traitement vise à analyser les trajets en comptant le nombre de fois où chaque ville est soit traversée par un trajet, soit utilisée comme ville de départ d'un trajet. Une ville peut apparaître deux fois dans les données : une fois comme ville de départ et une fois comme ville d'arrivée. Le traitement sélectionne les 10 villes les plus fréquentes par ordre alphabétique.
Le résultat final est un histogramme regroupé. Les noms des villes sont affichés en abscisse, et en ordonnée, le graphique représente le nombre de trajets. Chaque ville est représentée par deux barres verticales : la première indique le nombre total de trajets traversant la ville, et la seconde le nombre de fois où la ville est utilisée comme point de départ d'un trajet.


#### [S] : Statistiques sur les Étapes
- Option : `-s`
  
- Description : Ce traitement a pour objectif d'analyser les différentes distances des étapes pour chaque trajet. Il récupère les distances minimales, maximales et moyennes des étapes pour chaque trajet. Le résultat est représenté sous forme d'un graphique de type courbes min-max-moyenne.
Ce graphique affiche pour chaque identifiant de trajet les valeurs minimales, moyennes et maximales des distances en kilomètres. Il présente deux courbes pour les valeurs minimales et maximales de distance, avec une troisième courbe au milieu représentant la moyenne de ces distances.
Les données sont triées en fonction de la différence entre la distance maximale et la distance minimale par ordre décroissant, et seules les 50 premières valeurs sont conservées dans le graphique.

### Exécution du script :

Pour exécuter le script, ouvrez un terminal et exécutez la commande suivante :

```bash
./script.sh [-h] fichier_csv [options]
```

**Exemples:**
```bash
./CYTruck.sh -h # Montre l'aide
./CYTruck.sh ./data/data.csv -d1 -d2 # Execute les traitements d1 et d2
```


## Planning

- *5.12.2023*: 
  - Lecture du projet 
  - Création du fichier main.sh

- *11.12.2023*: 
    - Ajout de la fonction de traitement **d1** 
      - Premier essaie > 20 sec. avec la commande: `cut -d ';' -f 1 data.csv | sort | uniq -c | sort -rn | head -n10`
      - Commande actuelle (inf à 8 sec.): `awk -F';' '$2 == 1 {count[$6]++} END {for (name in count) print count[name], name}' $fichier_csv | sort -nr | head -n 10 > ./temp/conducteur.txt`
  
- *12.12.2023*: 
    - Ajout de la fonction de traitement **d2** => 
      - Commande (inf à 9 sec.): `awk -F';' 'NR>1 {distance[$6] += $5} END {for (name in distance) printf "%d;%s\n", distance[name], name}' "$fichier_csv" | sort -t';' -nr | head -n 10 > "./temp/top_distances_conducteurs.csv"`
    - Ajout de la fonction de traitement **l** => 
      - Commande (inf à 9 sec.): `awk -F';' 'NR>1 {distance[$1] += $5} END {for (name in distance) printf "%s;%d\n", name, distance[name]}' "$fichier_csv" | sort -t';' -k2,2nr | head -n 10 | sort -nr > "./temp/trajets_long.csv"`

- *18.12.2023*: 

- *19.12.2023*: 

- *23.12.2023*: 
    - Debut rédaction/mise en forme du README