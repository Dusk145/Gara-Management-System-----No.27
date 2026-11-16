package dao;

import model.UsedSparePart8;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UsedSparePartDAO extends DAO {
    public UsedSparePartDAO() { super(); }
    public UsedSparePartDAO(Connection con) { super(con); }

    public boolean addUsedSparePart(UsedSparePart8 usp, int repairOrderID) {
        if (usp == null || usp.getSp() == null || usp.getQuantity() <= 0 || usp.getPrice() < 0) {
            return false;
        }
        try {
            if (!new SparePartDAO(con).updateStockQuantity(
                    usp.getSp().getId(), usp.getQuantity())) {
                return false;
            }

            String insertSql = "INSERT INTO tblUsedSparePart8 (price, quantity, repairOrderID, sparePartID) VALUES (?, ?, ?, ?)";
            try (PreparedStatement insertStatement = con.prepareStatement(insertSql)) {
                insertStatement.setDouble(1, usp.getPrice());
                insertStatement.setInt(2, usp.getQuantity());
                insertStatement.setInt(3, repairOrderID);
                insertStatement.setInt(4, usp.getSp().getId());
                return insertStatement.executeUpdate() == 1;
            }
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
