package model;

import java.sql.Date;
import java.util.ArrayList;

public class RepairOrder8 {
    private int id;
    private Date receivedDate;
    private SaleStaff8 s;
    private Customer8 c;
    private Car8 car;
    private ArrayList<UsedSparePart8> usp;
    private ArrayList<UsedService8> us;
    private ArrayList<TechnicalAssignment8> ta;

    public RepairOrder8() {
        this.usp = new ArrayList<>();
        this.us = new ArrayList<>();
        this.ta = new ArrayList<>();
    }
    public double calTotalSparePart() {
        double total = 0;
        if (usp != null) {
            for (UsedSparePart8 item : usp) { total += item.calSubTotal(); }
        }
        return total;
    }
    public double calTotalService() {
        double total = 0;
        if (us != null) {
            for (UsedService8 item : us) { total += item.getPrice(); }
        }
        return total;
    }
    public double calGrandTotal() { return calTotalSparePart() + calTotalService(); }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getReceivedDate() { return receivedDate; }
    public void setReceivedDate(Date receivedDate) { this.receivedDate = receivedDate; }
    public SaleStaff8 getS() { return s; }
    public void setS(SaleStaff8 s) { this.s = s; }
    public Customer8 getC() { return c; }
    public void setC(Customer8 c) { this.c = c; }
    public Car8 getCar() { return car; }
    public void setCar(Car8 car) { this.car = car; }
    public ArrayList<UsedSparePart8> getUsp() { return usp; }
    public void setUsp(ArrayList<UsedSparePart8> usp) { this.usp = usp; }
    public ArrayList<UsedService8> getUs() { return us; }
    public void setUs(ArrayList<UsedService8> us) { this.us = us; }
    public ArrayList<TechnicalAssignment8> getTa() { return ta; }
    public void setTa(ArrayList<TechnicalAssignment8> ta) { this.ta = ta; }
}