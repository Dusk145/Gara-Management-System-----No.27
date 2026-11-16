<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SparePartDAO, model.SparePart8, model.UsedSparePart8, java.util.ArrayList" %>
<%
    request.setCharacterEncoding("UTF-8");
    if (request.getParameter("custId") != null) session.setAttribute("order_custId", request.getParameter("custId"));
    if (request.getParameter("carId") != null) session.setAttribute("order_carId", request.getParameter("carId"));

    ArrayList<UsedSparePart8> selectedParts = (ArrayList<UsedSparePart8>) session.getAttribute("selected_spare_parts");
    if (selectedParts == null) {
        selectedParts = new ArrayList<UsedSparePart8>();
        session.setAttribute("selected_spare_parts", selectedParts);
    }

    String action = request.getParameter("action");
    if ("add".equals(action)) {
        int partId = Integer.parseInt(request.getParameter("partId"));
        int qty = Integer.parseInt(request.getParameter("quantity"));
        SparePartDAO dao = new SparePartDAO();
        for (SparePart8 sp : dao.findSparePart("")) {
            if (sp.getId() == partId) {
                selectedParts.add(new UsedSparePart8(0, sp.getPrice(), qty, sp));
                break;
            }
        }
    } else if ("remove".equals(action)) {
        int index = Integer.parseInt(request.getParameter("index"));
        if (index >= 0 && index < selectedParts.size()) {
            selectedParts.remove(index);
        }
    }

    String searchKeyword = request.getParameter("name");
    ArrayList<SparePart8> partList = new ArrayList<SparePart8>();
    if (searchKeyword != null) {
        partList = new SparePartDAO().findSparePart(searchKeyword);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Phụ Tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-8">
    <div class="max-w-4xl mx-auto bg-white p-8 rounded-xl shadow">
        <h2 class="text-xl font-bold text-slate-800 mb-4 text-center">TÌM KIẾM PHỤ TÙNG</h2>
        <form method="GET" action="SearchSparePartFrm.jsp" class="flex gap-4 mb-6 max-w-md mx-auto">
            <input type="text" name="name" value="<%= searchKeyword != null ? searchKeyword : "" %>" placeholder="Nhập tên phụ tùng (vd: Vít)" class="flex-1 border rounded px-3 py-1.5 outline-none focus:ring-2 focus:ring-blue-500">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-4 py-1.5 rounded shadow">Tìm kiếm</button>
        </form>
        <% if (searchKeyword != null) { %>
            <div class="mb-6">
                <table class="w-full border-collapse border border-slate-200 text-sm">
                    <thead class="bg-slate-100">
                        <tr><th class="border p-2">Tên phụ tùng</th><th class="border p-2">Tồn kho</th><th class="border p-2">Đơn giá</th><th class="border p-2">Số lượng</th><th class="border p-2">Thao tác</th></tr>
                    </thead>
                    <tbody>
                        <% for (SparePart8 sp : partList) { %>
                            <form method="POST" action="SearchSparePartFrm.jsp?action=add<%= searchKeyword != null ? "&name=" + searchKeyword : "" %>">
                                <input type="hidden" name="partId" value="<%= sp.getId() %>">
                                <tr>
                                    <td class="border p-2 font-medium"><%= sp.getName() %></td>
                                    <td class="border p-2 text-center"><%= sp.getStockQuantity() %></td>
                                    <td class="border p-2 text-right"><%= (long)sp.getPrice() %></td>
                                    <td class="border p-2 text-center w-32"><input type="number" name="quantity" value="1" min="1" max="<%= sp.getStockQuantity() %>" class="w-20 border rounded px-2 py-1 text-center"></td>
                                    <td class="border p-2 text-center"><button type="submit" class="bg-emerald-600 hover:bg-emerald-700 text-white px-3 py-1 rounded text-xs font-semibold">Chọn</button></td>
                                </tr>
                            </form>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        <h3 class="font-bold text-slate-800 mb-2">DANH SÁCH PHỤ TÙNG ĐÃ CHỌN</h3>
        <table class="w-full border-collapse border border-slate-200 text-sm mb-6">
            <thead class="bg-slate-100">
                <tr>
                    <th class="border p-2">Tên phụ tùng</th>
                    <th class="border p-2">Số lượng</th>
                    <th class="border p-2">Đơn giá</th>
                    <th class="border p-2">Tổng giá</th>
                    <th class="border p-2">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% if (selectedParts.isEmpty()) { %>
                    <tr><td colspan="5" class="text-center p-3 text-slate-400">Chưa chọn phụ tùng nào.</td></tr>
                <% } else {
                    for (int i = 0; i < selectedParts.size(); i++) {
                        UsedSparePart8 item = selectedParts.get(i); %>
                        <tr>
                            <td class="border p-2 font-medium"><%= item.getSp().getName() %></td>
                            <td class="border p-2 text-center"><%= item.getQuantity() %></td>
                            <td class="border p-2 text-right"><%= (long)item.getPrice() %></td>
                            <td class="border p-2 text-right font-bold text-blue-600"><%= (long)item.calSubTotal() %></td>
                            <td class="border p-2 text-center">
                                <a href="SearchSparePartFrm.jsp?action=remove&index=<%= i %><%= searchKeyword != null ? "&name=" + searchKeyword : "" %>" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-xs font-semibold">Xóa</a>
                            </td>
                        </tr>
                    <% }
                } %>
            </tbody>
        </table>
        <div class="flex justify-between items-center pt-4 border-t">
            <a href="SearchCustomerFrm.jsp" class="px-4 py-2 border rounded text-slate-600 hover:bg-slate-100">Quay lại</a>
            <a href="SearchServiceFrm.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow">Tiếp theo</a>
        </div>
    </div>
</body>
</html>