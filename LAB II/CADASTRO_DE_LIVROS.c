#include <stdio.h>
#include <stdlib.h>
#define MAX 10

struct cadastro {
        int cod;
        char nome[30];
        char autor[30];
        int ISBN;
        int qtdpg;
        char editora[30];
        int ano;
        float preco;
};
int i = 0; j=0;
struct cadastro livros[MAX];



void getlivros(){

    FILE *arquivo;
    char nome[20];
        arquivo = fopen("Cadastro_Livros.txt", "w");

        if (arquivo == NULL){
            printf ("Erro na abertura do arquivo");
            exit (0);
        }
                printf("---Cadastro n %i", i+1);
                printf("\nNome do livro: ");
  				fflush(stdin);
  				gets(livros[i].nome);
  				fprintf(arquivo, "%s\n", nome);
  				printf("\nAutor do livro: ");
  				fflush(stdin);
  				gets(livros[i].autor);
  				printf("\nISBN: ");
  				scanf("%i",&livros[i].ISBN);
  				printf("\nQuantidade de paginas do livro: ");
  				scanf("%i",&livros[i].qtdpg);
  				printf("\nEditora do livro: ");
  				fflush(stdin);
  				gets(livros[i].editora);
  				printf("\nAno do livro: ");
  				scanf("%i",&livros[i].ano);
  				printf("\nPreco do livro: ");
  				scanf("%f",&livros[i].preco);
  				i++;
  				printf("Cadastro realizado com sucesso");




}
void listar_livros(){

    if (i==0){
        printf("Nao possui livros registrados\n");
    }
    else {
    for(j=0; j<i; j++){
            printf("Livros registrados!");
            printf("\n\tLivro %i", j+1);
        	printf("\nNOME: %s", livros[j].nome);
        	printf("\nAUTOR(A): %s", livros[j].autor);
            printf("\nQTD DE PAGINAS: %i", livros[j].qtdpg);
            printf("\nISBN: %i", livros[j].ISBN);
            printf("\nEDITORA: %s", livros[j].editora);
            printf("\nANO: %i", livros[j].ano);
            printf("\nPRECO: R$%.2f\n", livros[j].preco);
    }
    }
  			system ("pause");


}
/*
void gravararquivo(){
        int cod;
        char nome[30];
        char autor[30];
        int ISBN;
        int qtdpg;
        char editora[30];
        int ano;
        float preco;
        file *arquivo;

        arquivo = fopen("Cadastro_Livros.txt", "w");

        if (arquivo == null){
            printf ("Erro na abertura do arquivo");
            exit (0);
        }




}*/

void pesquisar (){
     int j = 0, op_pesquisa=1;
     char buscar[30];
     int buscar_ano;
        while (op_pesquisa != 0){
        printf ("Pesquisa -- Livraria Livros.com\n");
        printf("--------------------\n");
        printf("1 -  Pesquisar por Livro \n");
        printf("2 -  Pesquisar por editora \n");
        printf("3 -  Pesquisar por autor \n");
        printf("4 -  Pesquisar por ano \n");
        printf("0 -  Sair \n");
        printf("opcao: ");
        scanf("%i",&op_pesquisa);

        switch (op_pesquisa){
        case 1:
            printf("Informe o nome do Livro: ");
  				fflush(stdin);
  				gets(buscar);
  				while(j < i){
  					if (strcmp(livros[j].nome, buscar) == 0){
  						printf("Foram encontrados os seguintes livros o nome:  %s\n",livros[j].nome);
                        printf("\n\tLivro %i", j+1);
                        printf("\nNOME: %s", livros[j].nome);
                        printf("\nAUTOR(A): %s", livros[j].autor);
                        printf("\nQTD DE PAGINAS: %i", livros[j].qtdpg);
                        printf("\nEDITORA: %s", livros[j].editora);
                        printf("\nANO: %i", livros[j].ano);
                        printf("\nPRECO: R$%.2f\n", livros[j].preco);
  						break;
					  }
					  else {
                        printf("Nao foram encontrados registros\n");
					  }
					  j++;
				  }
				  system ("pause");

				  break;

        case 2:
            printf("Informe o nome da Editora: ");
  				fflush(stdin);
  				gets(buscar);
  				while(j < i){
  					if (strcmp(livros[j].editora, buscar) == 0){
  						printf("Foram encontrados os seguintes livros da editora:  %s\n",livros[j].editora);
                        printf("\n\tLivro %i", j+1);
                        printf("\nNOME: %s", livros[j].nome);
                        printf("\nAUTOR(A): %s", livros[j].autor);
                        printf("\nQTD DE PAGINAS: %i", livros[j].qtdpg);
                        printf("\nEDITORA: %s", livros[j].editora);
                        printf("\nANO: %i", livros[j].ano);
                        printf("\nPRECO: R$%.2f\n", livros[j].preco);
  						break;
					  }
					  else {
                        printf("Nao foram encontrados registros\n");
					  }
					  j++;
				  }
				  system ("pause");

				  break;

        case 3:
        printf("Informe o nome do autor: ");
  				fflush(stdin);
  				gets(buscar);
  				while(j < i){
  					if (strcmp(livros[j].autor, buscar) == 0){
  						printf("Foram encontrados os seguintes livros do autor:  %s:\n",livros[j].autor);
                        printf("\n\tLivro %i", j+1);
                        printf("\nNOME: %s", livros[j].nome);
                        printf("\nAUTOR(A): %s", livros[j].autor);
                        printf("\nQTD DE PAGINAS: %i", livros[j].qtdpg);
                        printf("\nEDITORA: %s", livros[j].editora);
                        printf("\nANO: %i", livros[j].ano);
                        printf("\nPRECO: R$%.2f\n", livros[j].preco);
  						break;
					  }
					  else {
                        printf("Nao foram encontrados registros\n");
					  }
					  j++;
				  }
				  system ("pause");
				  break;

        case 4:
            printf("Informe o ano de publicacao: ");
  				scanf("%i",&buscar_ano);
  				while(j < i){
  					if(buscar_ano == livros[j].ano){
  						printf("Foram encontrados com o ano:  %s\n",livros[j].editora);
                        printf("\n\tLivro %i", j+1);
                        printf("\nNOME: %s", livros[j].nome);
                        printf("\nAUTOR(A): %s", livros[j].autor);
                        printf("\nQTD DE PAGINAS: %i", livros[j].qtdpg);
                        printf("\nEDITORA: %s", livros[j].editora);
                        printf("\nANO: %i", livros[j].ano);
                        printf("\nPRECO: R$%.2f\n", livros[j].preco);
  						break;
					  }
					  else {
                        printf("Nao foram encontrados registros\n");
					  }
					  j++;
				  }
				  system ("pause");

				  break;

				  case 0: system ("cls");
				      menu();


        }


        }
}
void excluir_livros(){
char nome_livro[30];
int certeza;
	 j = 0;
            printf("Digite o nome do Livro que deseja excluir: ");
            fflush(stdin);
            gets(nome_livro);
            printf("Você tem certeza que deseja excluir o livro ? %s\n", nome_livro);
            printf("[1] - SIM | [2] - NAO: ");
            scanf("%i",&certeza);
            if (certeza == 1){
            while(j < i){
                if(strcmp(nome_livro, livros[j].nome) == 0){
                    printf("\n\tLivro %i \n", j+1);
                    strcpy(livros[j].nome, livros[j+1].nome);
                    strcpy(livros[j].autor, livros[j+1].autor);
                    livros[j].qtdpg = livros[j+1].qtdpg;
                    strcpy(livros[j].editora, livros[j+1].editora);
                    livros[j].ano = livros[j+1].ano;
                    livros[j].preco = livros[j+1].preco;
                    break;
                }
                else {
                    printf("Livro nao encontrado");
                }
            j++;

            }

                    livros[i].nome[0] = NULL;
                    livros[i].autor[0] =  NULL;
                    livros[i].qtdpg = NULL;
                    livros[i].editora[0] = NULL;
                    livros[i].ano = NULL;
                    livros[i].preco = 0;

                    i-- ;
            }
            else {
                menu();
            }

}

void prioritario(){
    int priori = i;

    if(priori < MAX){
        while(priori > -1){
            strcpy(livros[priori+1].nome, livros[priori].nome);
            strcpy(livros[priori+1].autor, livros[priori].autor);
            livros[priori+1].ISBN = livros[priori].ISBN;
            livros[priori+1].qtdpg = livros[priori].qtdpg;
            strcpy(livros[priori+1].editora,livros[priori].editora);
            livros[priori+1].ano = livros[priori].ano;
            livros[priori+1].preco = livros[priori].preco;
            --priori;
        }
    }
        priori++;
        system("cls");

        printf("---Cadastro n %i", i);
                printf("\nNome do livro: ");
  				fflush(stdin);
  				gets(livros[0].nome);
  				printf("\nAutor do livro: ");
  				fflush(stdin);
  				gets(livros[0].autor);
  				printf("\nISBN: ");
  				scanf("%i",&livros[0].ISBN);
  				printf("\nQuantidade de paginas do livro: ");
  				scanf("%i",&livros[0].qtdpg);
  				printf("\nEditora do livro: ");
  				fflush(stdin);
  				gets(livros[0].editora);
  				printf("\nAno do livro: ");
  				scanf("%i",&livros[0].ano);
  				printf("\nPreco do livro: ");
  				scanf("%f",&livros[0].preco);
  				printf("Cadastro realizado com sucesso");
}


void menu() {

        int op = 1;
        int cod;
        char nome[30];
        char autor[30];
        int ISBN;
        int qtdpg;
        char editora[30];
        int ano;
        float preco;


    while (op !=0){
        printf ("Livraria Livros.com\n");
        printf("--------------------\n");
        printf("1 -  Inserir Livro \n");
        printf("2 -  Cadastro Prioritário \n");
        printf("3 -  Exibir registros \n");
        printf("4 -  Pesquisar livros \n");
        printf("5 -  Excluir Livros\n");
        printf("0 -  Sair \n");
        printf("Opcao: ");
        scanf("%i", &op);

        switch (op){
            case 1: getlivros();
            system ("cls");
            break;
            case 2: prioritario();
            system ("cls");
            break;
            case 3: listar_livros();
            system ("cls");
            break;
            case 4: pesquisar();
            system ("cls");
            break;
            case 5: excluir_livros();
            system ("cls");
            break;
            case 0: exit (0);


        }


    }

}

void Login(){

    char login[15] = "admin";
    char loginuser[15];
    char senha[15] = "admin";
    char senhauser[15];
    int sucesso = 0; //0 - Falso e  1 - Verdadeiro

    while(!sucesso){
        printf("Digite o Login: ");
        scanf("%s", loginuser);

        printf("Digite a Senha: ");
        scanf("%s", senhauser);

        if (strcmp(login, loginuser) == 0 && strcmp(senha, senhauser) == 0){
            printf("\n\nBem vindo, %s\n\n", login);
            sucesso = 1;
            menu();
        }
        else
            printf("\n\nDADOS INVALIDOS!\n\n");
    }

}


int main (){
    Login();
    menu();
}
