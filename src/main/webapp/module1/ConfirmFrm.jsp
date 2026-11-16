<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDAO, model.Customer8, model.Appointment8, java.sql.Date, java.sql.Time" %>
<%
    request.setCharacterEncoding("UTF-8");
    String message = null;
    boolean isSuccess = false;
    if ("confirm".equals(request.getParameter("action")) &&
            (Boolean.TRUE.equals(session.getAttribute("appointment_confirmed")) ||
             Boolean.TRUE.equals(session.getAttribute("appointment_submitting")))) {
        isSuccess = true;
        message = "Lịch hẹn này đã được lưu trước đó.";
    } else if ("confirm".equals(request.getParameter("action"))) {
        session.setAttribute("appointment_submitting", true);
        String name = (String) session.getAttribute("cust_name");
        String address = (String) session.getAttribute("cust_address");
        String email = (String) session.getAttribute("cust_email");
        String phone = (String) session.getAttribute("cust_phone");
        String dateStr = (String) session.getAttribute("booking_date");
        String timeStr = (String) session.getAttribute("booking_time");

        try {
            if (name == null || address == null || email == null || phone == null ||
                    dateStr == null || timeStr == null) {
                throw new IllegalArgumentException("Thiếu thông tin đặt lịch");
            }
            Customer8 cus = new Customer8(0, name, address, phone, email);
            Appointment8 ap = new Appointment8(0, Date.valueOf(dateStr), Time.valueOf(timeStr), cus);
            if (new CustomerDAO().addCustomerAndAppointment(cus, ap)) {
                isSuccess = true;
                message = "Đặt lịch hẹn thành công!";
                session.setAttribute("appointment_confirmed", true);
                session.removeAttribute("appointment_submitting");
                session.removeAttribute("booking_date");
                session.removeAttribute("booking_time");
                session.removeAttribute("cust_name");
                session.removeAttribute("cust_address");
                session.removeAttribute("cust_email");
                session.removeAttribute("cust_phone");
            } else {
                session.removeAttribute("appointment_submitting");
                message = "Lỗi khi lưu thông tin đặt lịch vào CSDL!";
            }
        } catch (Exception e) {
            session.removeAttribute("appointment_submitting");
            message = "Thông tin đặt lịch không hợp lệ!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Nhận Thông Tin Lịch Hẹn</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-10">
    <div class="max-w-xl mx-auto bg-white p-8 rounded-xl shadow-md">
        <h2 class="text-2xl font-bold text-center text-slate-800 mb-6 border-b pb-3">THÔNG TIN LỊCH HẸN</h2>
        <% if (message != null) { %>
            <div class="mb-6 p-4 rounded-lg text-center font-bold <%= isSuccess ? "bg-green-100 text-green-800 border border-green-300" : "bg-red-100 text-red-800 border border-red-300" %>">
                <%= message %>
                <% if (isSuccess) { %>
                    <div class="mt-4"><a href="../MainFrm.jsp" class="inline-block bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-lg font-semibold shadow">OK / Về trang chủ</a></div>
                <% } %>
            </div>
        <% } %>
        <% if (!isSuccess) { %>
            <div class="space-y-4 text-slate-700 bg-slate-50 p-6 rounded-lg border">
                <div class="flex justify-between border-b pb-2"><span class="font-semibold text-slate-600">Ngày:</span><span class="font-bold text-slate-800"><%= session.getAttribute("booking_date") %></span></div>
                <div class="flex justify-between border-b pb-2"><span class="font-semibold text-slate-600">Giờ:</span><span class="font-bold text-slate-800"><%= session.getAttribute("booking_time") %></span></div>
                <div class="flex justify-between border-b pb-2"><span class="font-semibold text-slate-600">Họ tên:</span><span class="font-bold text-slate-800"><%= session.getAttribute("cust_name") %></span></div>
                <div class="flex justify-between border-b pb-2"><span class="font-semibold text-slate-600">Địa chỉ:</span><span class="font-bold text-slate-800"><%= session.getAttribute("cust_address") %></span></div>
                <div class="flex justify-between border-b pb-2"><span class="font-semibold text-slate-600">Email:</span><span class="font-bold text-slate-800"><%= session.getAttribute("cust_email") %></span></div>
                <div class="flex justify-between pb-2"><span class="font-semibold text-slate-600">Số điện thoại:</span><span class="font-bold text-slate-800"><%= session.getAttribute("cust_phone") %></span></div>
            </div>
            <form method="POST" action="ConfirmFrm.jsp?action=confirm" class="flex justify-between items-center pt-6">
                <a href="EnterPersonalInformationFrm.jsp" class="px-5 py-2 border rounded-lg text-slate-600 hover:bg-slate-100 font-medium">Quay lại</a>
                <button type="submit" class="px-8 py-2.5 bg-emerald-600 hover:bg-emerald-700 text-white rounded-lg font-bold shadow">Xác nhận</button>
            </form>
        <% } %>
    </div>
</body>
</html>