<%-- 
    Document   : nhahang
    Created on : 3 Sept 2022, 13:19:15
    Author     : thien thien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <h1 class="text-center dark-color">TRANG CHỦ NHÀ HÀNG</h1>
    <a class="nav-link text-danger" href="<c:url value="/restaurant" />">
        ${pageContext.session.getAttribute("currentUser").firstName}
        ${pageContext.session.getAttribute("currentUser").lastName}
        <c:if test="${currentUser.avatar != null}">
            <img  src="${currentUser.avatar}" class="img-fluid" />
        </c:if>
        <c:if test="${currentUser.avatar == null}">
            <img  src="${currentUser.avatar}" class="img-fluid" />
            &#128119;
        </c:if>
        <c:if test="${currentUser.active == 0}">
            <h4 class="text-center text-danger ">NHÀ HÀNG CHƯA ĐƯỢC KÍCH HOẠT</h4>
        </c:if>
        <c:if test="${currentUser.active == 1}">
            <h4 class="text-center text-danger ">NHÀ HÀNG ĐƯỢC KÍCH HOẠT</h4>
        </c:if>
        (<sec:authentication property="principal.username" />)
    </a>

</div>
