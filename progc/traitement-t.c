#include "traitement-t.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Fonction pour créer un nouveau noeud AVL
struct Ville *nouveauNoeudT(char *nomVille){
    struct Ville *noeud = (struct Ville *)malloc(sizeof(struct Ville));
    strcpy(noeud->nomVille, nomVille);
    noeud->compteDepart = 0;
    noeud->compteTotal = 1;
    noeud->gauche = NULL;
    noeud->droit = NULL;
    noeud->hauteur = 1;
    return noeud;
}

// Fonction pour obtenir la hauteur d'un noeud dans l'arbre AVL
int hauteurT(struct Ville *noeud){
    if (noeud == NULL){
        return 0;
    }
    return noeud->hauteur;
}

// Fonction utilitaire pour obtenir le maxTimum de deux entiers
int maxT(int a, int b){
    return (a > b) ? a : b;
}

// Fonction pour effectuer une rotation à droite dans l'arbre AVL
struct Ville *rotationDroitT(struct Ville *y){
    struct Ville *x = y->gauche;
    struct Ville *T2 = x->droit;

    // Début de la rotation
    x->droit = y;
    y->gauche = T2;

    // Mise à jour de la hauteur
    y->hauteur = maxT(hauteurT(y->gauche), hauteurT(y->droit)) + 1;
    x->hauteur = maxT(hauteurT(x->gauche), hauteurT(x->droit)) + 1;

    return x;
}

// Fonction pour effectuer une rotation à gauche dans l'arbre AVL
struct Ville *rotationGaucheT(struct Ville *x){
    struct Ville *y = x->droit;
    struct Ville *T2 = y->gauche;
    
    // Début de la rotation
    y->gauche = x;
    x->droit = T2;
    
    // Mise à jour de la hauteur
    x->hauteur = maxT(hauteurT(x->gauche), hauteurT(x->droit)) + 1;
    y->hauteur = maxT(hauteurT(y->gauche), hauteurT(y->droit)) + 1;

    return y;
}

// Fonction pour obtenir le facteur d'équilibrage d'un noeud dans l'arbre AVL
int obtenirBalanceT(struct Ville *noeud){
    if (noeud == NULL){
        return 0;
    }
    return hauteurT(noeud->gauche) - hauteurT(noeud->droit);
}

// Fonction pour insérer un nouveau noeud dans l'arbre AVL avec gestion des villes de départ et de passage
struct Ville *insererNoeudT(struct Ville *noeud, char *nomVille, char *etapeId){
    
    if (noeud == NULL){
        struct Ville *new = nouveauNoeudT(nomVille);
        if (strcmp(etapeId, "1") == 0){
            new->compteDepart++;
        }
        return new;
    }

    int compare = strcmp(nomVille, noeud->nomVille);

    if (compare < 0){
        noeud->gauche = insererNoeudT(noeud->gauche, nomVille, etapeId);
    }
    else if (compare > 0){
        noeud->droit = insererNoeudT(noeud->droit, nomVille, etapeId);
    }
    else{
        // Si la ville est déjà présente, mettre à jour les compteurs appropriés
        if (strcmp(etapeId, "1") == 0)
        {
            noeud->compteDepart++;
        }
        noeud->compteTotal++;

        return noeud;
    }

    /* --------- Rééquilibre de l'AVL --------- */

    // Mettre à jour la hauteur du nœud actuel
    noeud->hauteur = 1 + maxT(hauteurT(noeud->gauche), hauteurT(noeud->droit));

    // Calculer le facteur d'équilibre du nœud
    int balance = obtenirBalanceT(noeud);

    // Cas de déséquilibre - rotation gauche-gauche
    if (balance > 1 && strcmp(nomVille, noeud->gauche->nomVille) < 0){
        return rotationDroitT(noeud);
    }

    // Cas de déséquilibre - rotation droite-droite
    if (balance < -1 && strcmp(nomVille, noeud->droit->nomVille) > 0){
        return rotationGaucheT(noeud);
    }

    // Cas de déséquilibre - rotation gauche-droite
    if (balance > 1 && strcmp(nomVille, noeud->gauche->nomVille) > 0){
        noeud->gauche = rotationGaucheT(noeud->gauche);
        return rotationDroitT(noeud);
    }
    
    // Cas de déséquilibre - rotation droite-gauche
    if (balance < -1 && strcmp(nomVille, noeud->droit->nomVille) < 0){
        noeud->droit = rotationDroitT(noeud->droit);
        return rotationGaucheT(noeud);
    }

    return noeud;
}

// Fonction pour libérer la mémoire d'un arbre binaire de villes
void libererArbreVillesT(struct Ville *racine){
    if (racine == NULL){
        return;
    }
    // Libérer récursivement les nœuds enfants (gauche et droit)
    libererArbreVillesT(racine->gauche);
    libererArbreVillesT(racine->droit);

    // Libérer le nœud actuel
    free(racine);
}

// Fonction pour ajouter un noeud dans les 10 plus grands totaux
void addToTop10T(struct Top10 *top10, struct Ville *noeud){
    if (top10->index < 10){
        top10->nodes[top10->index++] = noeud;
    } else{
        int minIndex = 0;
        for (int i = 1; i < 10; i++){
            if (top10->nodes[i]->compteTotal < top10->nodes[minIndex]->compteTotal){
                minIndex = i;
            }
        }
        if (noeud->compteTotal > top10->nodes[minIndex]->compteTotal){
            top10->nodes[minIndex] = noeud;
        }
    }
}

// Écriture dans le fichier de sortie
void parcoursInfixeT(struct Ville *racine, struct Top10 *top10){
    if (racine != NULL){
        parcoursInfixeT(racine->gauche, top10);

        addToTop10T(top10, racine);

        parcoursInfixeT(racine->droit, top10);
    }
}

// Fonction de comparaison pour le tri par nomVille
int compareNomVilleT(const void *a, const void *b){
    struct Ville *villeA = *(struct Ville **)a;
    struct Ville *villeB = *(struct Ville **)b;
    return strcmp(villeA->nomVille, villeB->nomVille);
}

// Fonction pour trier le tableau de structures Top10 par rapport au nomVille
void trierTop10T(struct Top10 *top10){
    qsort(top10->nodes, top10->index, sizeof(struct Ville *), compareNomVilleT);
}

/*
int main(int argc, char *argv[])
{
    FILE *fichierSource = fopen(argv[1], "r");
    if (fichierSource == NULL)
    {
        perror("Erreur lors de l'ouverture du fichier");
        return 1;
    }

    struct Ville *racine = NULL;
    char ligne[1024];
    char *donnee;

    // Lecture du fichier CSV
    while (fgets(ligne, sizeof(ligne), fichierSource))
    {
        if (strstr(ligne, "Route ID") != NULL)
        {
            continue;
        }

        donnee = strtok(ligne, ";");
        char *etapeId = strtok(NULL, ";");
        donnee = strtok(NULL, ";");
        if (strcmp(etapeId, "1") == 0)
        {
            racine = insererNoeudT(racine, donnee, etapeId);
        }
        strcpy(etapeId, "0");
        donnee = strtok(NULL, ";");
        racine = insererNoeudT(racine, donnee, etapeId);
    }

    fclose(fichierSource);

    struct Top10 top10 = {.index = 0};

    parcoursInfixeT(racine, &top10);

    trierTop10T(&top10);

    FILE *outputT = fopen("tempT.csv", "w");
    if (outputT == NULL)
    {
        perror("Erreur lors de la création du fichier de sortie");
        return 1;
    }

    for (int i = 0; i < top10.index; i++)
    {
        fprintf(outputT, "%s;%d;%d\n", top10.nodes[i]->nomVille, top10.nodes[i]->compteTotal, top10.nodes[i]->compteDepart);
    }

    fclose(outputT);

    libererArbreVillesT(racine);

    return 0;
}
*/