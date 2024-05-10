package application;

import java.util.Scanner;
import java.util.Locale;
public class Program {
    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        System.out.println("Informe a quantidade de pessoas: ");
        int n = sc.nextInt();
        double[] vect = new double[n]; // cria o vetor

        System.out.println("Informe as alturas: ");
        for (int i=0;i<n;i++){
            vect[i] = sc.nextDouble();
        }

        double sum = 0.0;
        for (int i = 0;i<n;i++){
            sum += vect[i];
        }

        double avg = sum/n;

        System.out.println("Average Height: "+avg);

        sc.close();


    }

}
