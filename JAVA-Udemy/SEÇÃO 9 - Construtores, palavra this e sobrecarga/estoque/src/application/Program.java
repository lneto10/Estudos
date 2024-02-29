package application;

import entities.Product;

import java.util.Locale;
import java.util.Scanner;

public class Program {

        public static void main (String[] args){
            Locale.setDefault(Locale.US);
            Scanner sc = new Scanner(System.in);



            System.out.println("Enter product data: ");
            System.out.print("Name: ");
            String name = sc.nextLine();
            System.out.print("Price: ");
            double price = sc.nextDouble();


            Product product = new Product(name,price);

            System.out.println("Product Data: "+product);
            System.out.println();
            System.out.println("Enter the number of product to be added in stock: ");
            int quantity = sc.nextInt();

            product.addProducts(quantity);
            System.out.println();
            System.out.println("Update Data "+product);

            System.out.println();
            System.out.println("Enter the number of product to be removed in stock: ");
            quantity = sc.nextInt();
            product.removeProducts(quantity);

            System.out.println();
            System.out.println("Update Data "+product);




            sc.close();
        }
}
