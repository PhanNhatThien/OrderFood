<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
    <c:if test="${product.id == 0}">
        <h1 class="text-center dark-color">THÊM SẢN PHẨM</h1>
    </c:if>
    <c:if test="${product.id > 0}">
        <h1 class="text-center dark-color">CHỈNH SỬA THÔNG TIN SẢN PHẨM [${product.name}]</h1>
    </c:if>

    <c:url value="/admin/product-post/add-or-update" var="action"/>

    <form:form action="${action}" method="post" enctype="multipart/form-data" modelAttribute="product">
        <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
        <form:hidden path="id"/>
        <div class="form-group">
            <label>Tên</label>
            <form:input path="name" class="form-control" autofocus="autofocus"/>
        </div>
        <div class="form-group">
            <label>Mô tả</label>
            <form:textarea path="description" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Giá</label>
            <form:input id="price" path="price" class="form-control"/>
        </div>

        <div class="form-group">
            <label>Nhà hàng</label>
            <form:select path="postedByUserId" class="custom-select">
                <c:forEach items="${users}" var="user">
                    <c:if test="${user.id == product.postedByUser.id}">
                        <option value="${user.id}" selected>
                                - ${user.username}
                        </option>
                    </c:if>

                    <c:if test="${user.id != product.postedByUser.id}">
                        <option value="${user.id}">
                                 - ${user.username}
                        </option>
                    </c:if>
                </c:forEach>
            </form:select>
        </div>
        <div class="form-group">
            <label>Loại</label>
            <form:select path="categoryById" class="custom-select">
                <c:forEach items="${categories}" var="categoryId">
                    <c:if test="${categoryId.id == product.categoryId.id}">
                        <option value="${categoryId.id}" selected>${categoryId.name}</option>
                    </c:if>

                    <c:if test="${categoryId.id != product.categoryId.id}">
                        <option value="${categoryId.id}">${categoryId.name}</option>
                    </c:if>
                </c:forEach>
            </form:select>
        </div>
        <div class="form-group row">
            <div class="col">
                <label for="image">Ảnh</label>
                <form:input type="file" id="imgInp" path="file"
                            accept="image/*" class="form-control"/>
            </div>
            <c:if test="${product.id > 0}">
                <div class="col text-center">
                    <img src="<c:url value="${product.image}"/>"
                         style="height: 200px; margin-top: 10px; border: 1px solid black;"
                         class="img-fluid rounded" id="blah" alt="avatar">
                </div>
            </c:if>
        </div>
        <div class="form-group">
            <label>Kích hoạt <span style="color: red">*</span></label>
            <form:select path="active" class="custom-select">
                <form:option value="false" label="Chưa kích hoạt" selected="${product.active == false ? true : ''}"/>
                <form:option value="true" label="Đã kích hoạt" selected="${product.active == true ? true : ''}"/>
            </form:select>
        </div>

        <div class="form-group">
            <c:if test="${product.id == 0}">
                <button type="submit" name="submit" value="submit" class="btn btn-primary">Thêm</button>
            </c:if>
            <c:if test="${product.id > 0}">
                <button type="submit" name="submit" value="submit" class="btn btn-primary">Cập nhật</button>
            </c:if>
        </div>
    </form:form>
</div>