<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0020")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
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
		var user_id = $("#loginID").val();
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
					"user_id" : user_id,
					"nowPw" : nowPw
				},
				dataType : "json"

			}).done(function(data) {
				if (data.result == 1) {
					alert("비밀번호가 일치합니다.\n개인정보수정 페이지로 이동합니다.");
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

		$.post({
			url : "/instrinfoAjax",
			data : {
				"user_id" : user_id
			},
			dataType : "json"

		}).done(function(data) {
			var info = data.info;
			$("#instrNO").text(info[0].INSTR_NO);
			$("#instrNM").text(info[0].KORN_FLNM);
			$("#userBrdT").text(info[0].USER_BRDT);
			$("#genderNM").text(info[0].GENDER);
			$("#telNo").val(info[0].TELNO.replace(RegExp, ''));
			$("#emailAddr").val(info[0].EML_ADDR);
			$("#postNum").val(info[0].ZIP);
			$("#addrInfo").val(info[0].ADDR);
			$("#addrDetail").val(info[0].DADDR);
			$("#ENDST_NM").text(info[0].ENDST_NM);
			if (info[0].INSTR_DEL == 'Y') {
				$("#INSTR_DEL").text("재직");
			} else {
				$("#INSTR_DEL").text("퇴직");

			}
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});

		
		$("#telNo,#emailAddr,#postNum,#addrInfo,#addrDetail").keydown(function(key){
			  if(key.keyCode == 13){
				$("#infoSave").click();
			  }
		});
		//저장 버튼
		$(document).on(
				"click",
				"#infoSave",
				function() {

					if (!(filter.test($("#emailAddr").val()))) {
						alert("올바른 email형식을 입력하세요.");
						var a = $('#emailAddr').val().replace(/ /gi, '');
						$('#emailAddr').val(a);
						$("#emailAddr").focus();
						return false;
					}

					if ($("#telNo").val() == ""
							|| $("#telNo").val().length > 11
							| RegExp.test($("#telNo").val())) {
						alert("전화번호는 숫자만 입력해 주세요.");
						var b = $('#telNo').val().replace(RegExp, '');
						$('#telNo').val(b);
						$("#telNo").focus();
						return false;
					}

					var telinfo = $("#telNo").val();
					var emailinfo = $("#emailAddr").val();
					var postinfo = $("#postNum").val();
					var addrinfo = $("#addrInfo").val();
					var addrdeinfo = $.trim($("#addrDetail").val());

					$.post({
						url : "/instrInfoUpdate",
						data : {
							"user_id" : user_id,
							"telinfo" : telinfo,
							"emailinfo" : emailinfo,
							"postinfo" : postinfo,
							"addrinfo" : addrinfo,
							"addrdeinfo" : addrdeinfo
						},
						cache : false,
						dataType : "json"
					}).done(function(data) {
						if (data.result == "1") {
							alert("수정이 완료되었습니다.");

						} else {
							alert("문제가 발생했습니다. \n다시 시도해주세요.");
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
		<%@include file="../portalbar/instrtopbar.jsp"%>
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
		<div class="my-5" hidden id="changediv">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">개인정보 수정</span>
				</h1>
			</div>

			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<table class="table table-borderless m-0">
								<tr>
									<td class="col-2 text-center fw-bolder">강사번호</td>
									<td class="col-3" id="instrNO"></td>

									<td class="col-2 text-center fw-bolder">이름</td>
									<td class="col-1" id="instrNM"></td>

									<td class="col-1 text-center fw-bolder">생년월일</td>
									<td class="col-2" id="userBrdT"></td>

								</tr>
								<tr>
									<td class="text-center fw-bolder">소속기관</td>
									<td id="ENDST_NM"></td>
									<td class="text-center fw-bolder">인사상태</td>
									<td id="INSTR_DEL"></td>
									<td class=" text-center fw-bolder">성별</td>
									<td id="genderNM"></td>

								</tr>
							</table>


						</div>
					</div>

					<div class="card shadow border-0 rounded-2 mt-4 mb-1 ">
						<div class="card-body p-4">
							<div class="d-flex justify-content-center">
								<div class="col-6">
									<table class="table table-borderless m-0 ">
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">연락처</td>
											<td><input type="text" class="form-control" id="telNo"></td>
										</tr>

										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">이메일</td>
											<td><input type="text" class="form-control"
												id="emailAddr"></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">우편번호</td>
											<td>
												<div class="input-group">

													<input type="text" name="postNum" id="postNum"
														class="form-control border-gray col-md-8" disabled>
													<button class="btn btn-secondary " type="button"
														id="postSearch" onclick="stuent_post()">주소찾기</button>
												</div>
											</td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">주소</td>
											<td><input type="text" class="form-control"
												id="addrInfo" name="addrInfo" disabled></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">상세주소</td>
											<td><input type="text" class="form-control"
												id="addrDetail" name="addrDetail"></td>
										</tr>

									</table>
								</div>
							</div>
							<div class="d-flex justify-content-center mt-3">
								<button type="button" id="infoSave"
									class="btn btn-success col-2">수정</button>
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
