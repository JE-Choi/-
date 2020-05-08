<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materia lize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
          <!--Import Google Icon Font-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="/resources/css/materialize.min.css"  media="screen,projection"/>

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      
    
      <!-- font -->
  <link href="https://fonts.googleapis.com/css?family=Gothic+A1:100|Noto+Serif+KR:200&display=swap&subset=korean" rel="stylesheet">
  
	<style type="text/css">
	
	*:not(i){
		font-family: 'Noto Serif KR', serif!important;
	}
	
	</style>
	

<style type="text/css">
body{
    display: table-cell;
    vertical-align: middle;
    background-color: #e0f2f1 !important;
}

html {
    display: table;
    margin: auto;
}

html, body {
    height: 100%;
}

.medium-small {
    font-size: 0.9rem;
    margin: 0;
    padding: 0;
}

.login-form {
    width: 280px;
}

.login-form-text {
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 0.8rem;
}

.login-text {
    margin-top: -6px;
    margin-left: -6px !important;
}

.margin {
    margin: 0 !important;
}

.pointer-events {
    pointer-events: auto !important;
}

.input-field >.material-icons  {
    padding-top:10px;
}

.input-field div.error{
    position: relative;
    top: -1rem;
    left: 3rem;
    font-size: 0.8rem;
    color:#FF4081;
    -webkit-transform: translateY(0%);
    -ms-transform: translateY(0%);
    -o-transform: translateY(0%);
    transform: translateY(0%);
}
</style>

<script type="text/javascript">


function sendIt(){
	
	var f = document.myForm;	
	
	str = f.user_id.value;
	str = str.trim();
	
	if(!str){
		alert("아이디를 입력하세요");
		f.user_id.focus();
		return;
	}
	f.user_id.value = str;
	
	
	str = f.user_password.value;
	str = str.trim();
	
	if(!str){
		alert("패스워드를 입력하세요");
		f.user_password.focus();
		return;
	}
	f.user_password.value = str;	
	
	
	f.action = "<%=cp %>/login_ok.action";
	f.submit();
}

</script>

</head>
<body>

<div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
      <form class="login-form" name="myForm">
        <div class="row">
          <div class="input-field col s12 center">
            <!-- <img src="images/login-logo.png" alt="" class="circle responsive-img valign profile-image-login"/> -->
<!--             <p class="center login-form-text">로그인</p> -->
 <p class="section-subtitle">로그인</p>
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-social-person-outline prefix"></i> -->
            <i class="material-icons prefix">account_circle</i>
            <input id="user_id" name="user_id" type="text" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=&quot;); cursor: auto;"/>
            <label for="user_id" data-error="wrong" class="center-align" data-success="right">아이디</label>            
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-action-lock-outline prefix"></i> -->
            <i class="material-icons prefix">vpn_key</i>
            <input id="user_password" name="user_password" type="password" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=&quot;);"/>
            <label for="user_password">비밀번호</label>
          </div>
        </div>
        
<!--         <div class="row">          
          <div class="input-field col s12 login-text">                   
              <input type="checkbox" id="test6" checked="checked" />
              <label for="test6" class="pointer-events">Remember me</label>
          </div>
        </div> -->
        
        <div class="row">
          <div class="input-field col s12">
            <button type="button" onclick="sendIt();"class="btn waves-effect waves-light col s12">로그인</button>
          </div>
                               <p class="margin medium-small" style="color:red;">&nbsp;&nbsp;${message }</p>
</div>
        
        <div class="row">
          <div class="input-field col s6 m6 l6">
            <p class="margin medium-small"><a href="<%=cp%>/signup.action">&nbsp;&nbsp;회원가입</a></p>
          </div>
          <div class="input-field col s6 m6 l6">
              <p class="margin right-align medium-small"><a href="page-forgot-password.html">비밀번호 찾기</a></p>
          </div>          
        </div>
      </form>
    </div>
  </div>
<script type="text/javascript" src="/resources/js/materialize.min.js"></script>

</body>
</html>