<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">THÔNG TIN SẢN PHẨM</h1>

    <div class="container mt-3">
        <table class="table table-striped">
            <tbody>
            <tr>
                <th style="width: 30%" scope="row">Ảnh</th>
                <td class="border-left">
                    <c:if test="${product.image.length() != null}">
                        <img src="<c:url value="${product.image}"/>" style="height: 100px"
                             class="img-fluid rounded" alt="image">
                    </c:if>
                    <c:if test="${product.image.length() == null}">
                        Không có ảnh
                    </c:if>
                </td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">ID</th>
                <td class="border-left">${product.id}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Tên</th>
                <td class="border-left">${product.name}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Mô tả</th>
                <td class="border-left">${product.description}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">gía</th>
                <td class="border-left">${product.price}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Ngày đăng</th>
                <td class="border-left">
                    <fmt:formatDate pattern=" dd/MM/yyyy" value="${product.createdDate}"/>
                </td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Loại</th>
                <td class="border-left">${categoryService.getById(product.categoryId.id).name}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Tài khoản đăng bài</th>
                <td class="border-left">${userService.getUserById(product.postedByUser.id).username}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Nhà hàng</th>
                <td class="border-left">${restaurantService.getByUserId(product.postedByUser.id).name}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<style>
    @media (min-width: 0) {
        .g-mr-15 {
            margin-right: 15px !important;
        }
    }
    @media (min-width: 0) {
        .g-mt-3 {
            margin-top: 10px !important;
        }
    }
    .g-height-50 {
        height: 50px;
    }
    .g-width-50 {
        width: 50px !important;
    }
    @media (min-width: 0) {
        .g-pa-30 {
            padding: 20px !important;
        }
    }
    .g-bg-secondary {
        background-color: #fafafa !important;
    }
    .u-shadow-v18 {
        box-shadow: 0 5px 10px -6px rgba(0, 0, 0, 0.15);
    }
    .g-color-gray-dark-v4 {
        color: #777 !important;
    }
    .g-font-size-12 {
        font-size: 0.85714rem !important;
    }
    .media-comment {
        margin-top: 20px
    }
</style>