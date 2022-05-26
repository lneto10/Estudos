#include <stdio.h>
#include <stdlib.h>


struct celula {
int dado; // dadoor inteiro a ser armazenado
struct celula *prox; // ponteiro para a próxima célula de armazenamento
};


typedef struct celula lista;


lista *criaLista(int dado){
lista *l;
l = (lista *) malloc (sizeof (lista *));
l->dado=dado;
l->prox=NULL;
return l;
}




int listaVazia(lista *l){
if (l==NULL)
return 1;
else
return 0;
}


void insere (lista *l, int dado){
lista *novo, *aux;
novo=criaLista(dado);
aux=l;
while (aux->prox!=NULL)
    aux=aux->prox;
aux->prox=novo;
}


void imprime(lista *l){
printf ("\n");
lista *aux;
if (listaVazia(l))
printf ("\nLista esta vazia\n");
else{
aux = l;
while (aux!=NULL){
printf (" %d ", aux->dado);
aux=aux->prox;
}
}
printf ("\n");
}


void excluir_lista(lista *l){
int cont=1;
lista *aux,*next;
aux=l;
if (listaVazia(aux))
printf ("\n\nLista Vazia\n\n"); // caso verdade, acaba aqui
else if (aux->prox==NULL){
free(aux);
printf ("\n\n (%d)Uma Celula Eliminada\n\n",cont);
} else{ // caso haja mais de uma célula
next = aux->prox;
while(next!=NULL){
free(aux);
cont++;
aux=next;
next=next->prox;
}
printf ("\n\n Foram liberadas %d celulas totalizando %d bytes\n\n",
cont, (int)(cont*(sizeof(lista))));
}
}




int existe(lista *l, int dadoor){
lista *aux;
aux=l;
while ((aux!=NULL) && (aux->dado!=dadoor))
aux=aux->prox;
if (aux==NULL)
return 0; // indica falso
else
return 1; // indica verdadeiro
}


void deleta_item(lista *l, int item){
lista *aux,*aux2;
aux=l;
if (!existe(l,item))
printf ("\n\nItem não encontrado na lista\n\n");
else if ((aux->prox==NULL) && (aux->dado==item)){ // caso seja o unico item
free(aux);
aux=NULL;
}
else if (aux->dado==item){ // é o primeiro item
aux=aux->prox;
free(l);
l=aux;
imprime(l);


} else {
while ((aux->prox->prox!=NULL) && (aux->prox->dado!=item)) //busco a célula
aux=aux->prox;
if ((aux->prox->dado==item) && (aux->prox->prox==NULL)) { //caso seja o ultimo
free(aux->prox);
aux->prox=NULL;
} else { // está no meio
aux2=aux->prox->prox;
free(aux->prox);
aux->prox=aux2;
}
}
}


int main (){
lista *l=NULL;
l=criaLista(5);
insere(l,6);
insere(l,4); insere(l,46); insere(l,54);
insere(l,78); insere (l, 80); insere (l, 100);
insere(l,87); insere (l, -8); insere (l, 29);
imprime (l);
printf ("\nBusca por 46=%d\n", existe(l,46));
printf ("\nBusca por 109=%d\n", existe(l,109));
deleta_item(l,88);
imprime (l);
excluir_lista(l);
l=NULL;


}
