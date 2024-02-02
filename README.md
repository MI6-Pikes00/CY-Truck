# Script projet de preing-2 : CY_Truck

Ce script shell a été conçu pour effectuer des traitements spécifiques sur des fichiers CSV contenant des données sur les trajets effectués par des conducteurs.

## Utilisation :

### Prérequis :

Assurez-vous que votre environnement exécute Bash et dispose des outils nécessaires tels que `awk`, `gcc` pour compiler, `gnuplot` pour la génération des graphiques.

- Pour gcc: https://dev.to/gamegods3/how-to-install-gcc-in-windows-10-the-easier-way-422j 
- Pour gnuplot: https://doc.ubuntu-fr.org/gnuplot
- Pour awk: présente par defaut sous Unix

### Exécution du script :

Pour exécuter le script, ouvrez un terminal et assurez-vous que votre fichier à analyser est placé dans le dossier **`data`** situé dans le répertoire du code. Assurez-vous également que votre répertoire racine est bien dans le dossier **`projet-preing-2`,** puis exécutez la commande suivante :

```bash
./main.sh [-h] fichier_csv [options]
```

**Exemples:**
```bash
./main.sh -h # Montre l'aide
./main.sh ./data/data.csv -d1 -d2 # Execute les traitements d1 et d2
```

### Option du script :
  Le script Shell offre plusieurs options pour traiter et analyser les données des fichiers CSV de trajets de conducteurs. Voici un résumé des options disponibles :

#### [D1] : Conducteurs avec le Plus de Trajets
- Option : `-d1`

- Temps d'exécution ciblé : Environ 8 secondes.

#### [D2] : Conducteurs et la Plus Grande Distance
- Option : `-d2`

- Temps d'exécution ciblé : Environ 7 secondes.

#### [L] : Les 10 Trajets les Plus Longs
- Option : `-l`

- Temps d'exécution ciblé : Environ 8 secondes.

#### [T] : Les 10 Villes les Plus Traversées
- Option : `-t`

#### [S] : Statistiques sur les Étapes
- Option : `-s`

### <ins> Sources </ins>
- [Ubuntu (Shell)](https://doc.ubuntu-fr.org/tutoriel/script_shell)
- [Gnuplot Src (Gnuplot)](https://gnuplot.sourceforge.net/)
- [StackOverflow (Gnuplot)](https://stackoverflow.com/questions/11266452/horizontal-histogram-in-gnuplot)
- [Funix (AWK)](funix.org/fr/unix/awk.htm)
- [Wikipedia EN (AWK)](https://en.wikipedia.org/wiki/AWK)
