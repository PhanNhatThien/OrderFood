<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
    <c:if test="${restaurant.id == 0}">
        <h1 class="text-center dark-color">THÊM THÔNG TIN NHÀ HÀNG</h1>
    </c:if>
    <c:if test="${restaurant.id > 0}">
        <h1 class="text-center dark-color">CHỈNH SỬA THÔNG TIN NHÀ HÀNG</h1>
    </c:if>

    <c:if test="${sucMsg != null}">
        <div class="alert alert-success mt-4" role="alert">
                ${sucMsg}
        </div>
    </c:if>

    <c:if test="${errMsg != null}">
        <div class="alert alert-danger mt-4" role="alert">
                ${errMsg}
        </div>
    </c:if>

    <c:choose>
        <c:when test="${actionUrl != null}">
            <c:url value="${actionUrl}" var="action"/>
        </c:when>
        <c:otherwise>
            <c:url value="/admin/account/employer-info/add-or-update" var="action"/>
        </c:otherwise>
    </c:choose>

    <form:form action="${action}" method="post"
               modelAttribute="restaurant" cssClass="mt-4">

        <form:hidden path="id"/>
        <form:hidden path="userId" value="${userId}" class="form-control"/>
        <div class="form-group">
            <label>Tên nhà hàng</label>
            <form:input path="name" class="form-control" autofocus="autofocus"/>
        </div>
        <div class="form-group">
            <label>Mô tả</label>
            <form:textarea path="description" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Địa chỉ</label>
            <form:input path="location" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Liên hệ</label>
            <form:input path="contact" class="form-control"/>
        </div>
        <c:if test="${restaurant.id == 0}">
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Thêm</button>
            </div>
        </c:if>
        <c:if test="${restaurant.id > 0}">
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </div>
        </c:if>
    </form:form>
</div>