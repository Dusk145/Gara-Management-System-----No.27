CREATE DATABASE IF NOT EXISTS gara_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE gara_db;

DROP TABLE IF EXISTS tblTechnicalAssignment8;
DROP TABLE IF EXISTS tblUsedService8;
DROP TABLE IF EXISTS tblUsedSparePart8;
DROP TABLE IF EXISTS tblRepairOrder8;
DROP TABLE IF EXISTS tblAppointment8;
DROP TABLE IF EXISTS tblCar8;
DROP TABLE IF EXISTS tblTechnicalStaff8;
DROP TABLE IF EXISTS tblStaff8;
DROP TABLE IF EXISTS tblCustomer8;
DROP TABLE IF EXISTS tblPerson8;
DROP TABLE IF EXISTS tblSparePart8;
DROP TABLE IF EXISTS tblService8;

CREATE TABLE tblPerson8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(50),
    role VARCHAR(50),
    email VARCHAR(255)
);

CREATE TABLE tblStaff8 (
    personID INT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    FOREIGN KEY (personID) REFERENCES tblPerson8 (id) ON DELETE CASCADE
);

CREATE TABLE tblTechnicalStaff8 (
    personID INT PRIMARY KEY,
    major VARCHAR(255),
    FOREIGN KEY (personID) REFERENCES tblStaff8 (personID) ON DELETE CASCADE
);

CREATE TABLE tblCustomer8 (
    personID INT PRIMARY KEY,
    FOREIGN KEY (personID) REFERENCES tblPerson8 (id) ON DELETE CASCADE
);

CREATE TABLE tblCar8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    licensePlate VARCHAR(50) NOT NULL UNIQUE,
    brand VARCHAR(100),
    model VARCHAR(100),
    color VARCHAR(50),
    customerID INT,
    UNIQUE KEY uq_car_customer (id, customerID),
    FOREIGN KEY (customerID) REFERENCES tblCustomer8 (personID)
);

CREATE TABLE tblAppointment8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    customerID INT,
    FOREIGN KEY (customerID) REFERENCES tblCustomer8 (personID)
);

CREATE TABLE tblService8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    `group` VARCHAR(100),
    price DOUBLE NOT NULL CHECK (price >= 0)
);

CREATE TABLE tblSparePart8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(50),
    stockQuantity INT NOT NULL DEFAULT 0 CHECK (stockQuantity >= 0),
    price DOUBLE NOT NULL CHECK (price >= 0),
    description TEXT
);

CREATE TABLE tblRepairOrder8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    receivedDate DATE NOT NULL,
    customerID INT NOT NULL,
    carID INT NOT NULL,
    saleStaffID INT NOT NULL,
    FOREIGN KEY (customerID) REFERENCES tblCustomer8 (personID),
    FOREIGN KEY (carID, customerID) REFERENCES tblCar8 (id, customerID),
    FOREIGN KEY (saleStaffID) REFERENCES tblStaff8 (personID)
);

CREATE TABLE tblUsedSparePart8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    price DOUBLE NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    repairOrderID INT NOT NULL,
    sparePartID INT NOT NULL,
    FOREIGN KEY (repairOrderID) REFERENCES tblRepairOrder8 (id) ON DELETE CASCADE,
    FOREIGN KEY (sparePartID) REFERENCES tblSparePart8 (id)
);

CREATE TABLE tblUsedService8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    price DOUBLE NOT NULL,
    repairOrderID INT NOT NULL,
    serviceID INT NOT NULL,
    FOREIGN KEY (repairOrderID) REFERENCES tblRepairOrder8 (id) ON DELETE CASCADE,
    FOREIGN KEY (serviceID) REFERENCES tblService8 (id)
);

CREATE TABLE tblTechnicalAssignment8 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    repairOrderID INT NOT NULL,
    technicalStaffID INT NOT NULL,
    FOREIGN KEY (repairOrderID) REFERENCES tblRepairOrder8 (id) ON DELETE CASCADE,
    FOREIGN KEY (technicalStaffID) REFERENCES tblTechnicalStaff8 (personID)
);

-- Dữ liệu khởi tạo
INSERT INTO tblPerson8 (id, name, address, phone, role, email) VALUES 
    (1, 'Đặng Quốc Bảo', 'Hà Nội', '0988776655', 'SaleStaff', 'bao.dq@gara.com'),
    (2, 'Đặng Văn Bảo', 'Hà Nội', '0977665544', 'TechnicalStaff', 'bao.dv@gara.com'),
    (3, 'Đỗ Văn Bảo', 'Hà Nội', '0966554433', 'TechnicalStaff', 'bao.dov@gara.com'),
    (4, 'Nguyễn Văn Bảo', 'Hà Nội', '0955443322', 'TechnicalStaff', 'bao.nv@gara.com'),
    (5, 'Trần Văn Bảo', 'Hà Nội', '0944332211', 'TechnicalStaff', 'bao.tv@gara.com'),
    (6, 'Đặng Thị An', 'Cà Mau', '0912345678', 'Customer', 'dta@gmail.com'),
    (7, 'Đỗ Văn An', 'Hà Nội', '0912345687', 'Customer', 'dva@gmail.com'),
    (8, 'Trần Văn An', 'Lào Cai', '0912345578', 'Customer', 'tva@gmail.com'),
    (9, 'Phạm Minh Châu', 'Hải Phòng', '0912345679', 'Customer', 'pmchau@gmail.com'),
    (10, 'Lê Hoàng Nam', 'Đà Nẵng', '0912345680', 'Customer', 'lhnam@gmail.com'),
    (11, 'Nguyễn Thu Hà', 'Hồ Chí Minh', '0912345681', 'Customer', 'ntha@gmail.com'),
    (12, 'Vũ Đức Long', 'Bắc Ninh', '0912345682', 'Customer', 'vdlong@gmail.com'),
    (13, 'Hoàng Mai Linh', 'Hà Nội', '0912345683', 'Customer', 'hmlinh@gmail.com'),
    (14, 'Bùi Quang Huy', 'Quảng Ninh', '0912345684', 'Customer', 'bqhuy@gmail.com'),
    (15, 'Đỗ Minh Tuấn', 'Hà Nội', '0912345685', 'SaleStaff', 'tuan.dm@gara.com'),
    (16, 'Nguyễn Hải Yến', 'Hà Nội', '0912345686', 'TechnicalStaff', 'yen.nh@gara.com'),
    (17, 'Phan Văn Khánh', 'Hà Nội', '0912345688', 'TechnicalStaff', 'khanh.pv@gara.com'),
    (18, 'Lê Quốc Việt', 'Hà Nội', '0912345689', 'TechnicalStaff', 'viet.lq@gara.com'),
    (19, 'Trần Ngọc Mai', 'Hà Nội', '0912345690', 'TechnicalStaff', 'mai.tn@gara.com'),
    (20, 'Nguyễn Đức Anh', 'Hà Nội', '0912345691', 'TechnicalStaff', 'anh.nd@gara.com');

INSERT INTO tblStaff8 (personID, username, password, position) VALUES 
    (1, 'sale123', '123456', 'Sale Staff'),
    (2, 'tech1', '123456', 'Technical Staff'),
    (3, 'tech2', '123456', 'Technical Staff'),
    (4, 'tech3', '123456', 'Technical Staff'),
    (5, 'tech4', '123456', 'Technical Staff'),
    (15, 'sale456', '123456', 'Sale Staff'),
    (16, 'tech5', '123456', 'Technical Staff'),
    (17, 'tech6', '123456', 'Technical Staff'),
    (18, 'tech7', '123456', 'Technical Staff'),
    (19, 'tech8', '123456', 'Technical Staff'),
    (20, 'tech9', '123456', 'Technical Staff');

INSERT INTO tblTechnicalStaff8 (personID, major) VALUES 
    (2, 'Sửa chữa máy'),
    (3, 'Sửa chữa điện'),
    (4, 'Sửa chữa gầm'),
    (5, 'Bảo dưỡng định kỳ'),
    (16, 'Điều hòa ô tô'),
    (17, 'Sửa chữa thân vỏ'),
    (18, 'Chẩn đoán điện tử'),
    (19, 'Động cơ và hộp số'),
    (20, 'Lốp và cân bằng động');

INSERT INTO tblCustomer8 (personID) VALUES 
    (6), (7), (8), (9), (10), (11), (12), (13), (14);

INSERT INTO tblCar8 (id, licensePlate, brand, model, color, customerID) VALUES 
    (1, '123-45AQ', 'Toyota', 'Vios', 'Trắng', 6),
    (2, '234-56AZ', 'Honda', 'Civic', 'Đen', 6),
    (3, '234-57AZ', 'Hyundai', 'Accent', 'Đỏ', 7),
    (4, '345-34DC', 'Ford', 'Ranger', 'Xám', 8),
    (5, '30A-67890', 'Mazda', 'CX-5', 'Trắng', 9),
    (6, '43A-11223', 'Kia', 'Seltos', 'Xanh', 10),
    (7, '51K-44556', 'VinFast', 'Lux A2.0', 'Đen', 11),
    (8, '99A-77889', 'Mercedes-Benz', 'C200', 'Bạc', 12),
    (9, '29B-13579', 'Mitsubishi', 'Xpander', 'Đỏ', 13),
    (10, '14A-24680', 'Ford', 'Everest', 'Nâu', 14);

INSERT INTO tblSparePart8 (id, name, unit, stockQuantity, price, description) VALUES 
    (1, 'Vít lục giác 5mm', 'Cái', 100, 1000, 'Vít thép mạ'),
    (2, 'Vít vòng 3mm', 'Cái', 123, 1300, 'Vít inox 304'),
    (3, 'Vít khoan inox', 'Cái', 4, 1200, 'Vít khoan'),
    (4, 'Vít 4cm', 'Cái', 5, 1100, 'Vít chuyên dụng'),
    (5, 'Dầu động cơ 5W-30', 'Chai', 34, 185000, 'Dầu tổng hợp cho động cơ xăng'),
    (6, 'Lọc dầu động cơ', 'Cái', 24, 95000, 'Lọc dầu thay định kỳ'),
    (7, 'Lọc gió động cơ', 'Cái', 19, 120000, 'Lọc gió tiêu chuẩn'),
    (8, 'Má phanh trước', 'Bộ', 11, 680000, 'Má phanh trước cho xe phổ thông'),
    (9, 'Bugi đánh lửa', 'Cái', 36, 75000, 'Bugi iridium'),
    (10, 'Nước làm mát', 'Chai', 29, 95000, 'Dung dịch làm mát động cơ');

INSERT INTO tblService8 (id, name, description, `group`, price) VALUES 
    (1, 'Kiểm tra ắc quy', 'Kiểm tra tình trạng, điện áp và dòng nạp ắc quy', 'Kiểm tra', 15000),
    (2, 'Kiểm tra phanh', 'Kiểm tra má phanh, đĩa phanh và đường ống phanh', 'Bảo dưỡng', 20000),
    (3, 'Kiểm tra và thay lốp', 'Kiểm tra áp suất và thay mới khi cần thiết', 'Bảo dưỡng', 24000),
    (4, 'Thay dầu động cơ', 'Xả dầu cũ và thay dầu động cơ mới', 'Bảo dưỡng', 35000),
    (5, 'Thay lọc gió', 'Tháo và thay lọc gió động cơ', 'Bảo dưỡng', 25000),
    (6, 'Vệ sinh kim phun', 'Vệ sinh kim phun và kiểm tra lưu lượng nhiên liệu', 'Động cơ', 180000),
    (7, 'Bảo dưỡng điều hòa', 'Kiểm tra gas, lọc gió và khả năng làm lạnh', 'Điều hòa', 220000),
    (8, 'Chẩn đoán lỗi điện tử', 'Đọc mã lỗi bằng thiết bị chẩn đoán chuyên dụng', 'Điện tử', 150000),
    (9, 'Cân bằng động bánh xe', 'Cân bằng và kiểm tra độ rung bánh xe', 'Lốp xe', 120000),
    (10, 'Đánh bóng thân xe', 'Xử lý xước nhẹ và đánh bóng bề mặt sơn', 'Thân vỏ', 450000);

INSERT INTO tblAppointment8 (id, date, time, customerID) VALUES 
    (1, '2026-11-15', '08:00:00', 6),
    (2, '2026-11-15', '09:30:00', 7),
    (3, '2026-11-16', '14:00:00', 9),
    (4, '2026-11-17', '15:30:00', 10),
    (5, '2026-11-18', '10:00:00', 12),
    (6, '2026-11-20', '16:00:00', 14);

INSERT INTO tblRepairOrder8 (id, receivedDate, customerID, carID, saleStaffID) VALUES 
    (1, '2026-11-10', 6, 1, 1),
    (2, '2026-11-11', 9, 5, 15),
    (3, '2026-11-12', 10, 6, 1),
    (4, '2026-11-13', 12, 8, 15);

INSERT INTO tblUsedSparePart8 (id, price, quantity, repairOrderID, sparePartID) VALUES 
    (1, 185000, 1, 1, 5),
    (2, 95000, 1, 1, 6),
    (3, 680000, 1, 2, 8),
    (4, 75000, 4, 3, 9),
    (5, 120000, 1, 4, 7),
    (6, 95000, 1, 4, 10);

INSERT INTO tblUsedService8 (id, price, repairOrderID, serviceID) VALUES 
    (1, 35000, 1, 4),
    (2, 20000, 1, 2),
    (3, 180000, 2, 6),
    (4, 220000, 3, 7),
    (5, 150000, 4, 8);

INSERT INTO tblTechnicalAssignment8 (id, repairOrderID, technicalStaffID) VALUES 
    (1, 1, 5),
    (2, 2, 19),
    (3, 3, 16),
    (4, 4, 18),
    (5, 4, 20); 