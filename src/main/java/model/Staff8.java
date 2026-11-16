package model;

public class Staff8 extends Person8 {
    private String username;
    private String password;
    private String position;

    public Staff8() { super(); }
    public Staff8(int id, String name, String address, String phone, String email, String username, String password, String position) {
        super(id, name, address, phone, email);
        this.username = username;
        this.password = password;
        this.position = position;
    }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
}