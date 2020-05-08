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

function checkPwd(){
	
	  var f1 = document.myForm;
	  var pw1 = f1.user_password.value;
	  var pw2 = f1.cpassword.value;
	  if(pw1!=pw2){
		  document.getElementById('checkPwd').style.display="block"; // 보이기
	  } else{
		  document.getElementById('checkPwd').style.display="none";
	  }
	  
	 }

// 칸 별 체크
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
	
	str = f.user_name.value;
	str = str.trim();
	
	if(!str){
		alert("이름을 입력하세요");
		f.user_name.focus();
		return;
	}
	f.user_name.value = str;
	
	
	/* if(f.idDuplication.value != "idCheck") {
		alert("아이디 중복체크 해주세요.");
		return;
	} */
	
	str = f.user_phonenumber.value;
	str = str.trim();
    if(!str) {
        alert("\n휴대전화를 입력하세요. ");
        f.user_phonenumber.focus();
        return;
    }
	f.user_phonenumber.value = str;
	
	str = f.user_email.value;
	str = str.trim();
    if(!str) {
        alert("\nE-Mail을 입력하세요. ");
        f.user_email.focus();
        return;
    }
	f.user_email.value = str;
	
	
	
	str = f.user_password.value;
	str = str.trim();
	
	if(!str){
		alert("패스워드를 입력하세요");
		f.user_password.focus();
		return;
	}
	f.user_password.value = str;
	
	str = f.cpassword.value;
	str = str.trim();
	
	if(!str){
		alert("패스워드 재확인을 입력하세요");
		f.epassword.focus();
		return;
	}
	/* if(str != f.okPwd.value){
		alert("패스워드가 일치하지 않습니다");
		f.okPwd.focus();
		return;
	} */
	f.user_password.value = str;
	

	
	
	f.action = "<%=cp %>/signup_ok.action";
	f.submit();
}

/* 
$(".login-form").validate({
	  rules: {
	    username: {
	      required: true,
	      minlength: 4
	    },     
	    email: {
	      required: true,
	      email:true
	    },
	    password: {
	      required: true,
	      minlength: 5
	    },
	    cpassword: {
	      required: true,
	      minlength: 5,
	      equalTo: "#password"
	    }
	  },
	  //For custom messages
	  messages: {
	    username:{
	      required: "Enter a username",
	      minlength: "Enter at least 4 characters"
	    }
	  },
	  errorElement : 'div',
	  errorPlacement: function(error, element) {
	    var placement = $(element).data('error');
	    if (placement) {
	      $(placement).append(error)
	    } else {
	      error.insertAfter(element);
	    }
	  }
	}); */
	
</script>
</head>
<body>

<div id="login-page" class="row">
  <div class="col s12 z-depth-4 card-panel">
    <form name="myForm" method="post" class="login-form">
      <div class="row">
        <div class="input-field col s12 center">
          <h4>회원가입</h4>
          <p class="center">회원가입을 완료해주세요</p>
        </div>
      </div>
      
       <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">perm_identity</i>
          <input id="user_id" name="user_id" type="text" autocomplete="off"/>
          <label for="user_id">아이디</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">account_circle</i>
          <input id="user_name" name="user_name" type="text"  autocomplete="off"/>
          <label for="user_name">이름</label>
        </div>
      </div>
      
        <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">phone</i>
          <input id="user_phonenumber" name="user_phonenumber" type="text" style="cursor: auto;" 
           autocomplete="off" />
          <label for="user_phonenumber">휴대전화</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">email</i>
          <input id="user_email" name="user_email" type="text" style="cursor: auto;"
           autocomplete="off" />
          <label for="user_email">본인 확인 이메일</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="user_password" name="user_password" type="password"
           autocomplete="off" />
          <label for="user_password">비밀번호</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="cpassword" name="cpassword"  type="password" onkeyup="checkPwd()" 
           autocomplete="off"/>
          <label for="cpassword">비밀번호 재확인</label>
        </div>
       <label><div id="checkPwd" style="display:none; color:red;" >동일한 암호를 입력하세요.</div></label>
      </div>

      <div class="row">
        <div class="input-field col s12">
        <button type="button" onclick="sendIt();" class="btn waves-effect waves-light col s12" >회원가입</button>
          
        </div>
        <div class="input-field col s12">
          <p class="margin center medium-small sign-up">이미 계정이 있으신가요? <a href="<%=cp %>/login.action">로그인</a></p>
        </div>
      </div>


    </form>
  </div>
</div>



 <script type="text/javascript" src="/resources/js/materialize.min.js"></script>
</body>
</html>