#ifndef HEADER_TRAITEMENTS
#define HEADER_TRAITEMENTS 1
#include "structfile.h"

struct Trajet *nouveauNoeudS(int routeId, float distance);
int obtenirHauteurS(struct Trajet *noeud);
int obtenirBalanceS(struct Trajet *noeud);
float maxS(float a, float b);
float minS(float a, float b);
struct Trajet *rotationGaucheS(struct Trajet *noeud);
struct Trajet *rotationDroitS(struct Trajet *noeud);
struct Trajet *insererNoeudS(struct Trajet *noeud, int routeId, float distance);
void libererArbreTrajetS(struct Trajet *racine);
void ajoutTop50S(struct Top50 *top50, struct Trajet *noeud);
int compareS(const void *a, const void *b);
void triTop50S(struct Top50 *top50);
void parcoursInfixeS(struct Trajet *racine, struct Top50 *top50);

#endif