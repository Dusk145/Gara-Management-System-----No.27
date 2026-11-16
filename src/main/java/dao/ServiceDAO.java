package dao;

import model.Service8;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ServiceDAO extends DAO {
    public ServiceDAO() { super(); }

    public ArrayList<Service8> findService(String name) {
        ArrayList<Service8> list = new ArrayList<>();
        String sql = "SELECT * FROM tblService8 WHERE name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service8 s = new Service8(
                    rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                    rs.getString("group"), rs.getDouble("price")
                );
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}