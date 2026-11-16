<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ServiceDAO, model.Service8, model.UsedService8, java.util.ArrayList" %>
<%
    request.setCharacterEncoding("UTF-8");
    ArrayList<UsedService8> selectedServices = (ArrayList<UsedService8>) session.getAttribute("selected_services");
    if (selectedServices == null) {
        selectedServices = new ArrayList<UsedService8>();
        session.setAttribute("selected_services", selectedServices);
    }

    String action = request.getParameter("action");
    if ("add".equals(action)) {
        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        for (Service8 s : new ServiceDAO().findService("")) {
            if (s.getId() == serviceId) {
                selectedServices.add(new UsedService8(0, s.getPrice(), s));
                break;
            }
        }
    } else if ("remove".equals(action)) {
        int index = Integer.parseInt(request.getParameter("index"));
        if (index >= 0 && index < selectedServices.size()) {
            selectedServices.remove(index);
        }
    }

    String searchKeyword = request.getParameter("name");
    ArrayList<Service8> serviceList = new ArrayList<Service8>();
    if (searchKeyword != null) {
        serviceList = new ServiceDAO().findService(searchKeyword);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Dịch Vụ</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-8">
    <div class="max-w-4xl mx-auto bg-white p-8 rounded-xl shadow">
        <h2 class="text-xl font-bold text-slate-800 mb-4 text-center">TÌM KIẾM DỊCH VỤ</h2>
        <form method="GET" action="SearchServiceFrm.jsp" class="flex gap-4 mb-6 max-w-md mx-auto">
            <input type="text" name="name" value="<%= searchKeyword != null ? searchKeyword : "" %>" placeholder="Nhập tên dịch vụ (vd: Kiểm tra)" class="flex-1 border rounded px-3 py-1.5 outline-none focus:ring-2 focus:ring-blue-500">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-4 py-1.5 rounded shadow">Tìm kiếm</button>
        </form>
        <% if (searchKeyword != null) { %>
            <div class="mb-6">
                <table class="w-full border-collapse border border-slate-200 text-sm">
                    <thead class="bg-slate-100"><tr><th class="border p-2">Tên dịch vụ</th><th class="border p-2">Giá</th><th class="border p-2">Mô tả</th><th class="border p-2">Thao tác</th></tr></thead>
                    <tbody>
                        <% for (Service8 s : serviceList) { %>
                            <tr>
                                <td class="border p-2 font-medium"><%= s.getName() %></td>
                                <td class="border p-2 text-right font-bold text-slate-700"><%= (long)s.getPrice() %></td>
                                <td class="border p-2 text-slate-600"><%= s.getDescription() %></td>
                                <td class="border p-2 text-center"><a href="SearchServiceFrm.jsp?action=add&serviceId=<%= s.getId() %><%= searchKeyword != null ? "&name=" + searchKeyword : "" %>" class="bg-emerald-600 hover:bg-emerald-700 text-white px-3 py-1 rounded text-xs font-semibold">Chọn</a></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        <h3 class="font-bold text-slate-800 mb-2">DANH SÁCH DỊCH VỤ ĐÃ CHỌN</h3>
        <table class="w-full border-collapse border border-slate-200 text-sm mb-6">
            <thead class="bg-slate-100">
                <tr>
                    <th class="border p-2">Tên dịch vụ</th>
                    <th class="border p-2">Tổng giá</th>
                    <th class="border p-2">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% if (selectedServices.isEmpty()) { %>
                    <tr><td colspan="3" class="text-center p-3 text-slate-400">Chưa chọn dịch vụ nào.</td></tr>
                <% } else {
                    for (int i = 0; i < selectedServices.size(); i++) {
                        UsedService8 item = selectedServices.get(i); %>
                        <tr>
                            <td class="border p-2 font-medium"><%= item.getSer().getName() %></td>
                            <td class="border p-2 text-right font-bold text-blue-600"><%= (long)item.getPrice() %></td>
                            <td class="border p-2 text-center">
                                <a href="SearchServiceFrm.jsp?action=remove&index=<%= i %><%= searchKeyword != null ? "&name=" + searchKeyword : "" %>" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-xs font-semibold">Xóa</a>
                            </td>
                        </tr>
                    <% }
                } %>
            </tbody>
        </table>
        <div class="flex justify-between items-center pt-4 border-t">
            <a href="SearchSparePartFrm.jsp" class="px-4 py-2 border rounded text-slate-600 hover:bg-slate-100">Quay lại</a>
            <a href="SearchTechnicalStaffFrm.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow">Tiếp theo</a>
        </div>
    </div>
</body>
</html>