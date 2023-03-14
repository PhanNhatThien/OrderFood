<%-- 
    Document   : index
    Created on : 15 Aug 2022, 13:22:02
    Author     : thien thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
<div class="logo-move-head">
    <h5 style="margin:0px" class="fw-bold fs-3 fs-lg-5 lh-sm text-center ">Chào mừng bạn đến với Website AppFood</h5>
</div>
<section>
    <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="<c:url value="/resources/images/banner1.jpg" />" class="d-block w-100">
        </div>
        <div class="carousel-item">
          <img src="<c:url value="/resources/images/banner2.jpg" />" class="d-block w-100">
        </div>
        <div class="carousel-item">
          <img src="<c:url value="/resources/images/banner3.jpg" />" class="d-block w-100">
        </div>
        <div class="carousel-item">
          <img src="<c:url value="/resources/images/banner4.jpg" />" class="d-block w-100">
        </div>
        <div class="carousel-item">
          <img src="<c:url value="/resources/images/banner5.jpg" />" class="d-block w-100">
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
</section>


<div class="container">
    <div class="row">
        <div class="splide">
            <div class="splide__track">
                <div class="splide__list">
                      <c:forEach items="${products}" var="p">
                          <div class="col-md-3 col-xs-12 col-sm-4 splide__slide m-2" >
                              <div class="card">
                                  <img src="<c:url value="${p.image}"/>"
                                       class="card-img-top" id="blah" alt="avatar">
                                  <div class="card-body">
                                      <h6 class="card-title">${p.name}</h6>
                                      <p class="card-text">
                                          <fmt:formatNumber value="${p.price}" maxFractionDigits="3" type = "number" /> VND
                                      </p>
                                      <div class="detail-buy">
                                          <div class="bt-buy">
                                              <div>
                                                  <a href="<c:url value="/products/${p.id}" />" >
                                                      <input type="button" value="Xem chi tiết"/>
                                                  </a>
                                              </div>
                                              <div>
                                                  <a href="#" onclick="addToCart(${p.id}, '${p.name}', ${p.price})">
                                                      <input type="button" value="Thêm vào giỏ"/>
                                                  </a>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row" style="margin-top:5%;margin-bottom:5%">
    <div class="row h-100">
        <div class="col-lg-7 mx-auto text-center mb-6">
          <h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-3">Top các sản phẩm bán chạy</h5>
        </div>
    </div>
    <c:forEach items="${products}" var="p">
        <div class="col-md-3 col-xs-12 " style="padding:10px;">
            <div class="card">

                <div style="width:100%;"  class="col text-center">
                    <img src="<c:url value="${p.image}"/>"
                          margin-top: 10px;"
                         class="card-img-top" id="blah" alt="avatar">
                </div>
                <div class="card-body">
                    <h5 class="card-title">${p.name}</h5>
                    <p class="card-text">
                        <fmt:formatNumber value="${p.price}" maxFractionDigits="3" type = "number" /> VND
                    </p>
                    <a href="<c:url value="/products/${p.id}" />" class="btn btn-primary" style="background-color:#f7682d;border:none">Xem</a>
                    <a style="background-color:#1dab8a; border:none" href="#" class="btn btn-primary" onclick="addToCart(${p.id}, '${p.name}', ${p.price})">Thêm giỏ</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<c:if test="${products.size() == 0}">
    <p>
        <strong>Không có sản phẩm nào!!!</strong>
    </p>
</c:if>


<div class="container" style="margin-top:5%;margin-bottom:5%">
	<div class="row">
		<div class="MultiCarousel"  data-items="1,3,5,6" data-slide="1" id="MultiCarousel"  data-interval="1000">
            <div style="padding-bottom:10px" class="col-lg-7 mx-auto text-center mb-6">
              <h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-3">Top những cửa hàng ngon nhất</h5>
            </div>
            <div class="MultiCarousel-inner">
                <div  style='display:flex'>
                    <c:forEach items="${users}" var="p">
                        <div style="margin:10px" class="item card card-span h-100 rounded-circle">
                            <img class="img-fluid rounded-circle h-100" src="<c:url value="${p.avatar}"/>"
                                 class="card-img-top" id="blah" alt="avatar">
                        </div>
                    </c:forEach>
                </div>
            </div>
            <button style="margin-top:-100px; margin-left:950px"  class="btn btn-primary leftLst"><</button>
            <button style="margin-top:-100px;" class="btn btn-primary rightLst">></button>
        </div>
	</div>
	<div class="row">
	    <div class="col-md-12 text-center">

	        <hr/>
	        <p>Top 1 Việt Nam</p>
	    </div>
	</div>
</div>

<section class="container" style="margin-top:5%;margin-bottom:5%">
    <div class="row h-100">
        <div class="col-lg-7 mx-auto text-center mb-6">
          <h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-3">Đối tác chiến lượt</h5>
        </div>
    </div>
    <div class="logo-move">
        <img src="<c:url value="/resources/images/move1.jpg" />">
        <img src="<c:url value="/resources/images/move2.png" />">
        <img src="<c:url value="/resources/images/move3.jpg" />">
        <img src="<c:url value="/resources/images/move4.jpg" />">
        <img src="<c:url value="/resources/images/move5.jpg" />">
        <img src="<c:url value="/resources/images/move6.jpg" />">
        <img src="<c:url value="/resources/images/move7.png" />">
        <img src="<c:url value="/resources/images/move8.jpg" />">
        <img src="<c:url value="/resources/images/move9.jpg" />">
        <img src="<c:url value="/resources/images/move10.jpg" />">
        <img src="<c:url value="/resources/images/move11.png" />">
    </div>
    <div class="row">
    	    <div class="col-md-12 text-center">

    	        <hr/>
    	        <p>AppFood tự hào là đơn vị phân phối chính hãng các thương hiệu nổi tiếng hàng đầu trên thế giới</p>
    	    </div>
    	</div>
</section>

<nav aria-label="Page navigation example" style="margin-top:5%;margin-bottom:5%">
    <ul class="pagination">
        <li class="page-item">
            <a class="page-link" href="${u} aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
        <c:forEach begin="1" end="${Math.ceil(productCounter/pageSize)}" var="i">
            <c:url value="/" var="u">
                <c:param name="page" value="${i}" />
            </c:url>
            <li class="page-item"><a class="page-link" href="${u}">${i}</a></li>
        </c:forEach>
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>

<script src="<c:url value="/resources/js/product.js" />"></script>
<script src="<c:url value="/resources/js/index.js" />"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@splidejs/splide@3.6.12/dist/js/splide.min.js"></script>

