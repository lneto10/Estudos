package application;

import java.util.Locale;
import java.util.Scanner;

import entities.Product;

public class Program {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
			Locale.setDefault(Locale.US);
			Scanner sc = new Scanner(System.in);
			
			Product product = new Product();
			System.out.println("Insira o nome do produto");
			System.out.print("Nome: ");
			product.name = sc.nextLine();
			System.out.print("Preço: ");
			product.price = sc.nextDouble();
			System.out.print("Quantidade em estoque: ");
			product.quantity = sc.nextInt();
			
			System.out.println();
			System.out.println("Dados do produto: "+product);
			
			System.out.println();
			System.out.println("Insira o numero de produtos a ser adicionado no estoque:  ");
			int quantity = sc.nextInt();
			product.addProducts(quantity);
			System.out.println();
			System.out.println("Dados atualizados: "+product);
			
			
			System.out.println();
			System.out.println("Insira o numero de produtos a ser retirado no estoque:  ");
			quantity = sc.nextInt();
			product.removeProducts(quantity);
			System.out.println();
			System.out.println("Dados atualizados: "+product);
			
			sc.close();
			
	}
	

}
