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

	});
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<!-- Page Content-->
		<div class="my-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">출결확인</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<!-- Experience Section-->

					<div
						class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">내 정보</h4>
					</div>

					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<div class="row align-items-center">
								<div class="row col-4">
									<div class="col-4 d-flex justify-content-end fw-bolder">학번(이름)</div>
									<input type="hidden" id="loginID" value="${sessionScope.id}">
									<div class="col-8">
										<span id="stdntNo" class="col-6"></span> (<span
											id="searchNM" class="col-6"></span>)
									</div>
								</div>
								<div class="col-2">
									<div class="row">
										<div class="col-5 d-flex justify-content-end fw-bolder">학적상태</div>
										<div class="col-4" id="regNM"></div>
									</div>
								</div>
								<div class="col-6">
									<div class="row">
										<div class="col-2 d-flex justify-content-end fw-bolder">과정구분</div>
										<div class="col-10">
											<span id="crclmYear"></span>&nbsp;/&nbsp; <span
												id="crclmHalf"></span>&nbsp;/&nbsp;&nbsp; <span id="crclmNM"></span>
										</div>
									</div>

								</div>
							</div>
							<div class="row d-flex justify-content-end mt-3">
								<div class="row col-3">
									<div class="col-4 d-flex fw-bolder">생년월일</div>
									<div class="col-8 ">
										<span id="userBrdT" class="col-8"></span> (<span
											id="genderNM" class="col-4"></span>)
									</div>
								</div>
								<div class="row col-3">
									<div class="col-3 d-flex justify-content-end fw-bolder">연락처</div>
									<div class="col-8" id="relTel"></div>
								</div>
								<div class="row col-3">
									<div class="col-3 d-flex justify-content-end fw-bolder">이메일</div>
									<div class="col-9" id="emailAddr"></div>
								</div>
								<div class="row col-3">
									<div class="col-4 d-flex justify-content-end fw-bolder">대표강사</div>
									<div class="col-8" id="rprsNM"></div>
								</div>
							</div>
						</div>
					</div>



					<!-- Divider-->
					<div class="pb-5"></div>
					<!-- Skills Section-->
					<!-- Skillset Card-->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="row">

								<div class="d-flex align-items-center col-3">
									<h6 class="fw-bolder mb-2 px-2">
										<span class=" d-inline">개설과목</span>
									</h6>
								</div>
								<div class="col-4">
									<div class="row d-flex justify-content-end"
										style="margin-left: 40px; margin-right: -50px;">
										<div class="col-3" style="margin-left: 20px;">
											<input type="radio" style="cursor: pointer;"
												checked="checked" class="form-check-input esntlchk"
												name="esntlchk" id="allchk" value=""> <label
												for="allchk"
												style="cursor: pointer; font-size: 14px; vertical-align: 1px;"
												class="text-center form-check-label">&nbsp;전체</label>
										</div>
										<div class="col-3" style="margin-left: -20px;">
											<input type="radio" style="cursor: pointer;"
												class="form-check-input esntlchk" name="esntlchk" id="Ychk"
												value="Y"> <label for="Ychk"
												style="cursor: pointer; font-size: 14px; vertical-align: 1px;"
												class="text-center form-check-label">&nbsp;필수</label>
										</div>
										<div class="col-3" style="margin-left: -20px;">
											<input type="radio" style="cursor: pointer;"
												class="form-check-input esntlchk" name="esntlchk" id="Nchk"
												value="N"> <label for="Nchk"
												style="cursor: pointer; font-size: 14px; vertical-align: 1px;"
												class="text-center form-check-label">&nbsp;선택</label>
										</div>
									</div>
								</div>
								<div class="col-5">
									<div class="input-group" style="margin-top: -5px;">
										<div class="col-3">
											<select class="form-control form-control-sm"
												disabled="disabled" name="search_name" id="search_name"
												style="border-radius: 5px 0 0 5px;">
												<option value="all" selected>전체</option>
												<option value="sbjNM">과목명</option>
												<option value="instrNM">강사명</option>
											</select>
										</div>
										<input type="text" name="search_value" id="search_value"
											disabled="disabled"
											class="form-control form-control-sm border-gray col-md-8"
											placeholder="검색어를 입력하세요">
										<button class="btn btn-dark btn-sm" type="button"
											disabled="disabled" id="sbjSearchbtn">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
							<div class="mb-1">
								<div class="d-flex align-items-center mb-4">

									<div id="estblSBJ" class="mb-2 mt-1"
										style="width: 100%; height: 270px;"></div>
								</div>

							</div>
							<div class="d-flex align-items-center">

								<h6 class="fw-bolder mb-2 mt-3 px-2">
									<span class=" d-inline">신청과목</span>
								</h6>
							</div>
							<div class="mb-5">
								<div class="d-flex align-items-center">
									<div id="applySBJ" class="mb-3 mt-1"
										style="width: 100%; height: 270px;"></div>
								</div>

							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</main>
	
	<%@include file="../portalbar/footer.jsp"%>
	<%@include file="./planModal.jsp"%>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts2.js"></script>
</body>
</html>
