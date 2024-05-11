package program;
/*
* Faça um programa que leia N números reais e armazene-os em um vetor. Em seguida:
- Imprimir todos os elementos do vetor
- Mostrar na tela a soma e a média dos elementos do vetor
*
* Luiz Neto
* 11/05/2024
* */

import java.util.Locale;
import java.util.Scanner;



public class EX2 {

    public static void main(String[] args) {


        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        System.out.println("Quantos numeros você vai digitar: ");
        int n = sc.nextInt();
        double vet[] = new double[n];

        for (int i = 0; i < n; i++) {
            System.out.println("Digite um numero: ");
            vet[i] = sc.nextDouble();
        }

        double soma = 0;
        for (int i = 0; i < n; i++) {
            System.out.println(vet[i]);
            soma += vet[i];
        }
        System.out.println("Soma = " +soma);
        double media = soma / n;
        System.out.println("Media = " + media);
    }
}
