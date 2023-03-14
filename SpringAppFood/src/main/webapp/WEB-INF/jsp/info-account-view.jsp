<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>


<div class="container">
    <h1 class="text-center dark-color" style="padding: 0 30px">THÔNG TIN TÀI KHOẢN</h1>

    <section class="section about-section gray-bg" id="about">
        <div class="container m-0">
            <div class="row flex-row-reverse">
                <div class="col-lg-6">
                    <div class="about-text go-to">
                        <h3 class="dark-color mb-4">
                            ${currentUser.username}
                        </h3>
                        <div class="row mb-2">
                            <div class="col-md-5">
                                <h5>Tên</h5>
                            </div>
                            <div class="col-md-7">
                                <p>${currentUser.firstName}</p>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-5">
                                <h5>Họ</h5>
                            </div>
                            <div class="col-md-7">
                                <p>${currentUser.lastName}</p>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-5">
                                <h5>Email</h5>
                            </div>
                            <div class="col-md-7">
                                <p>${currentUser.email}</p>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-5">
                                <h5>Số điện thoại</h5>
                            </div>
                            <div class="col-md-7">
                                <p>${currentUser.phone}</p>
                            </div>
                        </div>

                        <div class="row mb-2">
                            <div class="col-md-5">
                                <h5>Kích hoạt</h5>
                            </div>
                            <div class="col-md-7">
                                <c:choose>
                                    <c:when test="${currentUser.active == 0}">
                                        <p>Chưa kích hoạt </p>
                                    </c:when>
                                    <c:when test="${currentUser.active == 1}">
                                        <p>Đã kích hoạt</p>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-5">
                                <h5>Loại tài khoản</h5>
                            </div>
                            <div class="col-md-7">
                                <c:choose>
                                    <c:when test="${currentUser.userRole.equals('ROLE_NH')}">
                                        <p>Nhà hàng</p>
                                    </c:when>
                                    <c:when test="${currentUser.userRole.equals('ROLE_KH')}">
                                        <p>Khách hàng</p>
                                    </c:when>
                                    <c:when test="${currentUser.userRole.equals('ROLE_ADMIN')}">
                                        <p>Admin</p>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                        <c:if test="${currentUser.userRole.equals('ROLE_NH')}">
                            <div class="row mb-2">
                                <div class="col-md-5">
                                    <h5>Tên nhà hàng</h5>
                                </div>
                                <div class="col-md-7">
                                    <p>${restaurant.name}</p>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-md-5">
                                    <h5>Mô tả</h5>
                                </div>
                                <div class="col-md-7">
                                    <p>${restaurant.description}</p>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-md-5">
                                    <h5>Địa điểm</h5>
                                </div>
                                <div class="col-md-7">
                                    <p>${restaurant.location}</p>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-md-5">
                                    <h5>Liên hệ</h5>
                                </div>
                                <div class="col-md-7">
                                    <p>${restaurant.contact}</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-avatar d-flex justify-content-center">
                        <c:if test="${currentUser.avatar.startsWith('https')}">
                            <img src="<c:url value="${currentUser.avatar}"/>"
                                 class="rounded">
                        </c:if>
                        <c:if test="${!currentUser.avatar.startsWith('https')}">
                            <img src="<c:url value="/resources/images/fb.png"/>"
                                 class="rounded">
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<ul class="nav nav-tabs">
    <li class="nav-item">
        <a class="nav-link" href="<c:url value="/restaurant/restaurant-info/add-or-update" />">
        <i class="fa-solid fa-plus"></i>Chỉnh sửa thông tin</a>
    </li>
</ul>

<style>
    .gray-bg {
        background-color: #f5f5f5;
    }
    img {
        max-width: 90%;
    }
    img {
        vertical-align: middle;
        border-style: none;
    }
    /* About Me
    ---------------------*/
    .about-text h3 {
        font-size: 45px;
        font-weight: 700;
        margin: 0 0 6px;
    }
    @media (max-width: 767px) {
        .about-text h3 {
            font-size: 35px;
        }
    }
    .about-text h6 {
        font-weight: 600;
        margin-bottom: 15px;
    }
    @media (max-width: 767px) {
        .about-text h6 {
            font-size: 18px;
        }
    }
    .about-text p {
        font-size: 18px;
        max-width: 450px;
    }
    .about-text p mark {
        font-weight: 600;
        color: #20247b;
    }
    .about-list {
        padding-top: 10px;
    }
    .about-list .media {
        padding: 5px 0;
    }
    .about-list label {
        color: #20247b;
        font-weight: 600;
        width: 88px;
        margin: 0;
        position: relative;
    }
    .about-list label:after {
        content: "";
        position: absolute;
        top: 0;
        bottom: 0;
        right: 11px;
        width: 1px;
        height: 12px;
        background: #20247b;
        -moz-transform: rotate(15deg);
        -o-transform: rotate(15deg);
        -ms-transform: rotate(15deg);
        -webkit-transform: rotate(15deg);
        transform: rotate(15deg);
        margin: auto;
        opacity: 0.5;
    }
    .about-list p {
        margin: 0;
        font-size: 15px;
    }
    @media (max-width: 991px) {
        .about-avatar {
            margin-top: 30px;
        }
    }
    .about-section .counter {
        margin-top: 30px;
        padding: 22px 20px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 0 30px rgba(31, 45, 61, 0.125);
    }
    .about-section .counter .count-data {
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .about-section .counter .count {
        font-weight: 700;
        color: #20247b;
        margin: 0 0 5px;
    }
    .about-section .counter p {
        font-weight: 600;
        margin: 0;
    }
    mark {
        background-image: linear-gradient(rgba(252, 83, 86, 0.6), rgba(252, 83, 86, 0.6));
        background-size: 100% 3px;
        background-repeat: no-repeat;
        background-position: 0 bottom;
        background-color: transparent;
        padding: 0;
        color: currentColor;
    }
    .theme-color {
        color: #fc5356;
    }
    .dark-color {
        color: #20247b;
    }
</style>