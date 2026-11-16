<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, model.*, java.util.ArrayList, java.time.LocalDate, java.sql.Date" %>
<%
    request.setCharacterEncoding("UTF-8");
    Staff8 saleStaff = (Staff8) session.getAttribute("saleStaff");
    if (saleStaff == null) { response.sendRedirect("LoginFrm.jsp"); return; }
    String custIdStr = (String) session.getAttribute("order_custId");
    String carIdStr = (String) session.getAttribute("order_carId");

    ArrayList<UsedSparePart8> selectedParts = (ArrayList<UsedSparePart8>) session.getAttribute("selected_spare_parts");
    ArrayList<UsedService8> selectedServices = (ArrayList<UsedService8>) session.getAttribute("selected_services");
    ArrayList<TechnicalAssignment8> selectedTechs = (ArrayList<TechnicalAssignment8>) session.getAttribute("selected_tech_staffs");

    Customer8 customer = null;
    Car8 car = null;

    if (custIdStr != null) {
        CustomerDAO cDao = new CustomerDAO();
        for (Customer8 c : cDao.findCustomer("")) {
            if (c.getId() == Integer.parseInt(custIdStr)) {
                customer = c;
                if (carIdStr != null) {
                    for (Car8 cr : c.getCars()) {
                        if (cr.getId() == Integer.parseInt(carIdStr)) {
                            car = cr;
                            break;
                        }
                    }
                }
                break;
            }
        }
    }

    String message = null;
    boolean isSuccess = false;

    if ("confirm".equals(request.getParameter("action")) &&
            (Boolean.TRUE.equals(session.getAttribute("repair_order_confirmed")) ||
             Boolean.TRUE.equals(session.getAttribute("repair_order_submitting")))) {
        isSuccess = true;
        message = "Phiếu sửa chữa này đã được lưu trước đó.";
    } else if ("confirm".equals(request.getParameter("action"))) {
        session.setAttribute("repair_order_submitting", true);
        RepairOrder8 ro = new RepairOrder8();
        ro.setReceivedDate(Date.valueOf(LocalDate.now()));
        ro.setS((SaleStaff8) saleStaff);
        ro.setC(customer);
        ro.setCar(car);
        ro.setUsp(selectedParts != null ? selectedParts : new ArrayList<UsedSparePart8>());
        ro.setUs(selectedServices != null ? selectedServices : new ArrayList<UsedService8>());
        ro.setTa(selectedTechs != null ? selectedTechs : new ArrayList<TechnicalAssignment8>());
        if (customer == null || car == null) {
            message = "Khách hàng hoặc xe không hợp lệ.";
            session.removeAttribute("repair_order_submitting");
        } else if (new RepairOrderDAO().saveRepairOrder(ro)) {
            isSuccess = true;
            message = "Khởi tạo phiếu tiếp nhận xe sửa chữa thành công!";
            session.setAttribute("repair_order_confirmed", true);
            session.removeAttribute("repair_order_submitting");
            session.removeAttribute("selected_spare_parts");
            session.removeAttribute("selected_services");
            session.removeAttribute("selected_tech_staffs");
            session.removeAttribute("order_custId");
            session.removeAttribute("order_carId");
        } else {
            session.removeAttribute("repair_order_submitting");
            message = "Lỗi khi lưu phiếu tiếp nhận vào CSDL!";
        }
    }
    RepairOrder8 ro = new RepairOrder8();
    ro.setReceivedDate(Date.valueOf(LocalDate.now()));
    ro.setS((SaleStaff8) saleStaff);
    ro.setC(customer);
    ro.setCar(car);
    ro.setUsp(selectedParts != null ? selectedParts : new ArrayList<UsedSparePart8>());
    ro.setUs(selectedServices != null ? selectedServices : new ArrayList<UsedService8>());
    ro.setTa(selectedTechs != null ? selectedTechs : new ArrayList<TechnicalAssignment8>());
    double totalParts = ro.calTotalSparePart();
    double totalServices = ro.calTotalService();
    double grandTotal = ro.calGrandTotal();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Nhận Phiếu Tiếp Nhận Xe</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen py-8">
    <div class="max-w-3xl mx-auto bg-white p-8 rounded-xl shadow">
        <h2 class="text-2xl font-bold text-center text-slate-800 mb-6 border-b pb-3">PHIẾU TIẾP NHẬN XE SỬA CHỮA</h2>

        <% if (message != null) { %>
            <div class="mb-6 p-4 rounded-lg text-center font-bold <%= isSuccess ? "bg-green-100 text-green-800 border border-green-300" : "bg-red-100 text-red-800 border border-red-300" %>">
                <%= message %>
                <% if (isSuccess) { %>
                    <div class="mt-4"><a href="../MainFrm.jsp" class="inline-block bg-green-600 text-white px-6 py-2 rounded font-semibold">OK / Về trang chủ</a></div>
                <% } %>
            </div>
        <% } %>

        <% if (!isSuccess) { %>
            <div class="bg-slate-50 p-4 rounded-lg mb-6 border text-sm space-y-2">
                <div><span class="font-semibold text-slate-600">Tên nhân viên bán hàng:</span> <%= saleStaff != null ? saleStaff.getName() : "N/A" %></div>
                <div><span class="font-semibold text-slate-600">Tên khách hàng:</span> <%= customer != null ? customer.getName() : "N/A" %></div>
                <div><span class="font-semibold text-slate-600">Địa chỉ:</span> <%= customer != null ? customer.getAddress() : "N/A" %></div>
                <div><span class="font-semibold text-slate-600">Email:</span> <%= customer != null ? customer.getEmail() : "N/A" %></div>
                <div><span class="font-semibold text-slate-600">Số điện thoại:</span> <%= customer != null ? customer.getPhone() : "N/A" %></div>
                <div><span class="font-semibold text-slate-600">Biển số xe sửa chữa:</span> <span class="font-bold text-blue-600"><%= car != null ? car.getLicensePlate() : "N/A" %></span></div>
            </div>

            <h3 class="font-bold text-slate-800 mb-2 text-sm">1. Danh sách phụ tùng sử dụng</h3>
            <table class="w-full border-collapse border text-xs mb-4">
                <thead class="bg-slate-100">
                    <tr><th class="border p-2">Tên phụ tùng</th><th class="border p-2">Số lượng</th><th class="border p-2">Đơn giá</th><th class="border p-2">Tổng giá</th></tr>
                </thead>
                <tbody>
                    <% for (UsedSparePart8 usp : ro.getUsp()) { %>
                        <tr>
                            <td class="border p-2"><%= usp.getSp().getName() %></td>
                            <td class="border p-2 text-center"><%= usp.getQuantity() %></td>
                            <td class="border p-2 text-right"><%= (long)usp.getPrice() %></td>
                            <td class="border p-2 text-right"><%= (long)usp.calSubTotal() %></td>
                        </tr>
                    <% } %>
                    <tr class="font-bold bg-slate-50">
                        <td colspan="3" class="border p-2 text-right">Tổng tiền phụ tùng:</td>
                        <td class="border p-2 text-right text-blue-600"><%= (long)totalParts %></td>
                    </tr>
                </tbody>
            </table>

            <h3 class="font-bold text-slate-800 mb-2 text-sm">2. Danh sách dịch vụ sử dụng</h3>
            <table class="w-full border-collapse border text-xs mb-4">
                <thead class="bg-slate-100">
                    <tr><th class="border p-2">Tên dịch vụ</th><th class="border p-2">Đơn giá</th></tr>
                </thead>
                <tbody>
                    <% for (UsedService8 us : ro.getUs()) { %>
                        <tr><td class="border p-2"><%= us.getSer().getName() %></td><td class="border p-2 text-right"><%= (long)us.getPrice() %></td></tr>
                    <% } %>
                    <tr class="font-bold bg-slate-50">
                        <td class="border p-2 text-right">Tổng tiền dịch vụ:</td>
                        <td class="border p-2 text-right text-blue-600"><%= (long)totalServices %></td>
                    </tr>
                </tbody>
            </table>

            <h3 class="font-bold text-slate-800 mb-2 text-sm">3. Danh sách nhân viên kỹ thuật</h3>
            <table class="w-full border-collapse border text-xs mb-6">
                <thead class="bg-slate-100">
                    <tr><th class="border p-2">Họ tên nhân viên kỹ thuật</th><th class="border p-2">Chuyên ngành</th></tr>
                </thead>
                <tbody>
                    <% for (TechnicalAssignment8 ta : ro.getTa()) { %>
                        <tr><td class="border p-2"><%= ta.getTs().getName() %></td><td class="border p-2"><%= ta.getTs().getMajor() %></td></tr>
                    <% } %>
                </tbody>
            </table>

            <div class="bg-blue-50 border border-blue-200 p-4 rounded-lg mb-6 flex justify-between items-center">
                <span class="font-bold text-slate-700 text-lg">Tổng cộng thanh toán:</span>
                <span class="font-extrabold text-2xl text-blue-700"><%= (long)grandTotal %> VNĐ</span>
            </div>

            <form method="POST" action="ConfirmFrm.jsp?action=confirm" class="flex justify-between items-center pt-4 border-t">
                <a href="SearchTechnicalStaffFrm.jsp" class="px-4 py-2 border rounded text-slate-600 hover:bg-slate-100">Quay lại</a>
                <button type="submit" class="bg-emerald-600 hover:bg-emerald-700 text-white font-bold px-8 py-2.5 rounded shadow">Xác nhận & Lưu phiếu</button>
            </form>
        <% } %>
    </div>
</body>
</html>