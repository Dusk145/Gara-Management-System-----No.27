package dao;

import model.Car8;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class CarDAO extends DAO {
    public CarDAO() { super(); }

    public boolean addCar(Car8 car) {
        String sql = "INSERT INTO tblCar8 (licensePlate, brand, model, color, customerID) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, car.getLicensePlate());
            ps.setString(2, car.getBrand());
            ps.setString(3, car.getModel());
            ps.setString(4, car.getColor());
            ps.setInt(5, car.getCustomerID());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) { car.setId(rs.getInt(1)); }
                return true;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}