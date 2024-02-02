#ifndef HEADER_STRUCT
#define HEADER_STRUCT 1

struct Ville{
    char nomVille[100]; // Nom de la ville 
    int compteDepart; // Compteur pour les villes de départ
    int compteTotal;  // Compteur total pour les villes (départ + passage)
    struct Ville *gauche; // Pointeur vers fils gauche
    struct Ville *droit; // Pointeur vers fils droit
    int hauteur; // Hauteur du noeud dans l'AVL
};

// Structure pour stocker les 10 plus grands totaux
struct Top10{
    struct Ville *nodes[10];
    int index;
};

// Structure pour stocker les informations sur les trajet
struct Trajet{
    int routeId;
    float distance_min;
    float distance_max;
    float d_max_d_min;
    float distance_total;
    float distance_moyenne;
    int nb_etape;
    struct Trajet *gauche;
    struct Trajet *droit;
    int height;
};

// Structure pour stocker les 50 plus grands totaux
struct Top50{
    struct Trajet *nodes[50];
    int index;
};

#endif