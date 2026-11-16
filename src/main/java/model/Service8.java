package model;

public class Service8 {
    private int id;
    private String name;
    private String description;
    private String group;
    private double price;

    public Service8() {}
    public Service8(int id, String name, String description, String group, double price) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.group = group;
        this.price = price;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getGroup() { return group; }
    public void setGroup(String group) { this.group = group; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}