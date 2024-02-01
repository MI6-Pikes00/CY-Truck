#ifndef HEADER_TRAITEMENTT
#define HEADER_TRAITEMENTT 1
#include "structfile.h"

struct Ville *nouveauNoeudT(char *nomVille);
int hauteurT(struct Ville *noeud);
int maxT(int a, int b);
struct Ville *rotationDroitT(struct Ville *y);
struct Ville *rotationGaucheT(struct Ville *x);
int obtenirBalanceT(struct Ville *noeud);
struct Ville *insererNoeudT(struct Ville *noeud, char *nomVille, char *etapeId);
void libererArbreVillesT(struct Ville *racine);
void addToTop10T(struct Top10 *top10, struct Ville *noeud);
void parcoursInfixeT(struct Ville *racine, struct Top10 *top10);
int compareNomVilleT(const void *a, const void *b);
void trierTop10T(struct Top10 *top10);

#endif