package entities;

public class Product {
	
	private String name;
	private double price;
	private int quantity;
	
	//Método construtor
	public Product (String name,double price, int quantity) {
		this.name = name;
		this.price = price;
		this.quantity = quantity;
	}
	
	public Product (String name,double price) {
		this.name = name;
		this.price = price;
		
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getName(){
		return name;
	}
	
	public Double getPrice() {
		return price;
	}
	
	public void setPrice (double price) {
		this.price = price;
	}
	
	public int getQuantity () {
		return quantity;
	}
	//Calcula valor em estoque
	public double totalvalueInStock() {
		return price * quantity;
	}
	
	//Adiciona produtos ao estoque
	public void addProducts(int quantity) {
		this.quantity += quantity;
	}

	public void removeProducts(int quantity) {
		this.quantity -= quantity;
	}
	
	public String toString() {
		return name
				+ ", $"
				+ price
				+ ", "
				+ quantity
				+ "unidades, Total: $"
				+ totalvalueInStock();
	}
}
