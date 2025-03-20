package application;

import entities.Account;
import entities.BusinessAccount;
import entities.SavingsAccount;

public class ProgramEx1 {

	public static void main(String[] args) {

		//BusinessAccount account = new BusinessAccount(8010, "Bob Brown", 0.0, 500.0);

		//System.out.println(account.getBalance());

		Account acc = new Account(1001,"Luiz", 0.0);
		BusinessAccount bacc = new BusinessAccount(1002, "Carol", 0.0, 500.00);

		//Upcasting
		Account acc1 = bacc;
		acc1.getBalance();
		Account acc2 = new BusinessAccount(1003, "Bob", 0.0, 200.00);
		Account acc3 = new SavingsAccount(1004, "Theo", 0.0, 0.01);

		//Dowcasting 
		BusinessAccount acc4 = (BusinessAccount)acc2;
		acc4.loan(100.00);

		if (acc3 instanceof BusinessAccount){
		BusinessAccount acc5 = (BusinessAccount) acc3;
		acc5.loan(200);
		System.out.println("Loan");
		}
		if (acc3 instanceof SavingsAccount){
			SavingsAccount acc5 = (SavingsAccount)acc3;
			acc5.updateBalance();
			System.out.println("Update");
		}
	}
}