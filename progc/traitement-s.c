#include "traitement-s.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Fonction pour créer un nouveau noeud dans l'arbre AVL
struct Trajet *nouveauNoeudS(int routeId, float distance){
    
    struct Trajet *noeud = (struct Trajet *)malloc(sizeof(struct Trajet));
    
    if (noeud == NULL){
        fprintf(stderr, "Erreur lors de l'allocation de mémoire pour le nouveau nœud.\n");
        exit(EXIT_FAILURE);
    }

    // Attribution des données dans le noeud de l'AVL 
    noeud->routeId = routeId;
    noeud->distance_min = distance;
    noeud->distance_max = distance;
    noeud->distance_total = distance;
    noeud->distance_moyenne = 0;
    noeud->d_max_d_min = 0;
    noeud->nb_etape = 1;
    noeud->gauche = NULL;
    noeud->droit = NULL;
    noeud->height = 1; // La hauteur d'un nouveau nœud est initialisée à 1

    return noeud;
}

// Fonction pour obtenir la hauteur d'un nœud dans l'arbre AVL
int obtenirHauteurS(struct Trajet *noeud){
    if (noeud == NULL){
        return 0;
    }
    return noeud->height;
}

// Fonction pour obtenir le facteur d'équilibre d'un nœud dans l'arbre AVL
int obtenirBalanceS(struct Trajet *noeud){
    if (noeud == NULL){
        return 0;
    }
    return obtenirHauteurS(noeud->gauche) - obtenirHauteurS(noeud->droit);
}

float maxS(float a, float b){
    return (a >= b) ? a : b;
}

float minS(float a, float b){
    return (a >= b ? b : a);
}

// Fonction pour effectuer une rotation gauche dans l'arbre AVL
struct Trajet *rotationGaucheS(struct Trajet *noeud){

    struct Trajet *nouvelleRacine = noeud->droit;
    struct Trajet *sousArbre = nouvelleRacine->gauche;

    // Effectuer la rotation
    nouvelleRacine->gauche = noeud;
    noeud->droit = sousArbre;

    // Mettre à jour les hauteurs des nœuds
    noeud->height = 1 + maxS(obtenirHauteurS(noeud->gauche), obtenirHauteurS(noeud->droit));
    nouvelleRacine->height = 1 + maxS(obtenirHauteurS(nouvelleRacine->gauche), obtenirHauteurS(nouvelleRacine->droit));

    return nouvelleRacine;
}

// Fonction pour effectuer une rotation droite dans l'arbre AVL
struct Trajet *rotationDroitS(struct Trajet *noeud){

    struct Trajet *nouvelleRacine = noeud->gauche;
    struct Trajet *sousArbre = nouvelleRacine->droit;

    // Effectuer la rotation
    nouvelleRacine->droit = noeud;
    noeud->gauche = sousArbre;

    // Mettre à jour les hauteurs des nœuds
    noeud->height = 1 + maxS(obtenirHauteurS(noeud->gauche), obtenirHauteurS(noeud->droit));
    nouvelleRacine->height = 1 + maxS(obtenirHauteurS(nouvelleRacine->gauche), obtenirHauteurS(nouvelleRacine->droit));

    return nouvelleRacine;
}

// Fonction pour insérer un nouveau nœud et rééquilibrer l'arbre AVL
struct Trajet *insererNoeudS(struct Trajet *noeud, int routeId, float distance){

    // Si l'arbre est vide, créez un nouveau nœud
    if (noeud == NULL){
        return nouveauNoeudS(routeId, distance);
    }
    
    // Si le trajet est déjà présent, mettre à jour les compteurs appropriés
    if (noeud->routeId == routeId){
        noeud->distance_min = minS(noeud->distance_min, distance);
        noeud->distance_max = maxS(noeud->distance_max, distance);
        noeud->distance_total = (noeud->distance_total + distance);
        noeud->d_max_d_min = (noeud->distance_max - noeud->distance_min);
        noeud->nb_etape = (noeud->nb_etape + 1);
        return noeud;
    }

    // Insertion récursive dans l'arbre
    if (routeId < noeud->routeId){
        noeud->gauche = insererNoeudS(noeud->gauche, routeId, distance);
    } else{
        noeud->droit = insererNoeudS(noeud->droit, routeId, distance);
    }

    /* --------- Rééquilibre de l'AVL --------- */

    // Mettre à jour la hauteur du nœud actuel
    noeud->height = 1 + maxS(obtenirHauteurS(noeud->gauche), obtenirHauteurS(noeud->droit));

    // Calculer le facteur d'équilibre du nœud
    int balance = obtenirBalanceS(noeud);

    // Cas de déséquilibre - rotation gauche-gauche
    if (balance > 1 && (routeId < noeud->gauche->routeId)){
        return rotationDroitS(noeud);
    }

    // Cas de déséquilibre - rotation droite-droite
    if (balance < -1 && (routeId > noeud->droit->routeId)){
        return rotationGaucheS(noeud);
    }

    // Cas de déséquilibre - rotation gauche-droite
    if (balance > 1 && (routeId > noeud->gauche->routeId)){
        noeud->gauche = rotationGaucheS(noeud->gauche);
        return rotationDroitS(noeud);
    }

    // Cas de déséquilibre - rotation droite-gauche
    if (balance < -1 && (routeId < noeud->droit->routeId)){
        noeud->droit = rotationDroitS(noeud->droit);
        return rotationGaucheS(noeud);
    }

    return noeud;
}

// Fonction pour libérer la mémoire d'un arbre binaire de trajets
void libererArbreTrajetS(struct Trajet *racine){

    if (racine == NULL){
        return;
    }

    // Libérer récursivement les nœuds enfants (gauche et droit)
    libererArbreTrajetS(racine->gauche);
    libererArbreTrajetS(racine->droit);

    // Libérer le nœud actuel
    free(racine);
}

// Fonction pour ajouter un noeud dans les 10 plus grands totaux
void ajoutTop50S(struct Top50 *top50, struct Trajet *noeud){

    if (top50->index < 50){
        top50->nodes[top50->index++] = noeud;
    } else{
        int minIndex = 0;
        for (int i = 1; i < 50; i++){
            if (top50->nodes[i]->d_max_d_min < top50->nodes[minIndex]->d_max_d_min){
                minIndex = i;
            }
        }
        if (noeud->d_max_d_min > top50->nodes[minIndex]->d_max_d_min){
            top50->nodes[minIndex] = noeud;
        }
    }
}

// Fonction de comparaison pour qsort()
int compareS(const void *a, const void *b){

    struct Trajet *stepA = *(struct Trajet **)a;
    struct Trajet *stepB = *(struct Trajet **)b;

    // Tri par ordre décroissant de d_max_d_min
    if (stepA->d_max_d_min < stepB->d_max_d_min){
        return 1;
    }
    else if (stepA->d_max_d_min > stepB->d_max_d_min){
        return -1;
    }
    else{
        return 0;
    }
}

// Fonction de tri pour la structure Top50
void triTop50S(struct Top50 *top50){
    qsort(top50->nodes, top50->index, sizeof(struct Trajet *), compareS);
}

// Écriture dans le fichier de sortie
void parcoursInfixeS(struct Trajet *racine, struct Top50 *top50){
    
    if (racine != NULL){
        racine->distance_moyenne = racine->distance_total / racine->nb_etape;
        parcoursInfixeS(racine->gauche, top50);

        ajoutTop50S(top50, racine);

        parcoursInfixeS(racine->droit, top50);
    }
}

// int main(int argc, char *argv[])
// {
//     // Ouverture du fichier data.csv
//     FILE *fichierSource = fopen(argv[1], "r");
//     if (fichierSource == NULL)
//     {
//         fprintf(stderr, "Erreur lors de l'ouverture du fichier data.csv.\n");
//         return EXIT_FAILURE;
//     }

//     struct Trajet *racine = NULL;
//     char ligne[1024];
//     char *donnee;
//     char *route;
//     int routeId = 0;

//     // Boucle de lecture des données et insertion dans l'arbre AVL
//     while (fgets(ligne, sizeof(ligne), fichierSource))
//     {
//         if (strstr(ligne, "Route ID") != NULL)
//         {
//             continue; // Ignorer la ligne d'en-tête
//         }
//         route = strtok(ligne, ";");
//         routeId = atoi(route);
//         donnee = strtok(NULL, ";");
//         donnee = strtok(NULL, ";");
//         donnee = strtok(NULL, ";");
//         char *distance = strtok(NULL, ";");
//         float d = atof(distance);
//         racine = insererNoeudS(racine, routeId, d);
//     }

//     fclose(fichierSource); // Fermeture du fichier d'entrée

//     struct Top50 top50 = {.index = 0};

//     parcoursInfixeS(racine, &top50);

//     triTop50S(&top50);

//     FILE *outputS = fopen("tempS.csv", "w");
//     if (outputS == NULL)
//     {
//         perror("Erreur lors de la création du fichier de sortie");
//         return 1;
//     }

//     for (int i = 0; i < top50.index; i++)
//     {
//         fprintf(outputS, "%d;%d;%.3f;%.3f;%.3f;%.3f\n", i, top50.nodes[i]->routeId, top50.nodes[i]->distance_min, top50.nodes[i]->distance_moyenne, top50.nodes[i]->distance_max, top50.nodes[i]->d_max_d_min);
//     }

//     fclose(outputS);

//     libererArbreTrajetS(racine);

//     return 0;
// }