package model;

public class TechnicalStaff8 extends Staff8 {
    private String major;

    public TechnicalStaff8() { super(); }
    public TechnicalStaff8(int id, String name, String address, String phone, String email, String major) {
        super(id, name, address, phone, email, "", "", "Technical Staff");
        this.major = major;
    }
    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }
}