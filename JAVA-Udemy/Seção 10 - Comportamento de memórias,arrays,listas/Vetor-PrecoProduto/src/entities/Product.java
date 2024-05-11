package entities;

public class Product {

    private String name;
    private double price;

    public Product(java.lang.String name, double price) {
        this.name = name;
        this.price = price;
    }

    public java.lang.String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public void setName(java.lang.String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
