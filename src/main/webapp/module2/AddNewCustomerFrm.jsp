<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDAO, dao.CarDAO, model.Customer8, model.Car8" %>
<%
    request.setCharacterEncoding("UTF-8");
    if (request.getMethod().equalsIgnoreCase("POST")) {
        Customer8 cus = new Customer8(0, request.getParameter("name"), request.getParameter("address"), request.getParameter("phone"), request.getParameter("email"));
        CustomerDAO custDAO = new CustomerDAO();
        if (custDAO.addCustomer(cus)) {
            Car8 car = new Car8(0, request.getParameter("licensePlate"), request.getParameter("brand"), request.getParameter("model"), request.getParameter("color"));
            car.setCustomerID(cus.getId());
            CarDAO carDAO = new CarDAO();
            carDAO.addCar(car);
            response.sendRedirect("SearchSparePartFrm.jsp?custId=" + cus.getId() + "&carId=" + car.getId());
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Khách Hàng Mới</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-8">
    <div class="max-w-2xl mx-auto bg-white p-8 rounded-xl shadow">
        <h2 class="text-xl font-bold text-slate-800 mb-6 border-b pb-3 text-center">THÊM KHÁCH HÀNG & XE MỚI</h2>
        <form method="POST" action="AddNewCustomerFrm.jsp" class="space-y-4">
            <h3 class="font-bold text-blue-700">Thông tin cá nhân</h3>
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Họ tên:</label><input type="text" name="name" placeholder="Nhập họ và tên" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Địa chỉ:</label><input type="text" name="address" placeholder="Nhập địa chỉ" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Email:</label><input type="email" name="email" placeholder="Nhập email" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Số điện thoại:</label><input type="text" name="phone" placeholder="Nhập số điện thoại" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
            </div>
            <h3 class="font-bold text-blue-700 pt-2">Thông tin xe</h3>
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Biển số xe:</label><input type="text" name="licensePlate" placeholder="Vd: 30A-12345" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Hãng xe:</label><input type="text" name="brand" placeholder="Vd: Toyota" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Loại/Dòng xe:</label><input type="text" name="model" placeholder="Vd: Vios" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
                <div><label class="block text-xs font-semibold text-slate-600 mb-1">Màu xe:</label><input type="text" name="color" placeholder="Vd: Trắng" required class="w-full border rounded px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-blue-500"></div>
            </div>
            <div class="flex justify-between items-center pt-6 border-t">
                <a href="SearchCustomerFrm.jsp" class="px-4 py-2 border rounded text-slate-600 hover:bg-slate-100">Quay lại</a>
                <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow">Tiếp theo</button>
            </div>
        </form>
    </div>
</body>
</html>