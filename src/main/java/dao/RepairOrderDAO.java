package dao;

import model.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class RepairOrderDAO extends DAO {
    private UsedSparePartDAO usedSparePartDAO;
    private UsedServiceDAO usedServiceDAO;
    private TechnicalAssignmentDAO technicalAssignmentDAO;

    public RepairOrderDAO() {
        super();
    }

    public boolean saveRepairOrder(RepairOrder8 ro) {
        String sql = "INSERT INTO tblRepairOrder8 (receivedDate, customerID, carID, saleStaffID) VALUES (?, ?, ?, ?)";
        try {
            if (ro == null || ro.getC() == null || ro.getCar() == null || ro.getS() == null) {
                return false;
            }

            con.setAutoCommit(false);

            String carOwnerSql = "SELECT COUNT(*) FROM tblCar8 WHERE id = ? AND customerID = ?";
            try (PreparedStatement ownerStatement = con.prepareStatement(carOwnerSql)) {
                ownerStatement.setInt(1, ro.getCar().getId());
                ownerStatement.setInt(2, ro.getC().getId());
                try (ResultSet ownerResult = ownerStatement.executeQuery()) {
                    if (!ownerResult.next() || ownerResult.getInt(1) != 1) {
                        throw new SQLException("Xe không thuộc khách hàng đã chọn");
                    }
                }
            }

            usedSparePartDAO = new UsedSparePartDAO(con);
            usedServiceDAO = new UsedServiceDAO(con);
            technicalAssignmentDAO = new TechnicalAssignmentDAO(con);

            int repairOrderId;
            try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setDate(1, ro.getReceivedDate());
                ps.setInt(2, ro.getC().getId());
                ps.setInt(3, ro.getCar().getId());
                ps.setInt(4, ro.getS().getId());

                if (ps.executeUpdate() == 0) {
                    throw new SQLException("Không tạo được phiếu sửa chữa");
                }
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (!rs.next()) {
                        throw new SQLException("Không lấy được mã phiếu sửa chữa");
                    }
                    repairOrderId = rs.getInt(1);
                }
            }

            ro.setId(repairOrderId);
            for (UsedSparePart8 usp : ro.getUsp()) {
                if (!usedSparePartDAO.addUsedSparePart(usp, repairOrderId)) {
                    throw new SQLException("Không lưu được phụ tùng sử dụng");
                }
            }
            for (UsedService8 us : ro.getUs()) {
                if (!usedServiceDAO.addUsedService(us, repairOrderId)) {
                    throw new SQLException("Không lưu được dịch vụ sử dụng");
                }
            }
            for (TechnicalAssignment8 ta : ro.getTa()) {
                if (!technicalAssignmentDAO.addTechnicalAssignment(ta, repairOrderId)) {
                    throw new SQLException("Không lưu được phân công kỹ thuật viên");
                }
            }

            con.commit();
            con.setAutoCommit(true);
            return true;
        } catch (Exception e) {
            try {
                con.rollback();
                con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        }
    }
}