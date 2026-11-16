<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Staff8" %>
<% Staff8 staff = (Staff8) session.getAttribute("saleStaff"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Hệ Thống Quản Lý Gara</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen">
    <header class="bg-blue-700 text-white shadow-md">
        <div class="max-w-6xl mx-auto px-4 py-4 flex justify-between items-center">
            <h1 class="text-xl font-bold tracking-wide">GARA MANAGEMENT SYSTEM</h1>
            <div>
                <% if (staff != null) { %>
                    <span class="mr-4 text-sm bg-blue-800 px-3 py-1 rounded-full">Xin chào, <%= staff.getName() %> (<%= staff.getUsername() %>)</span>
                    <a href="module2/LoginFrm.jsp?action=logout" class="bg-red-500 hover:bg-red-600 px-3 py-1 text-sm rounded font-medium transition">Đăng xuất</a>
                <% } else { %>
                    <a href="module2/LoginFrm.jsp" class="bg-blue-600 hover:bg-blue-800 px-4 py-1.5 text-sm rounded font-medium transition">Đăng nhập nhân viên</a>
                <% } %>
            </div>
        </div>
    </header>
    <main class="max-w-4xl mx-auto mt-12 p-6 bg-white rounded-xl shadow-md text-center">
        <h2 class="text-3xl font-extrabold text-slate-800 mb-8">HỆ THỐNG QUẢN LÝ GARA</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
            <div class="p-6 border-2 border-blue-100 bg-blue-50/50 rounded-xl hover:border-blue-500 transition shadow-sm">
                <h3 class="text-xl font-bold text-blue-700 mb-2">Dành Cho Khách Hàng</h3>
                <p class="text-slate-600 mb-6 text-sm">Đặt lịch hẹn trực tuyến nhanh chóng, chọn ngày giờ phù hợp.</p>
                <a href="module1/ChooseDateTimeFrm.jsp" class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2.5 rounded-lg transition shadow">Đặt lịch hẹn trực tuyến</a>
            </div>
            <div class="p-6 border-2 border-slate-100 bg-slate-50/50 rounded-xl hover:border-slate-500 transition shadow-sm">
                <h3 class="text-xl font-bold text-slate-700 mb-2">Dành Cho Nhân Viên</h3>
                <p class="text-slate-600 mb-6 text-sm">Tiếp nhận xe sửa chữa, chọn dịch vụ, phụ tùng và phân công thợ.</p>
                <a href="module2/SearchCustomerFrm.jsp" class="inline-block bg-emerald-600 hover:bg-emerald-700 text-white font-semibold px-6 py-2.5 rounded-lg transition shadow">Tiếp nhận xe sửa chữa</a>
            </div>
        </div>
    </main>
</body>
</html>