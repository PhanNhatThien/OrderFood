<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<h1 class="text-center dark-color">XÁC NHẬN ĐƠN HÀNG</h1>

<c:if test="${orders.size() == 0}">
    <div class="alert alert-success mt-4 d-flex justify-content-center align-items-center" style="height: 80px"
         role="alert">
        <h5 class="m-0">TẤT CẢ ĐƠN HÀNG ĐÃ ĐƯỢC XÁC NHẬN!</h5>
    </div>
</c:if>
<c:if test="${orders.size() > 0}">
    <table class="table table-striped">
        <thead>
            <tr>
                <th class="text-center" style="width: 10%">Xác nhận</th>
                <th class="text-center" style="width: 5%">STT</th>
                <th> Mã đơn hàng </th>
                <th>Gía </th>
                <th>Ngày tạo </th>
                
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${orders}" var="u" varStatus="loop">
                <tr>
                    <td style="text-align: center">
                        <a style="margin-right: 10px"
                           href="<c:url value="/restaurant/confirm-order/accept" />?id=${u.id}"
                           data-toggle="tooltip"
                           title="Duyệt">
                            <i class="fa-solid fa-check"></i>
                        </a>
                    </td>
                    <td class="text-center">${loop.index + 1}</td>
                    <td>${u.id}</td>
                    <td>${u.amount}</td>
                    <td>${u.createdDate}</td>

                </tr>
            </c:forEach>
        </tbody>
    </table>

</c:if>

