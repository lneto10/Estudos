package util;

public class CurrencyConverter {

    public static final double IOF = 0.06;

    public static double calculo(double price, double dollars){
        double res = price * dollars;
        return res + (res * IOF);
    }
}
