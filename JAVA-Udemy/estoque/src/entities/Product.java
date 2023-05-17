package entities;

public class Product {
	
	public String name;
	public double price;
	public int quantity;
	
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
