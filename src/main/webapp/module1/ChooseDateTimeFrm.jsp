<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    if (request.getMethod().equalsIgnoreCase("POST")) {
        session.removeAttribute("appointment_confirmed");
        session.removeAttribute("appointment_submitting");
        session.setAttribute("booking_date", request.getParameter("date"));
        session.setAttribute("booking_time", request.getParameter("hour") + ":" + request.getParameter("minute") + ":00");
        response.sendRedirect("EnterPersonalInformationFrm.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chọn Ngày và Giờ - Đặt Lịch Hẹn</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-10">
    <div class="max-w-lg mx-auto bg-white p-8 rounded-xl shadow-md">
        <h2 class="text-2xl font-bold text-center text-slate-800 mb-6 border-b pb-3">Chọn Ngày và Giờ</h2>
        <form method="POST" action="ChooseDateTimeFrm.jsp" class="space-y-5">
            <div>
                <label class="block text-sm font-semibold text-slate-700 mb-1">Ngày hẹn:</label>
                <input type="date" id="appointment-date" name="date" required
                       onclick="if (this.showPicker) this.showPicker()"
                       class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-semibold text-slate-700 mb-1">Giờ:</label>
                    <select name="hour" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
                        <option value="" disabled selected>-- Chọn giờ --</option>
                        <option value="08">08 giờ</option>
                        <option value="09">09 giờ</option>
                        <option value="10">10 giờ</option>
                        <option value="11">11 giờ</option>
                        <option value="14">14 giờ</option>
                        <option value="15">15 giờ</option>
                        <option value="16">16 giờ</option>
                        <option value="17">17 giờ</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-slate-700 mb-1">Phút:</label>
                    <select name="minute" required class="w-full border rounded-lg px-3 py-2 text-slate-800 focus:ring-2 focus:ring-blue-500 outline-none">
                        <option value="" disabled selected>-- Chọn phút --</option>
                        <option value="00">00 phút</option>
                        <option value="15">15 phút</option>
                        <option value="30">30 phút</option>
                        <option value="45">45 phút</option>
                    </select>
                </div>
            </div>
            <div class="flex justify-between items-center pt-4 border-t">
                <a href="../MainFrm.jsp" class="px-4 py-2 border rounded-lg text-slate-600 hover:bg-slate-100 font-medium">Quay lại</a>
                <button type="submit" class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-semibold shadow">Tiếp theo</button>
            </div>
        </form>
    </div>
</body>
</html>