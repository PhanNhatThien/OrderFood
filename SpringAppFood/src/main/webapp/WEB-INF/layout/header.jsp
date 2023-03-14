<%-- 
    Document   : header
    Created on : 17 Aug 2022, 11:42:09
    Author     : thien thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="<c:url value="/js/product.js" />"></script>
<script src="<c:url value="/js/index.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">


<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark gradient-custom">
  <!-- Container wrapper -->
  <div class="container-fluid">
    <!-- Navbar brand -->

    <a class="navbar-brand" href="/SpringAppFood/">&#127836; AppFood</a>

    <!-- Toggle button -->
    <button class="navbar-toggler" type="button" data-mdb-toggle="collapse"
      data-mdb-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
      aria-label="Toggle navigation">
      <i class="fas fa-bars text-light"></i>
    </button>

    <!-- Collapsible wrapper -->
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <!-- Left links -->
      <ul class="navbar-nav me-auto d-flex flex-row mt-3 mt-lg-0">
        <sec:authorize access="hasRole('ROLE_KH')">
            <c:forEach items="${categories}" var="c">
                <c:url value="/" var="cUrl">
                    <c:param name="cateId" value="${c.id}" />
                </c:url>
                <li class="nav-item">

                    <a class="nav-link" href="${cUrl}">
                        <div style="text-align:center">
                          <i class="fas fa-hamburger"></i>
                        </div>
                        ${c.name}
                    </a>
                </li>
            </c:forEach>
            <li class="nav-item text-success" >

                <a class="nav-link" href="<c:url value="/cart" />" >
                    <div>
                      <span class="badge rounded-pill badge-notification" style="background-color:gray" id="cartCounter">${cartCounter}</span>
                    </div>
                    <i>&#128722;</i>
                  </a>
            </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li class="nav-item" style="color:white">
                <a class="nav-link" href="<c:url value="/admin/product-post" />">Quản lý sản phẩm </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="<c:url value="/admin/category" />">Quản lý danh mục </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="<c:url value="/admin/account" />">Quản lý tài khoản  </a>
            </li>

            <li class="nav-item">
                <a class="nav-link " href="<c:url value="/admin/account-permission" />">Duyệt tài khoản nhà hàng</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Thống kê</a>
                <ul class="dropdown-menu" >
                    <li><a class="dropdown-item" href="<c:url value="/admin/userStats" />">Thống kê số sản phẩm của cửa hàng</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/admin/UserRoleStats" />">Thống kê theo loại tài khoản</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/admin/ProductStats" />">Thống kê bài viết theo tháng</a></li>
                </ul>
            </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_NH')">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/restaurant/restaurant-info/add-or-update" />">Chỉnh sửa thông tin</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/restaurant/post/add-or-update" />">Đăng sản phẩm</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/restaurant/management" />">Quản lý bài viết</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/restaurant/order" />">Quản lý đơn hàng</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Thống kê</a>
                <ul class="dropdown-menu" >
                    <li><a class="dropdown-item" href="<c:url value="/restaurant/stats-cate" />">Thống kê theo danh mục</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/restaurant/stats-revenue" />">Thống kê theo doanh thu</a></li>
                </ul>
            </li>

        </sec:authorize>
      </ul>
      <!-- Left links -->

      <!-- Search form -->
        <c:url value="/" var="action" />
        <form method="get" action="${action}" class="d-flex input-group w-auto ms-lg-3 my-3 my-lg-0">
            <input class="form-control me-2 search" type="search" class="form-control" name="kw" placeholder="Nhập từ khóa để tìm...">
            <button type="submit" class="btn btn-outline-white search" type="button" data-mdb-ripple-color="dark"><i class="fa fa-search"></i></button>
        </form>

      <!-- Right links -->
      <ul class="navbar-nav ms-auto d-flex flex-row mt-3 mt-lg-0">
        <sec:authorize access="!isAuthenticated()">
            <c:if test="${pageContext.request.userPrincipal.name == null}">
                <li class="nav-item active">

                    <a class="nav-link " href="<c:url value="/login" />">
                        <div style="text-align:center">
                         <i class="fa fa-sign-in"></i>
                        </div>
                        Đăng Nhập
                      </a>
                </li>
            </c:if>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <li class="nav-item active">
                    <a class="nav-link text-danger" href="<c:url value="/" />">${pageContext.request.userPrincipal.name}</a>
                </li>
            </c:if>

            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/register" />">
                <div style="text-align:center">
                  <i class="fa fa-user-plus"></i>
                </div>
                Đăng ký</a>
            </li>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/info-account/view" />">
                    ${pageContext.session.getAttribute("currentUser").firstName}
                    ${pageContext.session.getAttribute("currentUser").lastName}
                    <div style="text-align:center">
                        <c:if test="${currentUser.avatar != null}">
                            <img style="width: 30px;" src="${currentUser.avatar}" class="rounded-circle" />
                        </c:if>
                        <c:if test="${currentUser.avatar == null}">
                             &#128119;

                        </c:if>
                        <span class="badge badge-secondary">${currentUser.userRole}</span>
                    </div>
                    (<sec:authentication property="principal.username" />)

                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link " href="<c:url value="/logout" />">
                <div style="text-align:center">
                  <i class="fa fa-sign-out"></i>
                </div>
                Đăng xuất</a>
            </li>
        </sec:authorize>
      </ul>
      <!-- Right links -->


    </div>
    <!-- Collapsible wrapper -->
  </div>
  <!-- Container wrapper -->
</nav>
<!-- Navbar -->


<section class="sidebar">
    <ul>
        <li><a href="/SpringAppFood/">
                <i class="fa fa-home" ></i>
            </a></li>
        <sec:authorize access="hasRole('ROLE_KH')">
        <li><a href="cart">
                <i class="fa fa-shopping-cart"></i>
            </a></li>
        </sec:authorize>
        <li><a href="#">
                <i class="fa fa-phone"></i>
            </a></li>
        <li><a id="gototop" href="javascript:;">
                <i class="fa fa-arrow-up"></i>
            </a></li>
    </ul>
</section>
