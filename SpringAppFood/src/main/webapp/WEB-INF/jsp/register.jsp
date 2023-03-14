<%-- 
    Document   : register
    Created on : 30 Aug 2022, 11:57:18
    Author     : thien thien
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<h1 class="text-center text-danger">ĐĂNG KÝ</h1>

<c:if test="${errMsg !=null}">
    <div style="margin-top:20px" class="alert alert-danger">
        ${errMsg}
    </div>
    
</c:if>
<c:url value="/register" var="action"/>

<form:form style="margin-top:50px" method="post" action="${action}" 
           enctype="multipart/form-data" modelAttribute="user">
    <div style="margin-top:20px" class="form-group">
        <label for="firstname">First Name</label>    
        <form:input type="text" id="firstname" path="firstName" class="form-control"  />
    </div>
    <div style="margin-top:20px" class="form-group">
        <label for="lastname">Last Name</label>    
        <form:input type="text" id="lastname" path="lastName" class="form-control"  />
    </div>
    <div style="margin-top:20px" class="form-group">
        <label for="email">Email</label>    
        <form:input type="email" id="email" path="email" class="form-control"  />
    </div>   
    <div style="margin-top:20px" class="form-group">
        <label for="username">Username</label>    
        <form:input type="text" id="username" path="username" class="form-control"  />
    </div>
    <div style="margin-top:20px" class="form-group">
        <label for="password">Password</label>
         <form:input type="password" id="password" path="password" class="form-control"  />
    </div>
    <div style="margin-top:20px" class="form-group">
        <label for="confirm-password">Confirm Password</label>
         <form:input type="password" id="confirm-password" path="confirmPassword" class="form-control"  />
    </div>
    <div style="margin-top:20px" class="form-group">
        <label for="avatar">Avatar</label>
         <form:input type="file" id="avatar" path="file" class="form-control"  />
    </div>
    <div class="form-group">
        <label>Loại tài khoản <span style="color: red">*</span></label>
        <form:select path="userRole" class="custom-select">
            <form:option value="ROLE_KH" label="Khách hàng"
                         selected="${user.userRole.equals('ROLE_KH') ? true : ''}"/>
            <form:option value="ROLE_NH" label="Nhà hàng"
                         selected="${user.userRole.equals('ROLE_NH') ? true : ''}"/>
        </form:select>
    </div>
    <div style="margin-top:20px" class="form-group">
        <input type="submit" value="Đăng Ký " class="btn btn-primary" />
    </div>
</form:form>
