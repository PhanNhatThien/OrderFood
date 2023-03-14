<%-- 
    Document   : products
    Created on : 17 Aug 2022, 11:04:16
    Author     : thien thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<h1 class="text-center text-danger">QUẢN LÝ SẢN PHẨM</h1>

<c:url value="/admin/products" var="action" />
<form:form method="post" action="${action}" modelAttribute="product">
    <form:errors path="*" element="div" cssClass="alert alert-danger" />

    <div class="form-floating mb-3 mt-3">
        <form:input type="text" path="name" class="form-control" id="name" placeholder="name" name="name" />
        <label for="name">Tên sản phẩm </label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input type="number" path="price" class="form-control" id="price" placeholder="price" name="name" />
        <label for="name">Gía sản phẩm </label>
    </div>
    <div class="form-floating">
        <form:select path="categoryId" class="form-select" id="cate" name="cate">
            <c:forEach items="${categories}" var="c">
                <option value="${c.id}">${c.name}</option>
            </c:forEach>
        </form:select>
        <label for="cate" class="form-label">Danh mục sản phẩm </label>
    </div>
        
    <div>
        <br>
        <input type="submit" value="Thêm sản phẩm" class="btn btn-danger" />
    </div>
</form:form>

<div class="spinner-border text-success" id="mySpinner"></div>
<table class="table">
    <tr>
        <th></th>
        <th>Name</th>
        <th>Price</th>
        <th></th>
    </tr>
    <tbody id="myProduct">

    </tbody>
</table>


<script src="<c:url value="/js/product.js" />"></script>
<script>
    <c:url value="/api/products" var="endpoint" />
    window.onload = function() {
        getProducts('${endpoint}');
    }
</script>


