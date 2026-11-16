package dao;

import model.TechnicalStaff8;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TechnicalStaffDAO extends DAO {
    public TechnicalStaffDAO() { super(); }

    public ArrayList<TechnicalStaff8> findTechnicalStaff(String name) {
        ArrayList<TechnicalStaff8> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.address, p.phone, p.email, ts.major " +
                     "FROM tblPerson8 p JOIN tblTechnicalStaff8 ts ON p.id = ts.personID " +
                     "WHERE p.name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TechnicalStaff8 ts = new TechnicalStaff8(
                    rs.getInt("id"), rs.getString("name"), rs.getString("address"),
                    rs.getString("phone"), rs.getString("email"), rs.getString("major")
                );
                list.add(ts);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}