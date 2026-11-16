package model;
import java.util.ArrayList;

public class Customer8 extends Person8 {
    private ArrayList<Car8> cars;
    public Customer8() { super(); this.cars = new ArrayList<>(); }
    public Customer8(int id, String name, String address, String phone, String email) {
        super(id, name, address, phone, email);
        this.cars = new ArrayList<>();
    }
    public ArrayList<Car8> getCars() { return cars; }
    public void setCars(ArrayList<Car8> cars) { this.cars = cars; }
}