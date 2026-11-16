Gara Management System - Hệ Thống Quản Lý Gara - Subject No. 27  

A garage management system enables management staff, sales staff, warehouse staff, and customers to use:  
  •	Management staff: view the statistics categories: services, parts, customers and suppliers. Service information management, spare parts  
  •	Warehouse staff: import spare parts from suppliers, manage supplier information  
  •	Sale staff: receive customers, receive service and spare parts requests from customers, assign technical staff according to customer service requirements, receive payment from customers.  
  •	Customer: Search service information, book an appointment online  

Considering two  modules and answering questions  
  •	Customer books an appointment online: selects the appointment booking menu → chooses a date and time → enters the customer's personal information and confirms → the system saves to the database.  
  •	Sale staff receives the car in for repair: selects the menu to receive the car → finds and selects the customer by name (add a new one if not exist) → Repeats until the end of service and spare parts list to use: finds and selects the spare part/service by name → at the end of the list to use, selects service technician → confirms → saves to the database  

🛠 Công Nghệ Sử Dụng

Ngôn ngữ lập trình: Java 21

Kiến trúc ứng dụng: Servlet / JSP (Java Web Application)

Công cụ quản lý Dependency: Apache Maven

Cơ sở dữ liệu: MySQL Server (Database: gara_db)

Web Server: Apache Tomcat 10+ (hỗ trợ Jakarta EE)

Giao diện: HTML5, CSS3, JavaScript, Bootstrap

📁 Cấu Trúc Dự Án

GaraManagementSystem/  
├── src/  
│   ├── main/  
│   │   ├── java/            # Mã nguồn Java (DAO, Model, Controller/Servlet)  
│   │   ├── resources/       # File cấu hình ứng dụng  
│   │   └── webapp/          # Trang giao diện JSP, HTML, CSS, JS, hình ảnh  
│   └── test/                # Unit Tests (nếu có)  
├── schema.sql              # Kịch bản khởi tạo CSDL MySQL & dữ liệu mẫu  
├── pom.xml                  # File cấu hình Maven Dependency  
├── .gitignore               # Khai báo file/thư mục không đẩy lên Git  
└── README.md                # Tài liệu hướng dẫn dự án  


🚀 Hướng Dẫn Cài Đặt & Chạy Dự Án

1. Yêu cầu tiền đề (Prerequisites)

Java Development Kit (JDK): Phiên bản 21 trở lên.

Database Manager: MySQL Server 8.0+ hoặc XAMPP / WAMP.

IDE Khuyến nghị: IntelliJ IDEA (với plugin Smart Tomcat) hoặc Eclipse IDE for Enterprise Java.

Build Tool: Apache Maven 3.8+.

2. Thiết lập Cơ sở dữ liệu

Mở phần mềm quản lý MySQL (MySQL Workbench, phpMyAdmin, DBeaver,...).

Tạo mới cơ sở dữ liệu hoặc nạp trực tiếp file gara_db.sql đi kèm trong thư mục gốc dự án:

CREATE DATABASE gara_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gara_db;


Chạy file gara_db.sql để tạo các bảng dữ liệu (tblPerson8, tblCar8, tblRepairOrder8, tblUsedSparePart8,...) và chèn dữ liệu thử nghiệm.

3. Cấu hình Kết nối CSDL trong Dự án

Mở file cấu hình kết nối CSDL trong mã nguồn Java (thường tại src/main/java/.../DAO.java hoặc file cấu hình database) và cập nhật lại thông tin tài khoản MySQL của bạn:

String url = "jdbc:mysql://localhost:3306/gara_db?useSSL=false&serverTimezone=UTC";
String username = "root";     // Đổi thành username MySQL của bạn
String password = "your_password"; // Đổi thành password MySQL của bạn


4. Biên dịch & Khởi chạy

Sử dụng IntelliJ IDEA + Smart Tomcat:

Mở dự án bằng IntelliJ IDEA: File -> Open -> Chọn thư mục dự án.

Đợi Maven tự động tải toàn bộ dependency trong file pom.xml.

Vào cấu hình Run/Debug -> Thêm mới Smart Tomcat.

Thiết lập Tomcat Server, Deployment Directory là src/main/webapp, Context Path là / hoặc /GaraManagementSystem.

Nhấn Run để khởi chạy ứng dụng.

Sử dụng Maven Lệnh:

# Biên dịch dự án và đóng gói file WAR
mvn clean package

# File WAR sẽ được tạo ra tại thư mục target/GaraManagementSystem.war


Sau đó copy file WAR vào thư mục webapps/ của Apache Tomcat độc lập để chạy.

🔑 Tài Khoản Thử Nghiệm

Quản trị viên (Admin) / Nhân viên:

Tên đăng nhập: sale123 (hoặc thông tin trong bảng tblPerson8)

Mật khẩu: 123456
