package application;

import java.util.Locale;
import java.util.Scanner;

import model.entities.Account;
import model.exceptions.BusinessException;

public class Program {

    public static void main(String[] args) {

        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        System.out.println("Informe os dados da conta");
        System.out.print("Informe o numero da conta: ");
        int number = sc.nextInt();
        System.out.print("Informe o nome do portador: ");
        sc.nextLine();
        String holder = sc.nextLine();
        System.out.print("Saldo inicial: ");
        double balance = sc.nextDouble();
        System.out.println("Limite da conta: ");
        double withdrawLimit = sc.nextDouble();

        Account acc = new Account(null, holder, balance, withdrawLimit);
        System.out.println();

        System.out.println("Informe uma quantia para sacar ");
        double saque = sc.nextDouble();

        try {
            acc.withdraw(saque);
            System.out.printf("Novo saldo: %.2f%n", acc.getBalance());
        }
        catch (BusinessException e ){
            System.out.println(e.getMessage());
        }

        sc.close();
    
    }

}
