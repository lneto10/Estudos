package program;
/*
*Fazer um programa para ler nome, idade e altura de N pessoas, conforme exemplo. Depois, mostrar na
tela a altura média das pessoas, e mostrar também a porcentagem de pessoas com menos de 16 anos,
bem como os nomes dessas pessoas caso houver.
*
* Luiz Neto
* 11/05/2024
* */
import entities.Pessoa;

import java.util.Locale;
import java.util.Scanner;

public class EX3 {
    public static void main(String[] args) {


        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);
        System.out.println("Quantas pessoas serão digitadas: ");
        int n = sc.nextInt();
        Pessoa[] vect = new Pessoa[n];

        for (int i = 0; i < n; i++) {
            System.out.println("Dados da " + (i+1) + "a pessoa: ");
            sc.nextLine();
            System.out.println("Nome: ");
            String nome = sc.nextLine();
            System.out.println("Idade: ");
            int idade = sc.nextInt();
            System.out.println("Altura: ");
            double altura = sc.nextDouble();
            vect[i] = new Pessoa(nome, idade, altura);
        }

        double soma = 0.0;
        int menor = 0;
        for(int i = 0;i<n;i++){
            if (vect[i].getIdade() < 16){
                menor++;
            }
            soma += vect[i].getAltura();

        }
        double media = soma/n;
        double percentualMenores = ((double)menor / n) * 100.0;


        System.out.println("Altura é: "+media);
        System.out.printf("Pessoas com menos de 16 anos: %.1f%%\n", percentualMenores);

        for (int i = 0; i<n; i++){
            if(vect[i].getIdade()<16){
                System.out.printf("%s\n", vect[i].getNome());
            }
        }
    }

}
