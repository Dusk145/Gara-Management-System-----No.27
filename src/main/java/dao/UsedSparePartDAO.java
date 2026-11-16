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
            String stockSql = "UPDATE tblSparePart8 SET stockQuantity = stockQuantity - ? " +
                              "WHERE id = ? AND stockQuantity >= ?";
            try (PreparedStatement stockStatement = con.prepareStatement(stockSql)) {
                stockStatement.setInt(1, usp.getQuantity());
                stockStatement.setInt(2, usp.getSp().getId());
                stockStatement.setInt(3, usp.getQuantity());
                if (stockStatement.executeUpdate() != 1) {
                    return false;
                }
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