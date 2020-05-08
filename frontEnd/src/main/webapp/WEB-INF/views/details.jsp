<%@page import="java.util.Iterator"%>
<%@page import="com.exe.dto.DetailsDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	
	List<DetailsDTO> lists2 = (List<DetailsDTO>)request.getAttribute("lists2");
	int[] cnt = (int[])request.getAttribute("cnt");
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
  
  <!-- font -->
  <link href="https://fonts.googleapis.com/css?family=Gothic+A1:100|Noto+Serif+KR:200&display=swap&subset=korean" rel="stylesheet">

  <!-- Kakao 톡상담 -->
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
  
  <!-- 이미지 슬라이드 -->
  <link rel="stylesheet" type="text/css" href="/resources/css/glider.css" />
  <link rel="stylesheet" type="text/css" href="/resources/css/glider.min.css" />
  
  <!-- hotelwebtemplate -->
  <link href="https://fonts.googleapis.com/css?family=Gothic+A1:100|Noto+Serif+KR:200&display=swap&subset=korean" rel="stylesheet">
 
   <!-- HOTEL CSS 끝 -->
 
 <!-- 원형/막대 그래프 jquery -->
 <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
 
 <!-- 분산 css시작 -->
  <!-- Bootstrap core CSS-->
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template-->
<!--   <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> -->

	<!-- 이거 아래 두개만 있어도 됨 -->
  <!-- Page level plugin CSS-->
  <link href="/resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <!-- 이 아래꺼가 있으니까 안됐음 -->
  <!-- <link href="/resources/css/sb-admin.css" rel="stylesheet"> -->
  
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

document.getElementById("donut-example").style.backgroundColor = "#000000"; 


//새로고침X
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
	
});

	
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
			  
			  
			  
			</ul>
			<form class="form-inline my-2 my-md-0 ml-lg-4">
<!-- 			  <a href="booking-step1.action" class="btn btn-main">검색할 오픈소스</a> -->
			</form>
		  </div>
		</div>
	</nav>
</header>

<!-- Header Close --> 






<div id="bar-example" style="height: 250px;"></div>
<div id="donut-example"></div>


	<!-- 여기 -->
<form name="listSave" action="" class="reserve-form" method="post">	
	      <!-- DataTables Example -->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fas fa-table"></i>
          현재 취약점 보기</div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
              <tr>
                <th>cve_id</th>
                <th>vulnerability_type</th>
                <th>publish_date</th>
                <th>vulnerability_score</th>
              </tr>
              </thead>
              <tfoot>
              <tr>
                <th>cve_id</th>
                <th>vulnerability_type</th>
                <th>publish_date</th>
                <th>vulnerability_score</th>
              </tr>
              </tfoot>
              
              
              <!-- DetailsList 시작 -->
             <tbody>              
            <c:forEach var="dto" items="${lists }">
              <tr>

                <td><a href="final_details.action?cve_id=${dto.cve_id} ">   ${dto.cve_id }
                </a></td>

             	<td>${dto.vulnerability_type }</td>
                <td>${dto.publish_date }</td>
                <td>${dto.vulnerability_score }</td>
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
</form>

<!-- div container 없앴음 -->   
   

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
	
    <!-- Kakao 톡상담 -->
	<script type='text/javascript'>
	
	//<![CDATA[
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('a876d408c7cc2ab22428d910b1de57af');
		// 카카오톡 채널 1:1채팅 버튼을 생성합니다.
		Kakao.Channel.createChatButton({
			container: '#kakao-talk-channel-chat-button',
			channelPublicId: '_rRxdxgT' // 카카오톡 채널 홈 URL에 명시된 id로 설정합니다.
		});
	//]]>
	
	</script>
	
    <script src="/resources/js/weather.js"></script>
    
    <script type="text/javascript">
    Morris.Donut({
    	  element: 'donut-example',
    	  data: [
    	    {label: "LOW", value: <%=cnt[2]%>},
    	    {label: "MEDIUM", value: <%=cnt[1]%>},
    	    {label: "HIGH", value: <%=cnt[0]%>}
    	  ]
    	});
    </script>
     
    
    <script type="text/javascript">
    Morris.Bar({
    	  element: 'bar-example',
    	  data: [    		  
    		 <% 
 			Iterator<DetailsDTO> it = lists2.iterator();
 			int i=0;
 			while(it.hasNext()) {
 	
 				DetailsDTO dto = it.next();
 				if (!it.hasNext()) {  %>
 				
 				 { y: <%=dto.getPublish_date()%>, a: <%=dto.getCount()%> }
 				<%
 				break;
 				}
 				%>
 		   	    { y: <%=dto.getPublish_date()%>, a: <%=dto.getCount()%> },
 				<%
 				i++;		}    		 
    		 %>
    	  ],    	 
    	  xkey: 'y',
    	  ykeys: ['a'],
    	  labels: ['Series A']
    	});
    </script>

   <!--  <script type="text/javascript">
    window.onload = function () { 
    	startLoadFile(); 
   	}; 
    	
    	function startLoadFile(){ 
    		$.ajax({ 
    			url: 'indexImage', 
    			type: 'GET', 
    			dataType : 'json', 
    			success : function (data) { 
    				createImages(data) 
    				} 
    		}); 
   		} 
    	// JSON 포멧 데이터 처리 
    	function createImages(objImageInfo) { 
    		var images = objImageInfo.images; 
    		var strDOM = "";
    		
    		for (var i = 0; i < images.length; i++) { 
    			// N번째 이미지 정보를 구하기 
    			var image = images[i]; 
    			// N번째 이미지 패널을 생성 
    			strDOM += '<div class="image_panel">';
    			strDOM += '<img src="' + image.url + '" class="img-fluid" onclick="'+'location.href="gym"'+';">'; 
    			strDOM += '</div>';
    			
   			} 
    		 
    		// 이미지 컨테이너에 생성한 이미지 패널들을 추가하기 
    		var $imageContainer = $("#image_container"); 
    		$imageContainer.append(strDOM); 
   		}
    	$(document).ready(function(){
    		setInterval(function(){
    			$("#testSlide").append($('.image_panel').first());
    			$('.image_panel').last().hide();
    			$('.image_panel').first().show();
    		}, 2000);
    	});
    	

    </script> -->
    
    
    <!-- 분산 JS 시작 -->
    <!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
    
    <!-- Page level plugin JavaScript-->
<script src="/resources/vendor/datatables/jquery.dataTables.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap4.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin.min.js"></script>

<!-- Demo scripts for this page-->
<script src="/resources/js/demo/datatables-demo.js"></script>

	 <!-- 분산 JS 끝 -->
	 
	     
    <!-- 날씨정보 -->
	<script src="/resources/js/weather.js"></script>
	
	
	
  </body>
  </html>
   