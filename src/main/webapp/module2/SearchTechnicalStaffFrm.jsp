<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.TechnicalStaffDAO, model.TechnicalStaff8, model.TechnicalAssignment8, java.util.ArrayList" %>
<%
    request.setCharacterEncoding("UTF-8");
    ArrayList<TechnicalAssignment8> selectedTechs = (ArrayList<TechnicalAssignment8>) session.getAttribute("selected_tech_staffs");
    if (selectedTechs == null) {
        selectedTechs = new ArrayList<TechnicalAssignment8>();
        session.setAttribute("selected_tech_staffs", selectedTechs);
    }

    String action = request.getParameter("action");
    if ("add".equals(action)) {
        int techId = Integer.parseInt(request.getParameter("techId"));
        for (TechnicalStaff8 ts : new TechnicalStaffDAO().findTechnicalStaff("")) {
            if (ts.getId() == techId) {
                selectedTechs.add(new TechnicalAssignment8(0, ts));
                break;
            }
        }
    } else if ("remove".equals(action)) {
        int index = Integer.parseInt(request.getParameter("index"));
        if (index >= 0 && index < selectedTechs.size()) {
            selectedTechs.remove(index);
        }
    }

    String searchKeyword = request.getParameter("name");
    ArrayList<TechnicalStaff8> techList = new ArrayList<TechnicalStaff8>();
    if (searchKeyword != null) {
        techList = new TechnicalStaffDAO().findTechnicalStaff(searchKeyword);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Nhân Viên Kỹ Thuật</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-8">
    <div class="max-w-4xl mx-auto bg-white p-8 rounded-xl shadow">
        <h2 class="text-xl font-bold text-slate-800 mb-4 text-center">TÌM KIẾM NHÂN VIÊN KỸ THUẬT</h2>
        <form method="GET" action="SearchTechnicalStaffFrm.jsp" class="flex gap-4 mb-6 max-w-md mx-auto">
            <input type="text" name="name" value="<%= searchKeyword != null ? searchKeyword : "" %>" placeholder="Nhập tên nhân viên (vd: Bảo)" class="flex-1 border rounded px-3 py-1.5 outline-none focus:ring-2 focus:ring-blue-500">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-4 py-1.5 rounded shadow">Tìm kiếm</button>
        </form>
        <% if (searchKeyword != null) { %>
            <div class="mb-6">
                <table class="w-full border-collapse border border-slate-200 text-sm">
                    <thead class="bg-slate-100"><tr><th class="border p-2">Họ tên</th><th class="border p-2">Chuyên ngành</th><th class="border p-2">Thao tác</th></tr></thead>
                    <tbody>
                        <% for (TechnicalStaff8 ts : techList) { %>
                            <tr>
                                <td class="border p-2 font-medium"><%= ts.getName() %></td>
                                <td class="border p-2"><%= ts.getMajor() %></td>
                                <td class="border p-2 text-center"><a href="SearchTechnicalStaffFrm.jsp?action=add&techId=<%= ts.getId() %><%= searchKeyword != null ? "&name=" + searchKeyword : "" %>" class="bg-emerald-600 hover:bg-emerald-700 text-white px-3 py-1 rounded text-xs font-semibold">Chọn</a></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        <h3 class="font-bold text-slate-800 mb-2">DANH SÁCH NHÂN VIÊN KỸ THUẬT ĐÃ CHỌN</h3>
        <table class="w-full border-collapse border border-slate-200 text-sm mb-6">
            <thead class="bg-slate-100">
                <tr>
                    <th class="border p-2">Họ tên nhân viên</th>
                    <th class="border p-2">Chuyên ngành</th>
                    <th class="border p-2">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% if (selectedTechs.isEmpty()) { %>
                    <tr><td colspan="3" class="text-center p-3 text-slate-400">Chưa chọn kỹ thuật viên nào.</td></tr>
                <% } else {
                    for (int i = 0; i < selectedTechs.size(); i++) {
                        TechnicalAssignment8 item = selectedTechs.get(i); %>
                        <tr>
                            <td class="border p-2 font-medium"><%= item.getTs().getName() %></td>
                            <td class="border p-2"><%= item.getTs().getMajor() %></td>
                            <td class="border p-2 text-center">
                                <a href="SearchTechnicalStaffFrm.jsp?action=remove&index=<%= i %><%= searchKeyword != null ? "&name=" + searchKeyword : "" %>" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-xs font-semibold">Xóa</a>
                            </td>
                        </tr>
                    <% }
                } %>
            </tbody>
        </table>
        <div class="flex justify-between items-center pt-4 border-t">
            <a href="SearchServiceFrm.jsp" class="px-4 py-2 border rounded text-slate-600 hover:bg-slate-100">Quay lại</a>
            <a href="ConfirmFrm.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow">Tiếp theo</a>
        </div>
    </div>
</body>
</html>