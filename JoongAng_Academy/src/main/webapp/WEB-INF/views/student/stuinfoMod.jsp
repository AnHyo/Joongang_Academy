<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0010")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
}
%>
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
			url : "/stuinfoAjax",
			data : {
				"stdnt_no" : stdnt_no
			},
			dataType : "json"

		}).done(function(data) {
			var info = data.info;
			$("#stdntNo").text(info[0].STDNT_NO);
			$("#stuNM").text(info[0].KORN_FLNM_S);
			$("#regNM").text(info[0].REG_CD_NAME);
			$("#crclmYear").text(info[0].CRCLM_YEAR);
			$("#crclmHalf").text(info[0].CRCLM_HALF_NAME);
			$("#crclmNM").text(info[0].CRCLM_CD_NAME);
			$("#userBrdT").text(info[0].USER_BRDT);
			$("#genderNM").text(info[0].GENDER_CD_NAME);
			$("#telNo").val(info[0].TELNO.replace(RegExp, ''));
			$("#relTel").val(info[0].REL_TELNO.replace(RegExp, ''));
			$('#relation option[value="'+info[0].REL_CD+'"]').prop('selected', true);
			$("#emailAddr").val(info[0].EML_ADDR);
			$("#postNum").val(info[0].ZIP);
			$("#addrInfo").val(info[0].address);
			$("#addrDetail").val(info[0].DADDR);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});

		
		$("#telNo,#relTel,#emailAddr,#relation,#postNum,#addrInfo,#addrDetail").keydown(function(key){
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

					if ($("#telNo").val() == ""|| $("#telNo").val().length > 11 | RegExp.test($("#telNo").val())) {
						alert("전화번호는 숫자만 입력해 주세요.");
						var b = $('#telNo').val().replace(RegExp, '');
						$('#telNo').val(b);
						$("#telNo").focus();
						return false;
					}

					if ($("#relTel").val().length > 11
							|| RegExp.test($("#relTel").val())) {
						alert("전화번호는 숫자만 입력해 주세요.");
						var c = $('#emerTel').val().replace(RegExp, '');
						$('#relTel').val(c);
						$("#relTel").focus();
						return false;
					}

					if ($("#relTel").val() != "") {
						if ($("#relation").val() == "") {
							alert("관계를 선택해 주세요.");
							$("#relation").focus();
							return false;
						}
					} else {
						if ($("#relation").val() != "") {
							alert("비상연락처를 입력해 주세요.");
							$("#relation").val("");
							$("#relTel").focus();
							return false;
						}
					}

					var telinfo = $("#telNo").val();
					var etelinfo = $("#relTel").val();
					var emailinfo = $("#emailAddr").val();
					var relationinfo = $("#relation").val();
					var postinfo = $("#postNum").val();
					var addrinfo = $("#addrInfo").val();
					var addrdeinfo = $.trim($("#addrDetail").val());

					$.post({
						url : "/studentInfoUpdate",
						data : {
							"studentID" : stdnt_no,
							"telinfo" : telinfo,
							"etelinfo" : etelinfo,
							"emailinfo" : emailinfo,
							"relationinfo" : relationinfo,
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
									<td class="col-1 text-center fw-bolder">학번</td>
									<td class="col-1" id="stdntNo"></td>

									<td class="col-1 text-center fw-bolder">이름</td>
									<td class="col-1" id="stuNM"></td>

									<td class="col-1 text-center fw-bolder">생년월일</td>
									<td class="col-4" id="userBrdT"></td>

									<td class="col-1 text-center fw-bolder">성별</td>
									<td class="col-1" id="genderNM"></td>
								</tr>
								<tr>
									<td class="text-center fw-bolder">교육연도</td>
									<td id="crclmYear"></td>

									<td class="text-center fw-bolder">교육반기</td>
									<td id="crclmHalf"></td>

									<td class="text-center fw-bolder">훈련과정</td>
									<td id="crclmNM"></td>

									<td class="text-center fw-bolder">학적상태</td>
									<td id="regNM" style="color:red;"></td>
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
												style="line-height: 40px;">비상연락처</td>
											<td>
												<div class="row">
													<div class="col-8">
														<input type="text" class="form-control" id="relTel">
													</div>
													<div class="col-4">
														<select class="form-select" id="relation"
															name="relation">
															<option selected value="">관계</option>
															<c:forEach items="${relationship }" var="r"
																varStatus="status">
																<option value="${r.CD }">${r.CD_NM }</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</td>
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
								<button type="button" id="infoSave" class="btn btn-success col-2">수정</button>
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
