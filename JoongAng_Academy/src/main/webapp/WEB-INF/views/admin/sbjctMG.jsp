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
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script>
	$(function() {
		$.post({
			url : "/listAjax",
			dataType : "json"

		}).done(function(data) {
      	  grid.resetData(data.list);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		const Grid = tui.Grid;
        Grid.applyTheme('clean');
   
        
        
        
		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			scrollX : false,
			scrollY : true,
			bodyHeight: 250,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : '과목코드',
				name : 'SBJCT_NO'  
			}, {
				header : '과목명',
				name : 'SBJCT_NM',
			}, {
				header : '과목설명',
				name : 'SBJCT_EXPLN'
			}, {
				header : '총 강의시간',
				name : 'EDU_HR'
			}, {
				header : '사용여부',
				name : 'USE_YN',
			}, {
				header : '삭제여부',
				name : 'DEL_YN',
			} ]
		});

	});
</script>
</head>

<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">

						<h5 class="fw-bolder">과목관리</h5>
					</div>
					<hr style="height: 4px;" class="m-0 mb-1">
					<div class="d-flex justify-content-end pb-1 mb-1">
						<div>
							<button type="button" class="btn btn-secondary btn-sm">조회</button>
							<button type="button" class="btn btn-secondary btn-sm">신규</button>
							<button type="button" class="btn btn-secondary btn-sm">수정</button>
							<button type="button" class="btn btn-secondary btn-sm">삭제</button>
						</div>
					</div>
					<!-- 검색 -->
					<div class="mb-2 d-flex justify-content-center">
						<div class="row"
							style="width: 100%; height: 60px; background-color: #F3FAFE;">
							<div class="col-2"></div>
							<div class="col-4" style="height: 100%;">
								<div class="row">
									<div class="col-6 fw-bolder d-flex justify-content-end"
										style="line-height: 60px;">과목명</div>
									<div class="col-6 mt-2 py-1 ">
										<input type="text" class="form-control">
									</div>
								</div>
							</div>
							<div class="col-4" style="height: 100%;">
								<div class="row">
									<div class="col-3 fw-bolder d-flex justify-content-end"
										style="line-height: 60px;">사용여부</div>
									<div class="col-3 mt-3 py-1">
										<div class="row">
											<div class="col-6">
												<input type="radio" class="form-radio" name="use" id="use1"
													style="cursor: pointer;"> <label for="use1"
													class="ml-1 text-center" style="cursor: pointer;">&nbsp;&nbsp;Y</label>
											</div>
											<div class="col-6">
												<input type="radio" class="form-radio" name="use" id="use2"
													style="cursor: pointer;"> <label for="use2"
													style="cursor: pointer;">&nbsp;&nbsp;N</label>
											</div>
										</div>
									</div>
									<div class="col-3 fw-bolder d-flex justify-content-end"
										style="line-height: 60px;">삭제여부</div>
									<div class="col-3 mt-3 py-1">
										<div class="row">
											<div class="col-6">
												<input type="radio" style="cursor: pointer;"
													class="form-radio" name="del" id="del1"> <label
													for="del1" style="cursor: pointer;"
													class="ml-1 text-center">&nbsp;&nbsp;Y</label>
											</div>
											<div class="col-6">
												<input type="radio" style="cursor: pointer;"
													class="form-radio" name="del" id="del2"> <label
													for="del2" style="cursor: pointer;">&nbsp;&nbsp;N</label>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

					<div id="grid" class="mb-3" style="width: 100%;"></div>


					<hr style="height: 4px;" class="mb-2">


					<div class="mb-3"
						style="width: 100%; height: 350px; background-color: #F3FAFE;">
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">과목코드</div>
							<div class="col-2 mt-2 py-1">
								<input type="text" disabled="disabled"
									class="form-control col-6">
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">과목명</div>
							<div class="col-2 mt-2 py-1">
								<input type="text" class="form-control col-6">
							</div>
							<div class="col-2 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">사용여부</div>
							<div class="col-2 mt-3 py-1">
								<div class="row">
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-radio" name="del" id="del1"> <label
											for="del1" style="cursor: pointer;" class="ml-1 text-center">&nbsp;&nbsp;Y</label>
									</div>
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-radio" name="del" id="del2"> <label
											for="del2" style="cursor: pointer;">&nbsp;&nbsp;N</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">총 강의시간</div>
							<div class="col-2 mt-2 py-1">
								<select class="form-select">
									<option>1시간</option>
									<option>1시간 30분</option>
									<option>2시간</option>
								</select>
							</div>
							<div class="col-2 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">삭제여부</div>
							<div class="col-2 mt-3 py-1">
								<div class="row">
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-radio" name="del" id="del1"> <label
											for="del1" style="cursor: pointer;" class="ml-1 text-center">&nbsp;&nbsp;Y</label>
									</div>
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-radio" name="del" id="del2"> <label
											for="del2" style="cursor: pointer;">&nbsp;&nbsp;N</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">과목 설명</div>
							<div class="col-6 mt-2 py-1">
								<textarea rows="5" class="form-control col-6"
									style="resize: none;"></textarea>
							</div>
						</div>
					</div>



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