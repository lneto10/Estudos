#include <stdio.h>
#include <stdlib.h>
#define MAX 50

struct cadastro
{
    char sigla[5];
    float vabertura;
    float vmin;
    float vmax;
    float vfecha;
    float vmed;
    float vlucro;
    float vpercen;

};
int i = 0;


struct cadastro acoes[MAX];
struct cadastro acoesmaior[MAX];
struct cadastro acoesmenor[MAX];


void cadastroacoes ()
{
    printf (":: Cadastro de Acoes  %d\n", i);
    printf ("\nInforme a sigla do papel: ");
    fflush(stdin);
    gets(acoes[i].sigla);
    printf ("Informe o valor de Abertura: ");
    scanf  ("%f",&acoes[i].vabertura);
    printf ("Informe o valor minimo: ");
    scanf  ("%f", &acoes[i].vmin);
    printf ("Informe o valor máximo: ");
    scanf  ("%f", &acoes[i].vmax);
    printf ("Informe o valor de fechamento: ");
    scanf  ("%f", &acoes[i].vfecha);
    printf ("Cadastro realizado com sucesso\n");
    acoes[i].vmed = 0;
    acoes[i].vmed = (acoes[i].vabertura + acoes[i].vmin + acoes[i].vmax + acoes[i].vfecha) / 4;
    acoes[i].vlucro = (acoes[i].vfecha - acoes[i].vabertura);
    acoes[i].vpercen = (acoes[i].vfecha - acoes[i].vabertura) / acoes[i].vabertura * 100;
    i++;
    system ("pause");

}

void listaacoes ()
{

    for (int x = 0; x <= i; x++)
    {
        printf ("Acoes Registradas");
        printf ("\nSigla: %s", acoes[x].sigla);
        printf ("\nValor Abertura: R$%.2f", acoes[x].vabertura);
        printf ("\nValor Minimo: R$%.2f", acoes[x].vmin);
        printf ("\nValor Máximo: R$%.2f", acoes[x].vmax);
        printf ("\nValor Fechamento: R$%.2f", acoes[x].vfecha);
        printf ("\nValor Medio: R$%.2f", acoes[x].vmed);
        printf ("\nValor Lucro: R$%.2f\n", acoes[x].vlucro);
        printf ("\nPercentual: R$%.2f\n", acoes[x].vpercen);

    }
    system ("pause");
}
void recupera ()
{
    int j = 0;
    char buscar [5];
        printf("Informe a sigla do papel: ");
        fflush(stdin);
        gets(buscar);
  				while(j < i){
  					if (strcmp(acoes[j].sigla, buscar) == 0){
  						printf("Foram encontrados os seguintes papeis:  %s\n",acoes[j].sigla);
                        printf("\SIGLA: %s", acoes[j].sigla);
                        printf ("\nValor Abertura: R$%.2f", acoes[j].vabertura);
                        printf ("\nValor Minimo: R$%.2f", acoes[j].vmin);
                        printf ("\nValor Máximo: R$%.2f", acoes[j].vmax);
                        printf ("\nValor Fechamento: R$%.2f\n", acoes[j].vfecha);
                        printf ("\nValor Medio: R$%.2f", acoes[j].vmed);
                        printf ("\nValor Lucro: R$%.2f\n", acoes[j].vlucro);
                        printf ("\nPercentual: R$%.2f\n", acoes[j].vpercen);
  						break;
					  }
					  else {
                        printf("Nao foram encontrados registros\n");
					  }
					  j++;
				  }
				  system ("pause");

}

void acaovalor ()
{
    int maior = acoes[0].vlucro;

    for (int j = 0; j < i; j++)
    {
        if (acoes[j].vlucro > maior)
        {
            strcpy(acoes[j].sigla, acoesmaior[j].sigla);
            acoesmaior[j].vabertura = acoes[j].vabertura;
            acoesmaior[j].vmin = acoes[j].vmin;
            acoesmaior[j].vmax = acoes[j].vmax;
            acoesmaior[j].vfecha = acoes[j].vfecha;
            acoesmaior[j].vmed = acoes[j].vmed;
            acoesmaior[j].vlucro = acoes[j].vlucro;
            acoesmaior[j].vpercen = acoes[j].vpercen;
        }


    }
    for (int j = 0; j < i; j++) {
        printf("\SIGLA: %s", acoesmaior[j].sigla);
        printf ("\nValor Abertura: R$%.2f", acoesmaior[j].vabertura);
        printf ("\nValor Minimo: R$%.2f", acoesmaior[j].vmin);
        printf ("\nValor Máximo: R$%.2f", acoesmaior[j].vmax);
        printf ("\nValor Fechamento: R$%.2f\n", acoesmaior[j].vfecha);
        printf ("\nValor Medio: R$%.2f", acoesmaior[j].vmed);
        printf ("\nValor Lucro: R$%.2f\n", acoesmaior[j].vlucro);
        printf ("\nPercentual: R$%.2f\n", acoesmaior[j].vpercen);
    }
    system ("pause");
}

void menu ()
{
    int op = 1;
    char sigla[5];
    float vabertura;
    float vmin;
    float vmax;
    float vfecha;
    float vmed;

    while (op!=5)
    {
        printf (":: MERCADO DE ACOES :: \n");
        printf ("---------------------\n");
        printf ("1 - CADASTRAR PAPEIS\n");
        printf ("2 - LISTAR ACOES\n");
        printf ("3 - RECUPERAR INFORMACOES DE UM PAPEL\n");
        printf ("4 - EXIBIR ACAO COM MAIOR VALOR\n");
        printf ("5 - SAIR\n");
        printf("Informe a opcao: ");
        scanf ("%d", &op);

        switch (op)
        {
        case 1:
            cadastroacoes();
            system ("cls");
            break;
        case 2:
            listaacoes ();
            system ("cls");
            break;
        case 3:
            recupera();
            system("cls");
            break;
        case 4:
            acaovalor();
            system ("cls");
            break;
        case 5:
            exit (0);

        }
    }



}


int main ()
{
    menu();
}
