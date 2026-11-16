package dao;

import model.TechnicalAssignment8;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class TechnicalAssignmentDAO extends DAO {
    public TechnicalAssignmentDAO() { super(); }
    public TechnicalAssignmentDAO(Connection con) { super(con); }

    public boolean addTechnicalAssignment(TechnicalAssignment8 ta, int repairOrderID) {
        String sql = "INSERT INTO tblTechnicalAssignment8 (repairOrderID, technicalStaffID) VALUES (?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, repairOrderID);
            ps.setInt(2, ta.getTs().getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}