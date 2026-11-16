package model;

import java.sql.Date;
import java.sql.Time;

public class Appointment8 {
    private int id;
    private Date date;
    private Time time;
    private Customer8 c;

    public Appointment8() {}
    public Appointment8(int id, Date date, Time time, Customer8 c) {
        this.id = id;
        this.date = date;
        this.time = time;
        this.c = c;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public Time getTime() { return time; }
    public void setTime(Time time) { this.time = time; }
    public Customer8 getC() { return c; }
    public void setC(Customer8 c) { this.c = c; }
}