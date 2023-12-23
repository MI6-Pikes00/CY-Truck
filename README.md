# Projet-preing-2 :  CY_Truck


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