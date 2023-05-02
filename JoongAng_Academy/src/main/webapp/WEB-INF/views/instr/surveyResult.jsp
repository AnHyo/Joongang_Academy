<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>중앙정보처리학원</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="js/survey/surveyResult.js"></script>
<style type="text/css">
ml-10 {
	margin-left: 10px;
}
</style>
</head>
<body class="sb-nav-fixed">
<%-- 	<%@include file="../bar/topbar.jsp"%> --%>
<!-- 	<div id="layoutSidenav"> -->
<%-- 		<%@include file="../bar/sidebar.jsp"%> --%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					
					<!-- tab -->
					<div class="mt-3">
						<nav>
							<div class="nav nav-tabs" id="nav-tab" role="tablist">
								<button class="nav-link active" id="tab1_btn"
									data-bs-toggle="tab" data-bs-target="#tab1" type="button"
									role="tab" aria-controls="nav-home" aria-selected="true">결과조회</button>
								<button class="nav-link" id="tab2_btn" data-bs-toggle="tab"
									data-bs-target="#tab2" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false">총계표</button>
							</div>
						</nav>
					</div>

					<!-- 설문조사결과 -->
					<div class="tab-pane fade" id="tab1" role="tabpanel"
						aria-labelledby="nav-profile-tab">
						<h6 class="mt-3 fw-bolder">설문조사결과</h6>
						<div>
							<div id="grid1"></div>
						</div>
					</div>
					
					<!-- 총계표 -->
					<div class="tab-pane fade" id="tab2" role="tabpanel"
						aria-labelledby="nav-profile-tab">
						<h6 class="mt-3 fw-bolder">설문조사총계표</h6>
						<div>
							<div id="grid2"></div>
						</div>
					</div>
					
					
				</div>
			</main>
			<%@include file="../bar/footer.jsp"%>
		</div>
<!-- 	</div> -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>