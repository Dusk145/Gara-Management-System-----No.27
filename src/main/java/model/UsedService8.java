package model;

public class UsedService8 {
    private int id;
    private double price;
    private Service8 ser;

    public UsedService8() {}
    public UsedService8(int id, double price, Service8 ser) {
        this.id = id;
        this.price = price;
        this.ser = ser;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public Service8 getSer() { return ser; }
    public void setSer(Service8 ser) { this.ser = ser; }
}