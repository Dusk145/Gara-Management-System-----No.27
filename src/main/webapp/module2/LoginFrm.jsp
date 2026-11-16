<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.StaffDAO, model.Staff8" %>
<%
    request.setCharacterEncoding("UTF-8");
    if ("logout".equals(request.getParameter("action"))) {
        session.removeAttribute("saleStaff");
    }
    String errorMsg = null;
    if (request.getMethod().equalsIgnoreCase("POST")) {
        StaffDAO staffDAO = new StaffDAO();
        Staff8 staff = staffDAO.checkLogin(request.getParameter("username"), request.getParameter("password"));
        if (staff != null) {
            session.setAttribute("saleStaff", staff);
            response.sendRedirect("../MainFrm.jsp");
            return;
        } else {
            errorMsg = "Tài khoản hoặc mật khẩu không chính xác!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - Nhân Viên</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen flex items-center justify-center">
    <div class="max-w-md w-full bg-white p-8 rounded-xl shadow-md">
        <h2 class="text-2xl font-bold text-center text-slate-800 mb-6">ĐĂNG NHẬP HỆ THỐNG</h2>
        <% if (errorMsg != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4 text-sm"><%= errorMsg %></div>
        <% } %>
        <form method="POST" action="LoginFrm.jsp" class="space-y-4">
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Tài khoản:</label>
                <input type="text" name="username" placeholder="Nhập tên tài khoản" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Mật khẩu:</label>
                <input type="password" name="password" placeholder="Nhập mật khẩu" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <button type="submit" class="w-full py-2.5 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-bold shadow transition">Đăng nhập</button>
        </form>
    </div>
</body>
</html>