<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<h1 class="text-center dark-color">THAY ĐỔI TRẠNG THÁI SẢN PHẨM</h1>


    <table class="table table-striped">
        <thead>
            <tr>
                <th class="text-center" style="width: 10%">Xác nhận</th>
                <th class="text-center" style="width: 10%">Hủy Xác nhận</th>
                <th> Mã đơn hàng </th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${products}" var="u" varStatus="loop">
                <tr>
                    <td style="text-align: center">
                        <a style="margin-right: 10px"
                           href="<c:url value="/restaurant/confirm-product/accept" />?id=${u.id}"
                           data-toggle="tooltip"
                           title="Duyệt">
                            <i class="fa-solid fa-check"></i>
                        </a>
                    </td>
                    <td style="text-align: center">
                        <a style="margin-right: 10px"
                           href="<c:url value="/restaurant/cancel-product/accept" />?id=${u.id}"
                           data-toggle="tooltip"
                           title="Hủy">
                            <i class="fa-solid fa-check"></i>
                        </a>
                    </td>

                    <td>${u.id}</td>

                </tr>
            </c:forEach>
        </tbody>
    </table>



