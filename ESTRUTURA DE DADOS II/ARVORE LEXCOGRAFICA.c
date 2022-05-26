#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define TAM_ALFABETO 26

struct Node
{
	struct Node *filho[TAM_ALFABETO];
	bool fimDePalavra;
};

struct Node *criaNo(void)
{
	struct Node *No = NULL;
	No = (struct Node *)malloc(sizeof(struct Node));
	if (No)
	{
		int i;
		No->fimDePalavra = false;
		for (i = 0; i < TAM_ALFABETO; i++)
			No->filho[i] = NULL;
	}
	return No;
}

void insere(struct Node *raiz,  char *chave)
{
	int nivel;
	int tamanho = strlen(chave);
	int i;
	struct Node *p = raiz;
	for (nivel = 0; nivel < tamanho; nivel++)
	{
		i = ((int)chave[nivel] - (int)'a');
		if (!p->filho[i])
			p->filho[i] = criaNo();

		p = p->filho[i];
	}
	p->fimDePalavra = true;
}

bool busca(struct Node *raiz,  char *chave)
{
	int nivel;
	int tamanho = strlen(chave);
	int i;
	struct Node *p = raiz;
	for (nivel = 0; nivel < tamanho; nivel++)
	{
		i = ((int)chave[nivel] - (int)'a');
		if (!p->filho[i])
			return false;
		p = p->filho[i];
	}
	return (p != NULL && p->fimDePalavra);
}

int main()
{
	char chaves[30];
	char pesquisa [30];
	char sair[4];
	int opcao,menu=1;
	int i;
	char mensagem[][21] = {"Nao Existe na Arvore", "Existe na Arvore"};
	struct Node *raiz = criaNo();
	
	while (menu != 0){
	
			printf ("Arvore do Luiz\n==============\n\n");
			printf(" 1 - Inserir elementos na arvore: \n");
			printf(" 2 - Buscar elementos na arvore: \n");
			printf(" 3 - Encerrar: \n");
			printf ("Opcao: ");
			scanf ("%i",&opcao);

		switch (opcao){
			case 1: 
				do {
					printf ("Informe a palavra que deseja inserir na arvore? : ");
					fflush (stdin);
					scanf("%s",chaves);
					insere(raiz, chaves);
					printf("\nInforme o token para sair: ");
					scanf("%s",sair);
					opcao = strcmp(sair, "sair");
					} while (opcao != 0);
					system ("clear");
            		break;

			case 2: 
					
	 				
	 				
					
					printf ("\n\nInforme a palavra que deseja buscar na arvore? : ");
					fflush (stdin);
					scanf("%s",pesquisa);;
				
					printf("%s ===> %s\n", pesquisa,  mensagem[busca(raiz, pesquisa)] );
					system ("clear");
            		break;
			case 0:
			exit(0);
			
		}
		
		}
	
		
		
		
	 
	
	
		

	
	return 0;

}

