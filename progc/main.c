#include "traitement-s.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main( int argc, char * argv[] ) {

    if ( argc == 1 ) {
        printf( "Usage: file.csv, 1 ou 2 suivant -t ou -s\n" );
        exit( 0 );
    }     
    int value = atoi( argv[2] );

    FILE *fichierSource = fopen(argv[1], "r");
            if (fichierSource == NULL)
            {
                perror("Erreur lors de l'ouverture du fichier");
                return 1;
            }

    //Pour option -t    
    struct Ville *racineT = NULL;
    char ligneT[1024];
    char *donneeT;

    //Pour option -s
    struct Trajet *racineS = NULL;
    char ligneS[1024];
    char *donneeS;
    char *routeS;
    int routeIdS = 0;

    switch( value ) {
        case 1: // option -t

            printf("A completer");

            break;
        case 2: // option -s
            // Boucle de lecture des données et insertion dans l'arbre AVL
            while (fgets(ligneS, sizeof(ligneS), fichierSource))
            {
                if (strstr(ligneS, "Route ID") != NULL)
                {
                    continue; // Ignorer la ligne d'en-tête
                }
                routeS = strtok(ligneS, ";");
                routeIdS = atoi(routeS);
                donneeS = strtok(NULL, ";");
                donneeS = strtok(NULL, ";");
                donneeS = strtok(NULL, ";");
                char *distance = strtok(NULL, ";");
                float d = atof(distance);
                racineS = insererNoeudS(racineS, routeIdS, d);
            }

            struct Top50 top50 = {.index = 0};

            parcoursInfixeS(racineS, &top50);

            triTop50S(&top50);

            FILE *outputS = fopen("./temp/tempS.csv", "w");
            if (outputS == NULL)
            {
                perror("Erreur lors de la création du fichier de sortie");
                return 1;
            }

            for (int i = 0; i < top50.index; i++)
            {
                fprintf(outputS, "%d;%d;%.3f;%.3f;%.3f;%.3f\n", i, top50.nodes[i]->routeId, top50.nodes[i]->distance_min, top50.nodes[i]->distance_moyenne, top50.nodes[i]->distance_max, top50.nodes[i]->d_max_d_min);
            }

            fclose(outputS);

            libererArbreTrajetS(racineS);

            break;
        default:
            printf( "La valeur doit etre 1 ou 2\n" );
    }

    fclose(fichierSource); // Fermeture du fichier d'entrée

    return 0;
}