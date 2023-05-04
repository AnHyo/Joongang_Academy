<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>중앙정보처리학원</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Custom Google font-->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@100;200;300;400;500;600;700;800;900&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="css/styles2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="js/student/studentpost.js"></script>

<script>
	$(function() {

		var CRCLM_HALF = "";
		var CRCLM_CD = "";
		var CRCLM_YEAR = "";
		var stdnt_no = $("#loginID").val();

		//정규식 검사(email형식이 맞는지)
		var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		//전화번호 정규식
		var RegExp = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ A-Z\uAC00-\uD7A3\u3131-\u3163]/gim;
		
		$("#nowPw").keydown(function(key){
			  if(key.keyCode == 13){
				$("#pwCheckbtn").click();
			  }
		});
		$("#pwCheckbtn").click(function() {
			var nowPw = $("#nowPw").val();

			nowPw = nowPw.replaceAll(' ', 'x');

			$.post({
				url : "/pwCheckAjax",
				data : {
					"user_id" : stdnt_no,
					"nowPw" : nowPw
				},
				dataType : "json"

			}).done(function(data) {
				if (data.result == 1) {
					alert("비밀번호가 일치합니다.\n비밀번호 변경 페이지로 이동합니다.");
					$("#checkdiv").prop("hidden", true);
					$("#changediv").prop("hidden", false);
				} else {
					alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
					$("#nowPw").val("");
					$("#nowPw").focus();
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

		});
		
		$("#newPw,#newPwCheck").keydown(function(key){
			  if(key.keyCode == 13){
				$("#pwChangebtn").click();
			  }
		});
		$("#pwChangebtn").click(function() {
			var newPw = $("#newPw").val();
			var newPwCheck = $("#newPwCheck").val();

			
			$.post({
				url : "/pwCheckAjax",
				data : {
					"user_id" : stdnt_no,
					"nowPw" : newPw
				},
				dataType : "json"

			}).done(function(data) {
				if (data.result == 1) {
					alert("현재 비밀번호와 새 비밀번호가 같습니다. 다시 입력해주세요.");
					$("#newPw").focus();
				} else {
					if (newPw == "") {
						alert("새 비밀번호를 입력해주세요.");
						$("#newPw").focus();
						return false;
					}
					if (newPwCheck == "") {
						alert("새 비밀번호 확인을 입력해주세요.");
						$("#newPwCheck").focus();
						return false;
					}

					if (newPwCheck != newPw) {
						alert("비밀번호가 일치하지 않습니다.");
						return false;
					}

					$.post({
						url : "/pwChangeAjax",
						data : {
							"user_id" : stdnt_no,
							"newPw" : newPw
						},
						dataType : "json"

					}).done(function(data) {
						if (data.result == 1) {
							alert("비밀번호를 변경했습니다. 다시 로그인해주세요.");
							location.href = "/logout";
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

			
			
		

		});

	});
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<input type="hidden" id="loginID" value="${sessionScope.id}">
		<!-- Page Content-->
		<div class="container px-5  my-5" id="checkdiv">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">비밀번호 확인</span>
				</h1>
			</div>

			<div class="row gx-5 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">


					<div class="card shadow border-0 rounded-2 mt-4 mb-1 ">
						<div class="card-body p-4">
							<div class="d-flex justify-content-center">
								<div class="col-7">
									<table class="table table-borderless m-0 ">
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">아이디</td>
											<td style="line-height: 40px;" id="userID">${sessionScope.id}</td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">현재 비밀번호</td>
											<td><input type="password" class="form-control"
												id="nowPw"></td>
										</tr>


									</table>
								</div>
							</div>
							<div class="d-flex justify-content-center mt-3">
								<button type="button" id="pwCheckbtn"
									class="btn btn-success col-2">확인</button>
							</div>

						</div>
					</div>




				</div>
			</div>


		</div>
		<div class="container px-5  my-5" hidden id="changediv">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">비밀번호 변경</span>
				</h1>
			</div>

			<div class="row gx-5 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">


					<div class="card shadow border-0 rounded-2 mt-4 mb-1 ">
						<div class="card-body p-4">
							<div class="d-flex justify-content-center">
								<div class="col-9">
									<table class="table table-borderless m-0 ">
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">아이디</td>
											<td style="line-height: 40px;" id="userID">${sessionScope.id}</td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">새 비밀번호</td>
											<td><input type="password" class="form-control"
												id="newPw"></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">새 비밀번호 확인</td>
											<td><input type="password" class="form-control"
												id="newPwCheck"></td>
										</tr>


									</table>
								</div>
							</div>
							<div class="d-flex justify-content-center mt-3">
								<button type="button" id="pwChangebtn"
									class="btn btn-success col-2">확인</button>
							</div>

						</div>
					</div>




				</div>
			</div>


		</div>
	</main>

	<%@include file="../portalbar/footer.jsp"%>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts2.js"></script>

	<!-- 우편번호 조회 API -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
