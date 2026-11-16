package dao;

import model.Staff8;
import model.SaleStaff8;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StaffDAO extends DAO {
    public StaffDAO() { super(); }

    public Staff8 checkLogin(String username, String password) {
        String sql = "SELECT p.id, p.name, p.address, p.phone, p.email, s.username, s.password, s.position " +
                     "FROM tblPerson8 p JOIN tblStaff8 s ON p.id = s.personID " +
                     "WHERE s.username = ? AND s.password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                SaleStaff8 staff = new SaleStaff8();
                staff.setId(rs.getInt("id"));
                staff.setName(rs.getString("name"));
                staff.setAddress(rs.getString("address"));
                staff.setPhone(rs.getString("phone"));
                staff.setEmail(rs.getString("email"));
                staff.setUsername(rs.getString("username"));
                staff.setPassword(rs.getString("password"));
                staff.setPosition(rs.getString("position"));
                return staff;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}