package application;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Scanner;

import model.entities.CarRental;
import model.entities.Vehicle;
import model.services.BrazilTaxService;
import model.services.RentalService;

public class Program {
    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        System.out.println("Entre com os dados do aluguel: ");
        System.out.print("Modelo do Carro: ");
        String carModel = sc.nextLine();
        System.out.println("Retirada (dd/mm/yyyy)");
        LocalDateTime start = LocalDateTime.parse(sc.nextLine(),fmt);
        System.out.println("Retirada (dd/mm/yyyy)");
        LocalDateTime finish = LocalDateTime.parse(sc.nextLine(),fmt);

        CarRental cr = new CarRental(start,finish,new Vehicle(carModel));

        System.out.println("Entre com o preço por hora: ");
        double pricePerHour = sc.nextDouble();
        System.out.println("Entre com o preço por dia");
        double pricePerDay = sc.nextDouble();

        RentalService rentalservice = new RentalService(pricePerHour,pricePerDay, new BrazilTaxService());

        rentalservice.processInvoice(cr);

        System.out.println("Fatura: ");
        System.out.println("Pagamento Básico: "+cr.getInvoice().getBasicPayment());
        System.out.println("Imposto: "+cr.getInvoice().getTax());
        System.out.println("Pagamento total: "+cr.getInvoice().getTotalPayment());


        sc.close();
    }

}
