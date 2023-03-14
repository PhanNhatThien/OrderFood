<%-- 
    Document   : cart
    Created on : 31 Aug 2022, 16:21:11
    Author     : thien thien
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<h1 class="text-center text-danger">GIỎ HÀNG</h1>

<c:if test="${carts == null}">
    <h4 class="text-center text-danger">Không có sản phẩm nào trong giỏ</h4>
</c:if>


<c:if test="${carts != null}">
    <table class="table">
        <tr>
            <th>Mã sản phẩm</th>
            <th>Tên sản phẩm</th>
            <th>Đơn giá</th>
            <th>Số lượng</th>
            <th></th>
        </tr>
        <c:forEach items="${carts}" var="c">
            <tr id="product${c.productId}">
                <td>${c.productId}</td>
                <td>${c.productName}</td>
                <td>${c.price} VND</td>
                <td>
                    <div class="form-group">
                        <input type="number"
                               onblur="updateCart(this,${c.productId})"
                               value="${c.quantity}" 
                               class="form-control" />
                    </div>
                </td>
                <td>
                    <input type="button"
                       value="Xóa"
                       onclick="deleteCart(${c.productId})"
                       class="btn btn-danger"/>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td><a href="/SpringAppFood/" class="btn btn-warning"><i class="fa fa-angle-left"></i> Tiếp tục mua hàng</a>
            </td>

            <td colspan="2" class="hidden-xs"> </td>
            <td class="hidden-xs text-center"><h4>Tổng tiền:<span id="amountCart">${cartStats.amount} VND</h4></strong>
            </td>
            <td><a class="btn btn-success btn-block" onclick="pay()">Thanh toán <i class="fa fa-angle-right"></i></a>
            </td>
        </tr>
    </table>
</c:if>

