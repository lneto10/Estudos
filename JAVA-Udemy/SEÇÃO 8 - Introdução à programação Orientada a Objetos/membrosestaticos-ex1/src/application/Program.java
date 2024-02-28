package application;


import util.CurrencyConverter;

import java.util.Locale;
import java.util.Scanner;

public class Program {

    public static void main(String[] args) {

        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);


        System.out.println("What is the dollar price? ");
        double dollar = sc.nextDouble();

        System.out.println("How many dollars will be dought? ");
        double dol = sc.nextDouble();

        double res = CurrencyConverter.calculo(dollar,dol);

        System.out.printf("Amount to be paid in reais %.2f%n ", res);
    }
}
