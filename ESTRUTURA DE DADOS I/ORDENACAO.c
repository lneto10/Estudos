#include <stdio.h>
#include <stdlib.h>

typedef struct no No;

struct no {
    int dado;
    struct no *prox;
};

No *criarLista (){
    No *novoNo = (No*) malloc (sizeof(No));
    return novoNo;
};

No *inserirElemento (No *Lista, int valor){
    No *no = criarLista();
    no->dado=valor;

    if(Lista == NULL){
        Lista = no;
        no->prox = NULL;
    }
    else{
        No *aux = Lista;
        while(aux->prox!=NULL){
            aux = aux->prox;
        }
        aux->prox=no;
        no->prox = NULL;
        }
}

void ordemCrescente (No *Lista){
    if(Lista->prox != NULL){
        for(No *i = Lista; i->prox != NULL; i = i->prox){
            No *menor = i;
                for(No *j =i->prox; j != NULL; j = j->prox){
                    if(j->dado < menor->dado){
                        menor = j;
                    }
                }
                    int aux = i->dado;
                    i->dado = menor->dado;
                    menor->dado= aux;
        }
    }
}

void ordemDecrescente (No *Lista){
    if(Lista->prox != NULL){
        for(No *i = Lista; i->prox != NULL; i = i->prox){
            No *menor = i;
                for(No *j =i->prox; j != NULL; j = j->prox){
                    if(j->dado > menor->dado){
                        menor = j;
                    }
                }
                    int aux = i->dado;
                    i->dado = menor->dado;
                    menor->dado= aux;
        }
    }
}

void numerosNegativos(No *Lista){
    No *aux = Lista;
    int i = 0, j = 0;

    while(aux!=NULL){
        if(aux->dado<0){
            i++;
            aux = aux->prox;
        }
        else{
            j++;
            aux = aux->prox;
        }
    }
    printf("\nnumeros negativos: %d", i);
    printf("\nnumeros positivos: %d", j);
}


void imprimir(No *Lista){
    No *aux = Lista;
    int i = 0;
    printf("\nLista: ");
    while(aux!=NULL){
        i++;
        printf("%d ", aux->dado);
        aux = aux->prox;
    }
}

void totalNumeros(No *Lista){
    No *aux = Lista;
    int i = 0;
    while(aux!=NULL){
        i++;
        aux=aux->prox;
    }
    printf("\nTotal de numeros: %d",i);
}

int main (){
    No *Lista = NULL;
    Lista=inserirElemento(Lista, -10);
    inserirElemento(Lista, 0);
    inserirElemento(Lista,1);
    inserirElemento(Lista,32);
    inserirElemento(Lista,40);
    inserirElemento(Lista,-20);
    imprimir(Lista);
    ordemCrescente(Lista);
    imprimir(Lista);
    ordemDecrescente(Lista);
    imprimir(Lista);
    numerosNegativos(Lista);
    totalNumeros(Lista);

}
