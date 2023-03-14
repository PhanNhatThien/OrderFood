<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="container">
    <h1 class="text-center dark-color">QUẢN LÝ ĐƠN HÀNG</h1>
</div>
<div class="container">
    <c:if test="${sucMsg != null}">
        <div class="alert alert-success" role="alert">
                ${sucMsg}
        </div>
    </c:if>

    <c:if test="${errMsg != null}">
        <div class="alert alert-danger" role="alert">
                ${errMsg}
        </div>
    </c:if>
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link" href="<c:url value="/restaurant/confirm-order"/>">
                <i class="fa-solid fa-plus"></i>
                Xác nhận đơn hàng
            </a>
        </li>
    </ul>
    <table class="table table-striped">
        <thead>
        <tr>
            <th class="text-center" style="width: 15%">Thực thi</th>
            <th>STT</th>
            <th>Tổng tiền</th>
            <th>Ngày tạo</th>
            <th>Trạng thái đơn hàng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orders}" var="p" varStatus="loop">
            <tr>
                <td style="text-align: center">
                    <a style="margin-right: 10px" href="<c:url value="/restaurant/order/view" />?id=${p.id}"
                       title="Xem chi tiết">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                    <a style="margin-right: 10px" href="<c:url value="/restaurant/order/add-or-update" />?id=${p.id}"
                       title="Sửa">
                        <i class="fa-solid fa-pen"></i>
                    </a>
                    <a style="margin-right: 10px" href="<c:url value="/restaurant/order/delete" />?id=${p.id}"
                       class="confirmation" title="Xoá">
                        <i class="fa-solid fa-trash"></i>
                    </a>
                </td>

                <td>  ${p.id}  </td>
                <td> ${p.amount} </td>
                <td> ${p.createdDate}</td>
                <td>
                    <c:if test="${p.active == 1}">
                         <div class="alert alert-success" role="alert">
                               ĐÃ XÁC NHẬN
                         </div>
                     </c:if>
                     <c:if test="${p.active == 0}">
                         <div class="alert alert-danger" role="alert">
                                 CHƯA XÁC NHẬN
                         </div>
                     </c:if>
                 </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


</div>


<script>
    $(document).ready(function () {
        $("form").submit(function () {
            $("input, select").each(function (index, obj) {
                if ($(obj).val() === "" || $(obj).val() === "-1") {
                    $(obj).remove();
                }
            });
        });
    });
</script>