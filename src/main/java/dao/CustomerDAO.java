package dao;

import model.Customer8;
import model.Car8;
import model.Appointment8;
import java.sql.*;
import java.util.ArrayList;

public class CustomerDAO extends DAO {
    public CustomerDAO() { super(); }

    public boolean addCustomer(Customer8 cus) {
        String sqlPerson = "INSERT INTO tblPerson8 (name, address, phone, role, email) VALUES (?, ?, ?, 'Customer', ?)";
        String sqlCustomer = "INSERT INTO tblCustomer8 (personID) VALUES (?)";
        try {
            con.setAutoCommit(false);
            try (PreparedStatement ps1 = con.prepareStatement(sqlPerson, Statement.RETURN_GENERATED_KEYS)) {
                ps1.setString(1, cus.getName());
                ps1.setString(2, cus.getAddress());
                ps1.setString(3, cus.getPhone());
                ps1.setString(4, cus.getEmail());
                if (ps1.executeUpdate() != 1) {
                    throw new SQLException("Không tạo được khách hàng");
                }

                try (ResultSet rs = ps1.getGeneratedKeys()) {
                    if (!rs.next()) {
                        throw new SQLException("Không lấy được mã khách hàng");
                    }
                    cus.setId(rs.getInt(1));
                }
            }
            try (PreparedStatement ps2 = con.prepareStatement(sqlCustomer)) {
                ps2.setInt(1, cus.getId());
                if (ps2.executeUpdate() != 1) {
                    throw new SQLException("Không tạo được hồ sơ khách hàng");
                }
            }
            con.commit();
            con.setAutoCommit(true);
            return true;
        } catch (Exception e) {
            try {
                con.rollback();
                con.setAutoCommit(true);
            } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        }
    }

    public boolean addCustomerAndAppointment(Customer8 cus, Appointment8 appointment) {
        String sqlPerson = "INSERT INTO tblPerson8 (name, address, phone, role, email) VALUES (?, ?, ?, 'Customer', ?)";
        String sqlCustomer = "INSERT INTO tblCustomer8 (personID) VALUES (?)";
        String sqlAppointment = "INSERT INTO tblAppointment8 (date, time, customerID) VALUES (?, ?, ?)";
        try {
            if (cus == null || appointment == null || appointment.getDate() == null || appointment.getTime() == null) {
                return false;
            }
            con.setAutoCommit(false);
            try (PreparedStatement personStatement = con.prepareStatement(sqlPerson, Statement.RETURN_GENERATED_KEYS)) {
                personStatement.setString(1, cus.getName());
                personStatement.setString(2, cus.getAddress());
                personStatement.setString(3, cus.getPhone());
                personStatement.setString(4, cus.getEmail());
                if (personStatement.executeUpdate() != 1) {
                    throw new SQLException("Không tạo được khách hàng");
                }
                try (ResultSet keys = personStatement.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new SQLException("Không lấy được mã khách hàng");
                    }
                    cus.setId(keys.getInt(1));
                }
            }
            try (PreparedStatement customerStatement = con.prepareStatement(sqlCustomer);
                 PreparedStatement appointmentStatement = con.prepareStatement(sqlAppointment)) {
                customerStatement.setInt(1, cus.getId());
                if (customerStatement.executeUpdate() != 1) {
                    throw new SQLException("Không tạo được hồ sơ khách hàng");
                }
                appointmentStatement.setDate(1, appointment.getDate());
                appointmentStatement.setTime(2, appointment.getTime());
                appointmentStatement.setInt(3, cus.getId());
                if (appointmentStatement.executeUpdate() != 1) {
                    throw new SQLException("Không tạo được lịch hẹn");
                }
            }
            con.commit();
            con.setAutoCommit(true);
            return true;
        } catch (Exception e) {
            try {
                con.rollback();
                con.setAutoCommit(true);
            } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<Customer8> findCustomer(String name) {
        ArrayList<Customer8> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.address, p.phone, p.email, c.id AS carId, c.licensePlate, c.brand, c.model, c.color " +
                     "FROM tblPerson8 p " +
                     "JOIN tblCustomer8 cust ON p.id = cust.personID " +
                     "LEFT JOIN tblCar8 c ON cust.personID = c.customerID " +
                     "WHERE p.name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int custId = rs.getInt("id");
                Customer8 cust = null;
                for (Customer8 existing : list) {
                    if (existing.getId() == custId) { cust = existing; break; }
                }
                if (cust == null) {
                    cust = new Customer8(custId, rs.getString("name"), rs.getString("address"), rs.getString("phone"), rs.getString("email"));
                    list.add(cust);
                }
                int carId = rs.getInt("carId");
                if (carId > 0) {
                    Car8 car = new Car8(carId, rs.getString("licensePlate"), rs.getString("brand"), rs.getString("model"), rs.getString("color"));
                    cust.getCars().add(car);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}