package dao;

import model.Appointment8;
import java.sql.PreparedStatement;

public class AppointmentDAO extends DAO {
    public AppointmentDAO() { super(); }

    public boolean saveAppointment(Appointment8 ap) {
        String sql = "INSERT INTO tblAppointment8 (date, time, customerID) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, ap.getDate());
            ps.setTime(2, ap.getTime());
            ps.setInt(3, ap.getC().getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}