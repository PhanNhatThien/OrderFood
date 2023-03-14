<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">THỐNG KÊ BÀI VIẾT THEO NGÀY ĐĂNG</h1>
</div>

<div class="container">
    <div class="row">
        <div class="col">
            <table class="table table-striped text-center mt-5">
                <thead>
                <tr>
                    <th scope="col">Tháng</th>
                    <th scope="col">Số lượng bài đã đăng</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productStats}" var="stat">
                    <tr>
                        <th scope="row">
                            <fmt:formatDate pattern="MM/yyyy" value="${stat[0]}"/>
                        </th>
                        <td>${stat[1]}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-info" onClick="refreshPage()">Tải lại bảng thống kê</button>
        </div>
        <div class="col mt-5">
            <canvas id="myUserRoleChart"></canvas>
        </div>
    </div>
</div>
<script src="<c:url value="/js/userStats.js" />"></script>
<script>
    let userRoleLabels = [], userRoleInfos = []
    <c:forEach items="${productStats}" var="stat">
    userRoleLabels.push('${stat[0]}')
    userRoleInfos.push('${stat[1]}')
    </c:forEach>
    window.onload = function () {
        userRoleChart("myUserRoleChart", userRoleLabels, userRoleInfos)
    }
</script>