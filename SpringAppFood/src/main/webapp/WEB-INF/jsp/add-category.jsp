<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
<c:if test="${category.id == 0}">
    <h1 class="text-center dark-color">THÊM DANH MỤC</h1>
</c:if>
<c:if test="${category.id > 0}">
    <h1 class="text-center dark-color">CHỈNH SỬA DANH MỤC</h1>
</c:if>

<c:url value="/admin/category/add-or-update" var="action"/>

<form:form action="${action}" method="post" modelAttribute="category">
    <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
    <form:hidden path="id"/>
    <div class="form-group">
        <label>Tên</label>
        <form:input path="name" class="form-control" autofocus="autofocus"/>
    </div>
    <div class="form-group">
        <label>Mô tả</label>
        <form:input path="description" class="form-control" autofocus="autofocus"/>
    </div>
    <c:if test="${category.id == 0}">
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Thêm</button>
        </div>
    </c:if>
    <c:if test="${category.id > 0}">
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Cập nhật</button>
        </div>
    </c:if>
</form:form>
</div>