<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="description" content="Eden Travel Template">
  <meta name="author" content="Themefisher.com">
  
  <title></title>
  

  
  <!-- Mobile Specific Meta-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- bootstrap.min css -->
  <link rel="stylesheet" href="/resources/plugins/bootstrap/css/bootstrap.min.css">
  <!-- Ionic Icon Css -->
  <link rel="stylesheet" href="/resources/plugins/Ionicons/css/ionicons.min.css">
  <!-- Flaticon Css -->
  <link rel="stylesheet" href="/resources/plugins/flaticon/font/flaticon.css">
  <!-- animate.css -->
  <link rel="stylesheet" href="/resources/plugins/animate-css/animate.css">
  <link rel="stylesheet" href="/resources/plugins/nice-select/nice-select.css">
  <!-- DATE PICKER -->
  <link href="/resources/plugins/bootstrap-datepicker-master/bootstrap-datepicker.min.css" type="text/css" rel="stylesheet" />
  <!-- Magnify Popup -->
  <link rel="stylesheet" href="/resources/plugins/magnific-popup/dist/magnific-popup.css">
  <!-- Owl Carousel CSS -->
  <link rel="stylesheet" href="/resources/plugins/slick-carousel/slick/slick.css">
  <link rel="stylesheet" href="/resources/plugins/slick-carousel/slick/slick-theme.css">

  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css">
  
  
  




  
  <!-- HOTEL CSS 시작 -->
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="/resources/css/style.css">
 
  <!-- Kakao 톡상담 -->
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
  
  <!-- 이미지 슬라이드 -->
  <link rel="stylesheet" type="text/css" href="/resources/css/glider.css" />
  <link rel="stylesheet" type="text/css" href="/resources/css/glider.min.css" />
  
  <!-- hotelwebtemplate -->
  <link href="https://fonts.googleapis.com/css?family=Gothic+A1:100|Noto+Serif+KR:200&display=swap&subset=korean" rel="stylesheet">
    <!-- HOTEL CSS 끝 -->
 
 
 <!-- 분산 css시작 -->
  <!-- Bootstrap core CSS-->
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> 

	<!-- 이거 아래 두개만 있어도 됨 -->
  <!-- Page level plugin CSS-->
  <link href="/resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <!-- 이 아래꺼가 있으니까 안됐음 -->
  <link href="/resources/css/sb-admin.css" rel="stylesheet"> 
  
  <!-- 분산CSS끝 -->
 
 
  <style type="text/css">
      *:not(i) {
          box-sizing: border-box;
          font-family: 'Noto Serif KR', serif!important;
      }
      html, body {
          width: 100%;
         
      }
      .glider-contain {	
          width: 90%;
          max-width: none;
          margin: 0 auto;
      }
      .glider-slide {
          min-height: 150px;
      }
      .glider-slide img {
          width: 100%;
      }
  </style>


<script type="text/javascript">

<%-- //새로고침X
$(document).ready(function(){
	
	$("#btnOK").click(function(){
		
		var params = "checkIt=" + $("#checkIt").val();
		
		$.ajax({
			
			type:"POST",  
			url:"<%=cp%>/room-list.action", 
			data:params,
			success:function(args){
				
				$("#listData").html(args);
				
			},
			beforeSend:showRequest, 
			error:function(e) {
				
				alert(e.responseText); 
			}
		});
		
	});
	
}); --%>

	
<%-- 	function sendIt(){
			
		f = document.listSave;
		
		str = f.checkIt.value;
		if(!str){
			alert("\n저장할 오픈소스를 선택하세요.");
			f.checkin.focus();
			return;
		}
		f.checkIt.value = str;		
		
		f.action = "<%=cp %>/hotelSearch.action";
		f.submit();
	} --%>
</script>


</head>

<body>


<!-- Header Start -->

<header class="navigation">
<div class="top-header py-2">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-lg-8">
				<div class="top-header-left text-muted">
					<b>OpenSource</b>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="currentDate" style="font-size:12px;"></span>
					<span style="font-size:12px;">서울특별시</span>
					<span id="icon"></span>
					<span id="todayTemp" style="font-size:12px;"></span>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="top-header-right float-right">
					<ul class="list-unstyled mb-0">
						<li class="top-contact">
							
							<c:choose>
								<c:when test="${empty sessionScope.login.userId }">
									<span class="text-color">
										<a href="login.action">로그인</a> / 
										<a href="signup.action">회원가입</a>
									</span>
								</c:when>
							
								<c:otherwise>
									<span class="text-color">${sessionScope.login.userName }님 안녕하세요
									</span>
										<a href="logout.action">&nbsp;&nbsp;로그아웃</a> / 
										
										<c:if test="${sessionScope.login.userId ne 'admin'}">
											<a href="myPage.action">마이페이지</a>
										</c:if>
										
										<c:if test="${sessionScope.login.userId eq 'admin'}">
											<a href="admin.action">관리자</a>
										</c:if>
										
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="image_container" style="display: none;">
<!-- TEST -->
<p>테스트</p>
</div>


	<nav class="navbar navbar-expand-lg bg-white w-100 p-0" id="navbar">
		<div class="container">
		<!--   <a class="navbar-brand" href="/hotel" ><img src="/hotel/resources/images/logo.png" alt="Eden" class="img-fluid" ></a> -->
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
			<span class="fa fa-bars"></span>
		  </button>
	  
		  <div class="collapse navbar-collapse" id="navbarsExample09">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active">
				<a class="nav-link" href="/">All List <span class="sr-only">(current)</span></a>
			  </li>
			  
				  <li class="nav-item active">
				<a class="nav-link" href="myInfo.action">My Info <span class="sr-only">(current)</span></a>
			  </li>
			  
<!-- 			  <li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Board</a>
 				<ul class="dropdown-menu" aria-labelledby="dropdown02">
				  <li><a class="dropdown-item" href="about.action">Board</a></li>
				  <li><a class="dropdown-item" href="service.action">Contact us</a></li>
				  <li><a class="dropdown-item" href="gallery.action">My Info</a></li>
				</ul> 
			  </li>
			  
			  <li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Contact Us</a>
			  </li>
 -->
			  
			  
			  
			</ul>
			<form class="form-inline my-2 my-md-0 ml-lg-4">
<!-- 			  <a href="booking-step1.action" class="btn btn-main">검색할 오픈소스</a> -->
			</form>
		  </div>
		</div>
	</nav>
</header>

<!-- Header Close --> 



	<!-- 여기 -->
<!-- <form name="listSave" action="" class="reserve-form" method="post">	 -->
	      <!-- DataTables Example -->
<div class="container">
	<div class="row">
		        <div class="col-md-12">	
		   
      <div class="card mb-3">
        <div class="card-header">
          <i class="fas fa-table"></i>
         취약점이 발견된 오픈소스 Top50</div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
              <tr>
                <th>product_id</th>
                <th>product_name</th>
                <th>vulnerability_number</th>
              </tr>
              </thead>
              <tfoot>
              <tr>
                <th>product_id</th>
                <th>product_name</th>
                <th>vulnerability_number</th>
              </tr>
              </tfoot>
              
              
              <!-- productList 시작 -->
             <tbody>              
            <c:forEach var="dto" items="${lists }">
              <tr>
                <td>${dto.product_id }</td>  
                           	
             		<td><a href="details.action?product_id=${dto.product_id}">  
             		 ${dto.product_name }</a></td>
             		 
                <td>${dto.vulnerability_number }</td>
              </tr>
 		   </c:forEach>
              </tbody>
              <!-- productList 끝 -->
              
            </table>
          </div>
        </div>
        
<!--         				    <div class="form-group col-md-2">
				      <input type="button" value="저장하기" 
				      class="btn btn-main btn-block" id="btnOK">				   
				    </div> -->
        
        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
      </div>
      </div>
      </div>
      </div>
<!-- </form> -->

   

    <!-- 
    Essential Scripts
    =====================================-->

    
    <!-- Main jQuery -->
    <script src="/resources/plugins/jquery/jquery.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Owl Carousel -->
    <script src="/resources/plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="/resources/plugins/nice-select/nice-select.js"></script>
    <!--  -->
    <script src="/resources/plugins/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
    <!-- Form Validator -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.32/jquery.form.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.min.js"></script>
    <script src="/resources/plugins/bootstrap-datepicker-master/bootstrap-datepicker.min.js"></script>
    
    <!-- Google Map -->
    <script src="/resources/plugins/google-map/map.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkeLMlsiwzp6b3Gnaxd86lvakimwGA6UA&amp;callback=initMap"></script>    

    <script src="/resources/js/script.js"></script>
    <script src="/resources/js/weather.js"></script>
    
<!--     <script type="text/javascript">
    Morris.Donut({
    	  element: 'donut-example',
    	  data: [
    	    {label: "Download Sales", value: 12},
    	    {label: "In-Store Sales", value: 30},
    	    {label: "Mail-Order Sales", value: 20}
    	  ]
    	});
    </script>
    
    <script type="text/javascript">
    Morris.Bar({
  	  element: 'bar-example',
  	  data: [
  	    { y: '2015', a: 100, b: 90 },
  	    { y: '2016', a: 75,  b: 65 },
  	    { y: '2017', a: 50,  b: 40 },
  	    { y: '2018', a: 75,  b: 65 },
  	    { y: '2019', a: 50,  b: 40 }
  	  ],
  	  xkey: 'y',
  	  ykeys: ['a', 'b'],
  	  labels: ['Series A', 'Series B']
  	});
    </script> -->

    
    <!-- 분산 JS 시작 -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
    
<script src="/resources/vendor/datatables/jquery.dataTables.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap4.js"></script>

<script src="/resources/js/sb-admin.min.js"></script>

<script src="/resources/js/demo/datatables-demo.js"></script>
	 <!-- 분산 JS 끝 -->
	 
	     
    <!-- 날씨정보 -->
	<script src="/resources/js/weather.js"></script>
	
	
	
  </body>
  </html>
   