<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h1 class="text-center dark-color">TRANG QUẢN LÝ SẢN PHẨM</h1>
<div class="container">
<section class="d-flex justify-content-center">
        <form class="mt-3 w-50">
            <div style="display:flex">
                <div class="form-group">
                    <label for="name">Tên</label>
                    <input class="form-control" name="name" id="name" value="${name}">
                </div>

                <div class="form-group">
                    <label for="description">Mô tả </label>
                    <input class="form-control" name="description" id="description" value="${description}">
                </div>

            </div>
            <div style="display:flex">
                <button type="submit" class="btn btn-info">Tra cứu</button>
                <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
            </div>
        </form>
    </section>
</div>


<c:if test="${products.size() == 0}">
    <div class="alert alert-danger mt-4 d-flex justify-content-center align-items-center" style="height: 80px"
         role="alert">
        <h5>Không có dữ liệu về bài viết!</h5>
    </div>
</c:if>

<c:if test="${jobPosts.size() != 0}">
<table class="table table-striped mt-5">
    <thead>
        <tr>
            <th class="text-center" style="width: 15%">Thực thi</th>

            <th>Tên </th>
            <th>Mô tả</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach items="${products}" var="p" varStatus="loop">
        <tr>
            <td style="text-align: center">
                <a style="margin-right: 10px" href="<c:url value="/restaurant/post/view" />?id=${p.id}"
                   title="Xem chi tiết">
                    <i class="fa-solid fa-eye"></i>
                </a>
                <a style="margin-right: 10px" href="<c:url value="/restaurant/post/add-or-update" />?id=${p.id}"
                   title="Sửa">
                    <i class="fa-solid fa-pen"></i>
                </a>
                <a style="margin-right: 10px" href="<c:url value="/restaurant/post/delete" />?id=${p.id}"
                   class="confirmation" title="Xoá">
                    <i class="fa-solid fa-trash"></i>
                </a>
            </td>
            <td> ${p.name} </td>
            <td> ${p.description} </td>
        </tr>
    </c:forEach>
</tbody>
</table>
</div>

<ul class="pagination d-flex justify-content-center mt-2 mx-auto">
    <c:forEach begin="1" end="${Math.ceil(counter/maxItems)}" var="page">
        <li class="page-item">
            <a class="page-link" href="${url}?page=${page}">${page}</a>
        </li>
    </c:forEach>
</ul>



</c:if>

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