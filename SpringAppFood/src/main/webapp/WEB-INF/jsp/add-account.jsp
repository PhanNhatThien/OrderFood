<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<c:if test="${user.id == 0}">
    <h1 class="text-center dark-color">THÊM TÀI KHOẢN</h1>
</c:if>
<c:if test="${user.id > 0}">
    <h1 class="text-center dark-color">CHỈNH SỬA THÔNG TIN TÀI KHOẢN</h1>
</c:if>

<c:url value="/admin/account/add-or-update" var="action"/>

<c:if test="${errMsg != null}">
    <div class="alert alert-danger">
            ${errMsg}
    </div>
</c:if>

<form:form action="${action}" method="post" enctype="multipart/form-data" modelAttribute="user">
    <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
    <form:hidden path="id"/>
    <form:hidden path="avatar"/>
    <div class="form-group">
        <label>Tên đăng nhập <span style="color: red">*</span></label>
        <form:input path="username" class="form-control"  autofocus="autofocus"/>
    </div>
    <div class="form-group">
        <label>Mật khẩu <span style="color: red">*</span></label>
        <form:input path="password" class="form-control" id="password" type="password" required="required"/>
    </div>
    <div class="form-group">
        <label>Nhập lại mật khẩu <span style="color: red">*</span></label>
        <form:input path="confirmPassword" class="form-control" id="confirmPassword" type="password"
                    required="required"/>
    </div>
    <div class="form-group">
        <label>Email</label>
        <form:input path="email" class="form-control"/>
    </div>
    <div class="form-group">
        <label>Số điện thoại</label>
        <form:input path="phone" class="form-control"/>
    </div>
    <div class="form-group row">
        <div class="col">
            <label for="avatar">Ảnh đại diện</label>
            <form:input type="file" id="imgInp" path="file"
                        accept="image/*" class="form-control"/>
        </div>
        <div class="col text-center">
            <img src="<c:url value="${user.avatar}"/>"
                 style="height: 200px; margin-top: 10px; border: 1px solid black;"
                 class="img-fluid rounded" id="blah" alt="avatar">
        </div>
    </div>
    <div class="form-group">
        <label>tên</label>
        <form:input path="firstName" class="form-control"/>
    </div>
    <div class="form-group">
        <label>họ</label>
        <form:input path="lastName" class="form-control"/>
    </div>
    <div class="form-group">
        <label>Loại tài khoản <span style="color: red">*</span></label>
        <form:select path="userRole" class="custom-select">
            <form:option value="ROLE_KH" label="Khách hàng"
                         selected="${user.userRole.equals('ROLE_KH') ? true : ''}"/>
            <form:option value="ROLE_NH" label="Nhà hàng"
                         selected="${user.userRole.equals('ROLE_NH') ? true : ''}"/>
            <form:option value="ROLE_ADMIN" label="Admin"
                         selected="${user.userRole.equals('ROLE_ADMIN') ? true : ''}"/>
        </form:select>
    </div>
    <div class="form-group">
        <label>Kích hoạt <span style="color: red">*</span></label>
        <form:select path="active" class="custom-select">
            <form:option value="0" label="Chưa kích hoạt" selected="${user.active == 0 ? true : ''}"/>
            <form:option value="1" label="Đã kích hoạt" selected="${user.active == 1 ? true : ''}"/>
        </form:select>
    </div>

    <c:if test="${user.id == 0}">
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Thêm</button>
        </div>
    </c:if>
    <c:if test="${user.id > 0}">
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Cập nhật</button>
        </div>
    </c:if>
</form:form>
