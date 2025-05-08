package application;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Scanner;

import model.entities.Contract;
import model.entities.Installment;
import model.services.ContractService;
import model.services.MercadoPagoService;
import model.services.PaypalService;

public class Program {

    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);

        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        System.out.println("Informe os dados contrato: ");
        System.out.print("Numero: ");
        Integer numero = sc.nextInt();
        System.out.println("Data (dd/mm/YYYY): ");
        LocalDate date = LocalDate.parse(sc.next(),fmt);
        System.out.print("Valor do contrato: ");
        double totalValue = sc.nextDouble();

        Contract contract = new Contract(numero, date, totalValue);
        
        System.out.println("Entre com o numero de parcelas: ");
        int parcelas = sc.nextInt();

        ContractService contractService = new ContractService(new MercadoPagoService());
        
        contractService.processContract(contract, parcelas);
        
        System.out.println("Parcelas ");
        for (Installment installment : contract.getInstallments()){
            System.out.println(installment);
        }


        sc.close();
    }
}
