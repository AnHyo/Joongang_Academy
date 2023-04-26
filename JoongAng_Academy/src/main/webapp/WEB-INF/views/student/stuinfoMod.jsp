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


<script>
	$(function() {

		var CRCLM_HALF = "";
		var CRCLM_CD = "";
		var CRCLM_YEAR = "";
		var stdnt_no = $("#loginID").val();
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
			// 				$("#relTel").text(info[0].TELNO);
			// 				$("#emailAddr").text(info[0].EML_ADDR);
			// 				$("#rprsNM").text(info[0].KORN_FLNM_L);

		}).fail(function() {
			alert("문제가 발생했습니다.");
		});

	});
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<input type="hidden" id="loginID" value="${sessionScope.id}">
		<!-- Page Content-->
		<div class="my-5">
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
									<td id="regNM"></td>
								</tr>


							</table>


						</div>
					</div>
					<!-- 					<div class="d-flex justify-content-end"> -->
					<!-- 						<button type="button" class="btn btn-secondary">수정</button> -->
					<!-- 					</div> -->
					<div class="card shadow border-0 rounded-2 mt-4 mb-1 ">
						<div class="card-body p-4">
							<div class="d-flex justify-content-center">
								<div class="col-6">
									<table class="table table-borderless m-0 ">
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">연락처</td>
											<td><input type="text" class="form-control"></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">비상연락처</td>
											<td><input type="text" class="form-control"></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">이메일</td>
											<td><input type="text" class="form-control"></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">우편번호</td>
											<td>
												<div class="input-group">

													<input type="text" name="search_value" id="search_value"
														class="form-control border-gray col-md-8">
													<button class="btn btn-secondary " type="button"
														id="sbjSearchbtn">주소찾기</button>
												</div>
											</td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">주소</td>
											<td><input type="text" class="form-control"></td>
										</tr>
										<tr>
											<td class="text-end fw-bolder col-3"
												style="line-height: 40px;">상세주소</td>
											<td><input type="text" class="form-control"></td>
										</tr>

									</table>
								</div>
							</div>
							<div class="d-flex justify-content-center mt-3">
									<button type="button" class="btn btn-success col-2">수정</button>
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
</body>
</html>
