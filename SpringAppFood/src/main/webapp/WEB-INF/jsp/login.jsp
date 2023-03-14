<%-- 
    Document   : login
    Created on : 30 Aug 2022, 16:13:29
    Author     : thien thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<h1 class="text-center text-danger">ĐĂNG NHẬP</h1>

<c:if test="${param.error !=null}">
    <div class="alert alert-danger">
        Đã có lỗi xãy ra vui lòng nhập lại!
    </div>
    
</c:if>
<c:if test="${param.accessDenied != null}">
    <div class="alert alert-danger">
        Ban không có quyền truy cập
    </div>
    
</c:if>


<c:url value="/login" var="action" />
<form method="post" action="${action}">
  <div class="mb-3">
    <label for="username" class="form-label">Username</label>
    <input type="text"  name="username" id="username" class="form-control" name="username">
  </div>
  <div class="mb-3">
    <label for="password" class="form-label">Password</label>
    <input type="password" id="password" name="password" class="form-control" id="exampleInputPassword1">
  </div>
  <div class="mb-3 form-check">
    <input type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">Remember me</label>
  </div>
  <div class="mb-3">
    <h5>Chưa có tài khoản? <a href="<c:url value="/register"/>"> Đăng ký ngay!</a> </h5>
  </div>


  <button type="submit" class="btn btn-primary">Đăng nhập</button>
</form>
