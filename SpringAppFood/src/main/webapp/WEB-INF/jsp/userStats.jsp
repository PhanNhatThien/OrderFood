<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-6 col-xs-12">
        <table class="table">
            <tr>
                <th>Id</th>
                <th>Tên nhà hàng</th>
                <th>Tổng số sản phẩm </th>
            </tr>
            <c:forEach items="${usersStats}" var="c">
                <tr>
                    <td>${c[0]}</td>
                    <td>${c[1]}</td>
                    <td>${c[2]}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="col-md-6 col-xs-12">
        <canvas id="myChart3"></canvas>
    </div>
</div>
<script src="<c:url value="/js/userStats.js" />"></script>
<script>
    window.onload = function () {

        let data3 = [];
        let labels3 = [];


        <c:forEach items="${usersStats}" var="c">
        data3.push(${c[2]});
        labels3.push('$${c[1]}');
        </c:forEach>
        
        uStats(labels3, data3);

    }
</script>  