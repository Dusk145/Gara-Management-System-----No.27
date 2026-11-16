package model;

public class UsedSparePart8 {
    private int id;
    private double price;
    private int quantity;
    private SparePart8 sp;

    public UsedSparePart8() {}
    public UsedSparePart8(int id, double price, int quantity, SparePart8 sp) {
        this.id = id;
        this.price = price;
        this.quantity = quantity;
        this.sp = sp;
    }
    public double calSubTotal() { return price * quantity; }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public SparePart8 getSp() { return sp; }
    public void setSp(SparePart8 sp) { this.sp = sp; }
}