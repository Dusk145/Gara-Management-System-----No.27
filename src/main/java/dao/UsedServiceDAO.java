package dao;

import model.UsedService8;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UsedServiceDAO extends DAO {
    public UsedServiceDAO() { super(); }
    public UsedServiceDAO(Connection con) { super(con); }

    public boolean addUsedService(UsedService8 us, int repairOrderID) {
        String sql = "INSERT INTO tblUsedService8 (price, repairOrderID, serviceID) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, us.getPrice());
            ps.setInt(2, repairOrderID);
            ps.setInt(3, us.getSer().getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}