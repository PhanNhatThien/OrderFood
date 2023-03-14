<%-- 
    Document   : details
    Created on : 24 Aug 2022, 10:45:30
    Author     : thien thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>

<h1 class="text-center text-danger" style="font-size: -webkit-xxx-large;">CHI TIẾT SẢN PHẨM</h1>

<div class="row">
    <div class="col-md-5">
        <img src="${product.image}" alt="${product.name}" class="img-fluid" />
    </div>
    <div class="col-md-7">
        <h1>${product.name}</h1>
        <h3>${product.price} VND</h3>
    </div>
</div>

<c:url value="/api/products/${product.id}/comments" var="endpoint" />
<sec:authorize access="!isAuthenticated()">
    <strong>Vui long <a href="<c:url value="/login" />">Đăng nhập tài khoản</a> để bình luận!!!</strong>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <div class="form-group">
        <textarea class="form-control" placeholder="Nhập nội dung bình luận" id="contentId"></textarea>
    </div>
    <button class="btn btn-danger" onclick="addComment('${endpoint}', ${product.id})">Thêm bình luận</button>
</sec:authorize>
<ul id="comments" class="list-group"">
</ul>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>

<script>
        window.onload = function () {
            loadComments('${endpoint}');
        }
</script> 
<script src="<c:url value="/js/product.js" />"></script>