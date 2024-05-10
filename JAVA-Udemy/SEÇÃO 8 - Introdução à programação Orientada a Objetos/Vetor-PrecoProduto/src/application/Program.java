package application;

import entities.Product;

import java.util.Locale;
import java.util.Scanner;

public class Program {

    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();
        Product[] vect = new Product[n];

        //a cada nova posição do vetor, é necessário instanciar a classe.
        for (int i = 0; i<n; i++){ //poderia ser utilizado o atributo length(). ex: vect.length
            sc.nextLine();
            String name = sc.nextLine();
            double price = sc.nextDouble();
            vect[i] = new Product(name,price);

        }

        double sum = 0.0;
        for (int i=0; i<n; i++){
            sum += vect[i].getPrice();
        }

        double avg = sum / n;
        System.out.println("AVERAGE PRICE "+avg);
        sc.close();
    }
}
