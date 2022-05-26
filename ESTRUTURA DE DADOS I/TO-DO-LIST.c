#include <stdio.h>
#include <stdlib.h>
#define MAX 20

/*Luiz Barboza Neto
Cod: 836428 */

struct cadastro
{
        int cod;
        char nome[30];
};

struct lista_pendentes
{
    int qtd;
    struct cadastro t[MAX];
};

struct lista_concluidas
{
    int qtd;
    struct cadastro t[MAX];
};


int i = 0,j=0, x=0, indice=-1;
struct lista_pendentes lp;
struct lista_concluidas lc;



void inicia()
{
    lp.qtd = -1;
    lc.qtd = -1;
}
int cheia()
{
    return lp.qtd == MAX;
}
int cheia_concluida()
{
    return lc.qtd == MAX;
}

void inputdata()
{

                if (!cheia(lp))
                {
                    lp.qtd ++;
                    indice++;
                    printf("---Cadastro tarefa n %i", indice);
                    printf("\nNome da tarefa: ");
                    fflush(stdin);
                    lp.t[lp.qtd].cod = indice;
                    gets(lp.t[lp.qtd].nome);
                    i++;
                    printf("Cadastro realizado com sucesso");

                }
                else
                {
                    printf("Lista de tarefas completa\n");
                    system ("pause");
                }


}
void listar_tarefas_pendentes(){
    j = 0;

    if (i==0)
    {
        printf("Nao possui tarefas cadastradas\n");
        system ("pause");
    }

    else
    {
            printf("Tarefas Registradas\n\n");
    while (j < i)
    {

            printf("\nTarefas ");
        	printf("\nTarefa n %d:\nNome: %s\n", lp.t[j].cod,lp.t[j].nome);
        	j++;

    }
  			system ("pause");


    }
}

void tarefas_concluidas()
{
    j =0;
    int cod_tarefa;

    listar_tarefas_pendentes();
    j = 0;
  			printf ("Digite o codigo da tarefa para concluir: ");
  			fflush(stdin);
  			scanf("%d", &cod_tarefa);
  			while(j < i)
                if (cod_tarefa == lp.t[j].cod)
                {
                    if (!cheia_concluida(lc))
                    {
                    lc.qtd++;
                    indice++;
                    lc.t[j].cod=indice;
                    strcpy(lc.t[lc.qtd].nome,lp.t[j].nome);
                    x++;
                        while (j <= i)
                        {
                            strcpy(lp.t[j].nome, lp.t[j+1].nome);
                            j++;
                        }
                    i--;
                    lp.qtd--;
                    break;
                    }
                    else
                    {
                        printf("Lista cheia");
                    }
                }
               else
                {
                j++;
                }

}


void listar_tarefas_concluidas()
{
    j =0;

    if (x==0)
    {
        printf("Nao possui tarefas cadastradas\n");
        system ("pause");
    }

    else
    {
            printf("Tarefas Registradas\n\n");
    while (j < x)
    {

            printf("\n\tTarefas");
        	printf("\nTarefa n %d:\nNome: %s\n", lc.t[j].cod,lc.t[j].nome);
        	j++;

    }

        system ("pause");

    }
}


void estornar_tarefas()
{
    int cod_tarefa;
    listar_tarefas_concluidas();
    j = 0;
  			printf ("Digite o codigo da tarefa para estornar: ");
  			fflush(stdin);
  			scanf("%d", &cod_tarefa);
  			while(j < x)
                if (cod_tarefa == lc.t[j].cod)
                {
                    if (!cheia(lp))
                    {
                    lp.qtd++;
                    indice++;
                    lp.t[j].cod=indice;
                    strcpy(lp.t[lp.qtd].nome,lc.t[j].nome);
                    i++;
                    while (j <= x)
                    {
                    strcpy(lc.t[j].nome, lc.t[j+1].nome);
                    j++;
                    }
                    x--;
                    break;
                    }
                    else
                    {
                        printf("Lista cheia");
                    }
                }
               else
                {
                j++;
                }





}

void exclusao()
{
    int opcao;
    int cod_tarefa;
    printf("Qual lista deseja excluir? [1] Tarefas Pendentes | [2] Tarefas Concluidas");
    scanf ("%d", &opcao);

        switch (opcao)
        {
            case 1:
                j =0;
                listar_tarefas_pendentes();


            j = 0;
  			printf ("Digite o codigo da tarefa para exclusao: ");
  			fflush(stdin);
  			scanf("%d", &cod_tarefa);


                while (j < i)
                {
                    if (cod_tarefa == lp.t[j].cod)
                {
                            strcpy(lp.t[j].nome, lp.t[j+1].nome);
                            j++;
                            break;
                }
                else
                {
                    j++;
                }
                }
                    i--;
                    lp.qtd--;
                    break;

            case 2:
                j =0;
                listar_tarefas_concluidas();
            j = 0;
  			printf ("Digite o codigo da tarefa para exclusao: ");
  			fflush(stdin);
  			scanf("%d", &cod_tarefa);

                while (j <= x)
                        {
                         if (cod_tarefa == lc.t[j].cod)
                        {
                            strcpy(lc.t[j].nome, lc.t[j+1].nome);
                            j++;
                        }
                    x--;
                    lc.qtd--;
                        }
                }
    }


void menu()
{

        int op = 1;
        char nome[30];

    while (op !=0)
    {
        printf ("TO-DO-LIST\n");
        printf("--------------------\n");
        printf("1 -  Inserir Tarefa \n");
        printf("2 -  Listar Tarefas \n");
        printf("3 -  Marcar tarefa como concluido \n");
        printf("4 -  Listar Tarefas concluidas \n");
        printf("5 -  Estornar tarefas \n");
        printf("6 -  Excluir tarefas \n");
        printf("0 -  Sair \n");
        printf("Opcao: ");
        scanf("%i", &op);

        switch (op)
        {
            case 1: inputdata();
            system ("cls");
            break;
            case 2: listar_tarefas_pendentes();
            system ("cls");
            break;
            case 3: tarefas_concluidas();
            system ("cls");
            break;
            case 4: listar_tarefas_concluidas();
            system ("cls");
            break;
            case 5: estornar_tarefas ();
            system("cls");
            break;
            case 6: exclusao();
            system ("cls");
            break;


        }


    }

}



int main ()
{
    inicia();
    menu();

}
