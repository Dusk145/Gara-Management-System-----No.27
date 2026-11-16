<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    if (request.getMethod().equalsIgnoreCase("POST")) {
        session.setAttribute("cust_name", request.getParameter("name"));
        session.setAttribute("cust_address", request.getParameter("address"));
        session.setAttribute("cust_email", request.getParameter("email"));
        session.setAttribute("cust_phone", request.getParameter("phone"));
        response.sendRedirect("ConfirmFrm.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Điền Thông Tin Cá Nhân</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-10">
    <div class="max-w-lg mx-auto bg-white p-8 rounded-xl shadow-md">
        <h2 class="text-2xl font-bold text-center text-slate-800 mb-6 border-b pb-3">Điền Thông Tin Cá Nhân</h2>
        <form method="POST" action="EnterPersonalInformationFrm.jsp" class="space-y-4">
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Họ tên:</label>
                <input type="text" name="name" placeholder="Nhập họ và tên" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Địa chỉ:</label>
                <input type="text" name="address" placeholder="Nhập địa chỉ" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Email:</label>
                <input type="email" name="email" placeholder="Nhập địa chỉ email" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Số điện thoại:</label>
                <input type="text" name="phone" placeholder="Nhập số điện thoại" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="flex justify-between items-center pt-4 border-t">
                <a href="ChooseDateTimeFrm.jsp" class="px-4 py-2 border rounded-lg text-slate-600 hover:bg-slate-100 font-medium">Quay lại</a>
                <button type="submit" class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-semibold shadow">Tiếp theo</button>
            </div>
        </form>
    </div>
</body>
</html>