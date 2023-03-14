<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="context" value="${pageContext.request.contextPath}"/>

<h1 class="text-center dark-color">QUẢN LÝ NGƯỜI DÙNG</h1>

<section class="d-flex justify-content-center">
    <form  class="mt-3 w-50">
        <div style="display:flex" >
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input class="form-control" name="username" id="username" value="${usernameSearch}">
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input class="form-control" name="phone" id="phone" value="${phoneSearch}">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input class="form-control" name="email" id="email" value="${emailSearch}">
            </div>
            <div class="form-group">
                <label for="userRole">Loại</label>
                <select name="userRole" id="userRole">
                    <option value="" selected>Không chọn</option>
                    <c:if test="${userRoleSearch.equals('ROLE_ADMIN')}">
                        <option value="ROLE_ADMIN" selected>Admin</option>
                    </c:if>
                    <c:if test="${!userRoleSearch.equals('ROLE_ADMIN')}">
                        <option value="ROLE_ADMIN">Admin</option>
                    </c:if>

                    <c:if test="${userRoleSearch.equals('ROLE_NH')}">
                        <option value="ROLE_NH" selected>Nhà hàng</option>
                    </c:if>
                    <c:if test="${!userRoleSearch.equals('ROLE_NH')}">
                        <option value="ROLE_NH">Nhà hàng</option>
                    </c:if>

                    <c:if test="${userRoleSearch.equals('ROLE_KH')}">
                        <option value="ROLE_KH" selected>Khách hàng</option>
                    </c:if>
                    <c:if test="${!userRoleSearch.equals('ROLE_KH')}">
                        <option value="ROLE_KH">Khách hàng</option>
                    </c:if>
                </select>
            </div>
        </div>
        <div >
            <button type="submit" style="width:128px; margin:0" class="btn btn-info">Tra cứu</button>
            <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
        </div>


    </form>
</section>
<c:if test="${users.size() == 0}">
    <div class="alert alert-danger mt-4 d-flex justify-content-center align-items-center" style="height: 80px"
         role="alert">
        <h5>KHÔNG CÓ DỮ LIỆU!</h5>
    </div>
</c:if>

<c:if test="${users.size() > 0}">
    <c:if test="${sucMsg != null}">
        <div class="alert alert-success" role="alert">
                ${sucMsg}
        </div>
    </c:if>

    <c:if test="${errMsg != null}">
        <div class="alert alert-danger" role="alert">
                ${errMsg}
        </div>
    </c:if>

    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link" href="<c:url value="/admin/account/add-or-update"/>">
                <i class="fa-solid fa-plus"></i>
                Thêm
            </a>
        </li>
    </ul>

    <table class="table table-striped">
        <thead>
        <tr>
            <th class="text-center" style="width: 15%">Thực thi</th>
            <th class="text-center" style="width: 5%">STT</th>
            <th>Tên đăng nhập</th>
            <th>Số điện thoại</th>
            <th>Email</th>
            <th>Loại tài khoản</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach items="${users}" var="u" varStatus="loop">
                <tr>
                    <td style="text-align: justify-all; padding-left: 50px">
                        <a style="margin-right: 10px" href="<c:url value="/admin/account/view" />?id=${u.id}"
                           title="Xem chi tiết">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                        <a style="margin-right: 10px" href="<c:url value="/admin/account/add-or-update" />?id=${u.id}"
                           data-toggle="tooltip" title="Sửa">
                            <i class="fa-solid fa-pen"></i>
                        </a>
                        <a style="margin-right: 10px"
                           href="<c:url value="/admin/account/delete" />?id=${u.id}" class="confirmation" title="Xoá">
                            <i class="fa-solid fa-trash"></i>
                        </a>

                    </td>
                    <td class="text-center">${(currentPage - 1) * userService.maxItemsInPage + loop.index + 1}</td>
                    <c:if test="${u.userRole.equals('ROLE_NH') && u.active == 0}">
                        <td style="color: red">[Chưa kích hoạt] ${u.username}</td>
                    </c:if>
                    <c:if test="${!(u.userRole.equals('ROLE_NH') && u.active == 0)}">
                        <td>${u.username}</td>
                    </c:if>
                    <td>${u.phone}</td>
                    <td>${u.email}</td>
                    <td>${u.userRole}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <ul class="pagination d-flex justify-content-center mt-4">
        <c:forEach begin="1" end="${Math.ceil(counter/userService.maxItemsInPage)}" var="i">
            <c:url value="/admin/account" var="u">
                <c:param name="page" value="${i}" />
            </c:url>
            <li class="page-item"><a class="page-link" href="${u}">${i}</a></li>
        </c:forEach>
    </ul>

</c:if>
<script src="<c:url value="/resources/js/index.js" />"></script>
<script>
    $(document).ready(function () {
        $("form").submit(function () {
            $("input, select").each(function (index, obj) {
                if ($(obj).val() === "" || $(obj).val() === "-1") {
                    $(obj).remove();
                }
            });
        });
    });
</script>