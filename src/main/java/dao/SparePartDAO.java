package dao;

import model.SparePart8;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SparePartDAO extends DAO {
    public SparePartDAO() { super(); }

    public ArrayList<SparePart8> findSparePart(String name) {
        ArrayList<SparePart8> list = new ArrayList<>();
        String sql = "SELECT * FROM tblSparePart8 WHERE name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SparePart8 sp = new SparePart8(
                    rs.getInt("id"), rs.getString("name"), rs.getString("unit"),
                    rs.getInt("stockQuantity"), rs.getDouble("price"), rs.getString("description")
                );
                list.add(sp);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}