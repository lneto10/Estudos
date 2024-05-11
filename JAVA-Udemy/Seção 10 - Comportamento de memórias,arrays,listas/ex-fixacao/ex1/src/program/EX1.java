package program;

import java.util.Scanner;
import java.util.Locale;
/*
* EX 1 - Faça um programa que leia um número inteiro positivo N (máximo = 10) e depois N números inteiros
e armazene-os em um vetor. Em seguida, mostrar na tela todos os números negativos lidos.
*
* Luiz Neto
* 11/05/2024
* */
public class EX1 {
    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        System.out.println("Quantos numeros você vai digitar: ");
        int n = sc.nextInt();
        int vet[] = new int[n];

        for (int i = 0;i<n;i++){
            System.out.println("Digite um numero: ");
            vet[i] = sc.nextInt();
        }

        System.out.println("Números negativos: ");
        for (int i = 0; i<n;i++){
            if (vet[i] < 0){
                System.out.println(vet[i]);
            }
        }



    }
}
