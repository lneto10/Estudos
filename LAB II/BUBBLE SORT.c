#include <stdio.h>
#include <stdlib.h>
#define TAM 10

// Luiz Barboza Neto
int main()
{
 int num[TAM];
 int i = 0, aux, k = TAM - 1;

 while(i < TAM){
 printf("Digite o [%i] numero: ", i + 1);
 scanf("%d", &num[i]);
 i++;
 }

 while (k > 0){
   for (i = 0; i < k; i++) {
     if (num[i] > num[i + 1]) {
       aux = num[i];
       num[i] = num[i + 1];
       num[i + 1] = aux;
     }
   }
   k--;
 }
printf("\nElementos em ordem crescente:\n\n");
for (i = 0; i < TAM; i++) {
 printf("%4d", num[i]);
}
printf("\n");
return 0;
}
