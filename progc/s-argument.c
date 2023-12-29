#include <stdio.h>
#include <stdlib.h>

typedef struct avl{
    int elmt;
    int equilibre;
    struct arbre *left, *right;
} avl;

avl* creationAVL(int x){
    avl* Node = malloc(sizeof(avl));
    if(Node==NULL){
        exit(1);
    }
    Node->elmt = x;
    Node->equilibre = 0;
    Node->left = NULL;
    Node->right = NULL;
    return Node;
}