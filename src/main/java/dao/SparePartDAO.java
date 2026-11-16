package dao;

import model.SparePart8;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SparePartDAO extends DAO {
    public SparePartDAO() { super(); }
    public SparePartDAO(Connection con) { super(con); }

    public boolean updateStockQuantity(int sparePartId, int quantity) {
        if (sparePartId <= 0 || quantity <= 0) {
            return false;
        }

        String sql = "UPDATE tblSparePart8 SET stockQuantity = stockQuantity - ? " +
                     "WHERE id = ? AND stockQuantity >= ?";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, quantity);
            statement.setInt(2, sparePartId);
            statement.setInt(3, quantity);
            return statement.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

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
