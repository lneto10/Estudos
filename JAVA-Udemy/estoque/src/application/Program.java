package application;

import java.util.Locale;
import java.util.Scanner;

import entities.Product;

public class Program {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Locale.setDefault(Locale.US);
		Scanner sc = new Scanner(System.in);

		
		System.out.println("Insira o nome do produto");
		System.out.print("Nome: ");
		String name = sc.nextLine();
		System.out.print("Preço: ");
		Double price = sc.nextDouble();
		
		Product product = new Product(name,price);
		
		product.setName("Computer");
		System.out.println("Updated name: " + product.getName());
		product.setPrice(1200.00);
		System.out.println("Update price: "+ product.getPrice());

		System.out.println();
		System.out.println("Dados do produto: " + product);

		System.out.println();
		System.out.println("Insira o numero de produtos a ser adicionado no estoque:  ");
		int quantity = sc.nextInt();
		product.addProducts(quantity);
		System.out.println();
		System.out.println("Dados atualizados: " + product);

		System.out.println();
		System.out.println("Insira o numero de produtos a ser retirado no estoque:  ");
		quantity = sc.nextInt();
		product.removeProducts(quantity);
		System.out.println();
		System.out.println("Dados atualizados: " + product);

		sc.close();

	}

}
