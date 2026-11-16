<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDAO, model.Customer8, model.Car8, model.Staff8, java.util.ArrayList" %>
<%
    request.setCharacterEncoding("UTF-8");
    Staff8 staff = (Staff8) session.getAttribute("saleStaff");
    if (staff == null) { response.sendRedirect("LoginFrm.jsp"); return; }
    session.removeAttribute("repair_order_confirmed");
    session.removeAttribute("repair_order_submitting");

    String searchKeyword = request.getParameter("name");
    ArrayList<Customer8> customerList = new ArrayList<Customer8>();
    if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        CustomerDAO dao = new CustomerDAO();
        customerList = dao.findCustomer(searchKeyword);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Khách Hàng - Tiếp Nhận Xe</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen">
    <header class="bg-slate-800 text-white px-6 py-3 flex justify-between items-center">
        <h1 class="font-bold">TIẾP NHẬN XE SỬA CHỮA</h1>
        <span class="text-sm bg-slate-700 px-3 py-1 rounded">NVBH: <%= staff.getUsername() %></span>
    </header>
    <main class="max-w-5xl mx-auto mt-8 p-6 bg-white rounded-xl shadow">
        <h2 class="text-xl font-bold text-slate-800 mb-6 text-center">TÌM KIẾM KHÁCH HÀNG</h2>
        <form method="GET" action="SearchCustomerFrm.jsp" class="flex gap-4 mb-6 max-w-xl mx-auto">
            <input type="text" name="name" value="<%= searchKeyword != null ? searchKeyword : "" %>" placeholder="Nhập tên khách hàng" class="flex-1 border rounded-lg px-4 py-2 outline-none focus:ring-2 focus:ring-blue-500">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded-lg shadow">Tìm kiếm</button>
        </form>
        <% if (searchKeyword != null) { %>
            <div class="overflow-x-auto mb-6">
                <table class="w-full border-collapse border border-slate-200 text-sm">
                    <thead>
                        <tr class="bg-slate-100 text-slate-700">
                            <th class="border p-2">Họ tên</th><th class="border p-2">Địa chỉ</th><th class="border p-2">Email</th>
                            <th class="border p-2">Số điện thoại</th><th class="border p-2">Biển số xe</th><th class="border p-2">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (customerList.isEmpty()) { %>
                            <tr><td colspan="6" class="text-center p-4 text-slate-500">Không tìm thấy khách hàng.</td></tr>
                        <% } else {
                            for (Customer8 c : customerList) {
                                if (c.getCars().isEmpty()) { %>
                                    <tr class="hover:bg-slate-50">
                                        <td class="border p-2 font-medium"><%= c.getName() %></td><td class="border p-2"><%= c.getAddress() %></td>
                                        <td class="border p-2"><%= c.getEmail() %></td><td class="border p-2"><%= c.getPhone() %></td>
                                        <td class="border p-2 text-slate-400">Chưa có xe</td>
                                        <td class="border p-2 text-center"><a href="SearchSparePartFrm.jsp?custId=<%= c.getId() %>" class="bg-blue-600 text-white px-3 py-1 rounded text-xs font-semibold hover:bg-blue-700">Chọn</a></td>
                                    </tr>
                                <% } else {
                                    for (Car8 car : c.getCars()) { %>
                                        <tr class="hover:bg-slate-50">
                                            <td class="border p-2 font-medium"><%= c.getName() %></td><td class="border p-2"><%= c.getAddress() %></td>
                                            <td class="border p-2"><%= c.getEmail() %></td><td class="border p-2"><%= c.getPhone() %></td>
                                            <td class="border p-2 font-bold text-blue-600"><%= car.getLicensePlate() %> (<%= car.getBrand() %>)</td>
                                            <td class="border p-2 text-center"><a href="SearchSparePartFrm.jsp?custId=<%= c.getId() %>&carId=<%= car.getId() %>" class="bg-blue-600 text-white px-3 py-1 rounded text-xs font-semibold hover:bg-blue-700">Chọn xe này</a></td>
                                        </tr>
                                    <% }
                                }
                            }
                        } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        <div class="flex justify-between items-center pt-4 border-t">
            <a href="../MainFrm.jsp" class="px-4 py-2 border rounded-lg text-slate-600 hover:bg-slate-100">Quay lại</a>
            <a href="AddNewCustomerFrm.jsp" class="bg-emerald-600 hover:bg-emerald-700 text-white font-semibold px-5 py-2 rounded-lg shadow">Thêm khách hàng mới</a>
        </div>
    </main>
</body>
</html>