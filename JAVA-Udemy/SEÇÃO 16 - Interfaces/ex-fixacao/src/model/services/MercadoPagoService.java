package model.services;

public class MercadoPagoService implements OnlinePaymentService{

    @Override
    public double paymentFee(double amount){
        return amount * 1.2;
    }

    @Override
    public double interest(double amount, int months){
        return amount * 1.01 * months;
    }



}


