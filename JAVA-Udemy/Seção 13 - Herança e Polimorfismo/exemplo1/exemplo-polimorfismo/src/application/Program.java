package application;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

import entities.Employee;
import entities.OutsourcedEmployee;

public class Program {

    public static void main(String[] args) {

        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter the number of employees: ");
        int n = sc.nextInt();

        List<Employee> list = new ArrayList<>();

        for(int i=1; i<=n; i++){
            System.out.println("Employee #"+ i + " data");
            System.out.print("Outsourced (y/n)? ");
            char ch = sc.next().charAt(0);
            System.out.print("Name: ");
            sc.nextLine();
            String name = sc.nextLine();
            System.out.print("Hours: ");
            int hours = sc.nextInt();
            System.out.println("Value per hour: ");
            double valueperHour = sc.nextDouble();

            if (ch == 'y'){
                System.out.print("Additional Charge: ");
                double additionalCharge = sc.nextDouble();

                list.add(new OutsourcedEmployee(name, hours, valueperHour, additionalCharge));

            }
            else{
                list.add(new Employee(name, hours, valueperHour));
            

        }

    }
    System.out.println();

    System.out.println("PAYMENTS: ");
    for (Employee emp : list){
        System.out.println(emp.getName() + " - $ " + String.format("%.2f", emp.payment()));    
    
    }


        sc.close();

    }

   

}
