<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script>
$(function(){
	$("#searchbtn").click(function(){
		$("#stuSearchModal").modal("show");
		
	});
});
</script>
</head>

<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>
		<%@include file="./searchModal.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">

						<h5 class="fw-bolder">수강강좌내역</h5>
					</div>
						<hr class="m-0 mb-2">
					<div class="float-start mb-2"
						style="width: 10px; height: 27px; background-color: #498c5f; margin-right: 10px;"></div>
					<h6 class="fw-bolder" style="line-height: 27px;">기본정보</h6>
	
					<!-- 검색 -->
					<div class="mb-3 d-flex justify-content-center" >
						<div class="row"
							style="width: 100%; height: 120px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">
							<div class="row col-4">
								<div class="col-4 mt-4 d-flex justify-content-end fw-bolder" style="font-size: 14px;">학번(이름)</div>
								<div class="col-8 mt-3">
									<div class="input-group">
										<input type="text" class="form-control form-control-sm" placeholder="학번"
											disabled> <input type="text" class="form-control form-control-sm"
											placeholder="이름">
										<button class="btn btn-dark btn-sm" type="button" id="searchbtn">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
							<div class="row col-2" style="margin-left: 3px;">
								<div class="col-5 mt-4 d-flex justify-content-end fw-bolder" style="font-size: 14px;">학적상태</div>
								<div class="col-7 mt-3">
									<input type="text" class="form-control form-control-sm" disabled>
								</div>
							</div>
							<div class="row col-6">
								<div class="col-2 mt-4 d-flex justify-content-end fw-bolder" style="font-size: 14px;">과정구분</div>
								<div class="col-10 mt-3 ">
									<div class="input-group">
										<div class="col-2">
											<input type="text" class="form-control form-control-sm"
												style="border-radius: 5px 0 0 5px;" placeholder="2023"
												disabled>
										</div>
										<div class="col-2">
											<input type="text" class="form-control form-control-sm"
												style="border-radius: 0;" placeholder="상반기" disabled>
										</div>
										<div class="col-8">
											<input type="text" class="form-control form-control-sm"
												style="border-radius: 0 5px 5px 0;" placeholder="교육훈련과정"
												disabled>
										</div>
									</div>
								</div>
							</div>

							<div class="d-flex justify-content-center">
								<div class="row col-4">
									<div class="col-3 mt-2 d-flex justify-content-end fw-bolder" style="font-size: 14px;">생년월일</div>
									<div class="col-8 mt-1">
										<div class="input-group" style="margin-right: 5px;">
											<div class="col-8">
												<input type="text" class="form-control form-control-sm"
													style="border-radius: 5px 0 0 5px;"
													placeholder="1999.01.05" disabled>
											</div>
											<div class="col-4">
												<input type="text" class="form-control form-control-sm"
													style="border-radius: 0 5px 5px 0;" placeholder="여"
													disabled>
											</div>
										</div>
									</div>
								</div>
								<div class="row col-4">
									<div class="col-2 mt-2 d-flex justify-content-end fw-bolder" style="font-size: 14px;">연락처</div>
									<div class="col-7 mt-1">
										<input type="text" class="form-control form-control-sm" disabled>
									</div>
								</div>
								<div class="row col-4">
									<div class="col-2 mt-2 d-flex justify-content-end fw-bolder" style="font-size: 14px;">이메일</div>
									<div class="col-7 mt-1">
										<input type="text" class="form-control form-control-sm" disabled>
									</div>
								</div>


							</div>
						</div>

					</div>
					<div class="float-start"
						style="width: 10px; height: 29px; background-color: #498c5f; margin-right: 10px;"></div>
					<h6 class="mt-2 pt-1 fw-bolder">수강신청내역</h6>
					<div id="grid" class="mb-3 mt-3" style="width: 100%; background-color: gray; height:450px;" ></div>
				


				


				</div>
			</main>
			<%@include file="../bar/footer.jsp"%>
		</div>
	</div>
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