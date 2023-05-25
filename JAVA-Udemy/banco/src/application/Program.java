package application;

import java.util.Locale;
import java.util.Scanner;

import entities.Account;

public class Program {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Locale.setDefault(Locale.US);
		Scanner sc = new Scanner (System.in);
		Account account;
		
		System.out.println("Insira o numero da conta: ");
		int number = sc.nextInt();
		System.out.println("Insira o nome do portador: ");
		sc.nextLine();
		String holder = sc.nextLine();
		System.out.println("Deseja inserir um depósito inicial? ");
		char response = sc.next().charAt(0);
		if (response == 'y') {
			System.out.println("Insira o valor inicial de depósito: ");
			double initialDeposit = sc.nextDouble();
			account = new Account(number, holder, initialDeposit);
			
		} else {
			account = new Account(number, holder);
		}
		
		System.out.println();
		System.out.println("Dados da conta: ");
		System.out.println(account);
		
		System.out.println();
		System.out.println("Insira um valor para depósito: ");
		double depositValue = sc.nextDouble();
		account.deposit(depositValue);
		System.out.print("Saldo atualizado: ");
		System.out.print(account);
		System.out.println("Insira um valor para saque: ");
		double saqueValue = sc.nextDouble();
		account.withdraw(saqueValue);
		System.out.print("Saldo atualizado: ");
		System.out.print(account);
		
		sc.close();
	}

}
