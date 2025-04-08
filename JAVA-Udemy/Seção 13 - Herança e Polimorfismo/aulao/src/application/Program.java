package application;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

import entities.Company;
import entities.Individual;
import entities.TaxPayer;

public class Program {

    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        List<TaxPayer> list = new ArrayList<TaxPayer>();

        
        System.out.print("Enter the number of taxpayers: ");
        int N = sc.nextInt();
        
        for (int i = 1; i <= N; i++){
            System.out.println("Taxpayer #" + i + "data: ");
            System.out.println("Individual or company (i/c)");
            char type = sc.next().charAt(0);

            System.out.println(" Name: ");
            String name = sc.next();
            System.out.println(" Anual income: ");
            Double anualIncome = sc.nextDouble();

            if (type == 'i'){
                System.out.println(" Health Expenditures: ");
                Double he = sc.nextDouble();
                Individual x = new Individual(name, anualIncome, he);
                list.add(x);
            }
            else{
                System.out.println("Number of Employees");
                int e = sc.nextInt();
                Company x = new Company(name, anualIncome, e);
                list.add(x);
            }

        }

        System.out.println("");
        System.out.println("Taxes Paid: ");
        double sum = 0.0;
        for (TaxPayer tp : list ){
            System.out.println(tp.getName() + ": $ : "+String.format("%2.f", tp.tax()));
            sum += tp.tax();
        }

        System.out.println("Total tax: "+sum);

        sc.close();

    }

}
