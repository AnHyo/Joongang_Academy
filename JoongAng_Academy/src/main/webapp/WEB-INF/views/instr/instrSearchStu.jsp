<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%> --%>
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
//-----과목조회 버튼
		var instrNo = $("#loginID").val();
		var selectHalf = $('select[name=crclm_half]').val();
		var inputYear = $("#inputYear").val();
		
		$("#BtnSbjSearch").click(function () {
			//세션 로그인 아이디 
			
			$.post({
				url :"/sbjSearchAjax",
				cache: false,
				data : JSON.stringify({
					"instrNo":instrNo,
					"selectHalf" : selectHalf,
					"inputYear" : inputYear
				}),
				dataType : "json",
				contentType : 'application/json'
			}).done(function(data){
				var sbjList = data.list;
				grid.resetData(sbjList);
				
				let sCount = sbjList.length;
				$("#searchCount").html(sCount);
				
			}).fail(function (xhr, status, errorThown) {
				alert("문제가 발생했습니다.");
			});
		
		
			const Grid = tui.Grid;
				Grid.applyTheme('clean', {
				row : {
					hover : {
						background : '#e9ecef'
					}
				}
			});
				grid.on('focusChange', (ev) => {
					grid.setSelectionRange({
					    start: [ev.rowKey, 0],
					    end: [ev.rowKey, grid.getColumns().length ]
					  });
				});
		});// 과목조회 버튼
			
//-----그리드 생성
			var grid = new tui.Grid({
				el : document.getElementById('sbjctInfo'),
				scrollX : false,
				scrollY : true,
				bodyHeight : 250,
				columns : [ {
					header : '과정명',
					name : 'CRCLM_NM',
					width : 500,
					align : 'center',
					sortable: true
				}, {
					header : '과목명',
					name : 'SBJCT_NM',
					width : 200,
					align : 'center',
					sortable: true
					
				}, {
					header : '강의시간',
					name : 'CLASSTM',
					width : 300,
					align : 'center',
					sortable: true
				
				}, {
					header : '강의실',
					name : 'ROOM_NM',
					width : 200,
					align : 'center',
					sortable: true
					
				} ]

				
				
			});//grid
			
//-----그리드 클릭시
			grid.on("click",function (ev) {
				
				const rowKey = grid.getFocusedCell().rowKey
				var obj = grid.getRow(rowKey);
				var sbjctNo = obj.SBJCT_NO;
				var instrNo = $("#loginID").val();
				var selectHalf = $('select[name=crclm_half]').val();
				var inputYear = $("#inputYear").val();
				
				
				$.post({
					url :"/stuAjax",
					cache: false,
					data : JSON.stringify({
						"sbjctNo" : sbjctNo,
						"selectHalf" : selectHalf,
						"inputYear" : inputYear
					}),
					dataType : "json",
					contentType : 'application/json'
				}).done(function(data){
					var stuList = data.list;
					grid2.resetData(stuList);
					
					let sCount = stuList.length;
					$("#searchCountStu").html(sCount);
			
				}).fail(function (xhr, status, errorThown) {
					alert("문제가 발생했습니다.");
				});
			
				
			});//그리드 클릭
				var grid2 = new tui.Grid({
					el : document.getElementById('stuInfo'),
					scrollX : false,
					scrollY : true,
					bodyHeight : 400,
					columns : [ {
						header : '학번',
						name : 'STDNT_NO',
						width : 200,
						align : 'center',
						sortable: true
					}, {
						header : '이름',
						name : 'KORN_FLNM',
						width : 200,
						align : 'center',
						sortable: true
						
					}, {
						header : '생년월일',
						name : 'USER_BRDT',
						width : 100,
						align : 'center',
						sortable: true
					
					}, {
						header : '성별',
						name : 'GENDER_CD',
						width : 150,
						align : 'center',
						sortable: true
						
					 
					},{
						header : '전화번호',
						name : 'TELNO',
						width : 200,
						align : 'center'
						
					}, {
						header : '이메일',
						name : 'EML_ADDR',
						width : 200,
						align : 'center',
						sortable: true
						
					}, {
						header : '상태',
						name : 'REG_CD',
						width : 150,
						align : 'center',
						sortable: true
						
					} ]

					
					
					});//grid
			
			
	});//func
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<!-- Page Content-->
		<div class="my-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">학생정보조회(강사)</span>
				</h1>
			</div>
			<input type="hidden" id="loginID" value="${sessionScope.id}">
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<div class="pb-5"></div>
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="row" style="width: 100%">

								<div class="d-flex align-items-center col-1">
									<h6 class="fw-bolder mb-2 px-2">
										<span class=" d-inline">과목정보</span>
									</h6>
								</div>
								<div class="col-6" style="margin-left: -30px; margin-top: 4px;">
									<div class="position-relative "
										style="display: flex; width: 150px; font-size: 13px; color: #a3a3a7; line-height: 30px; margin: 0 10px;">
										<div id="searchCount"
											style="width: 15px; font-size: 13px; color: #a3a3a7;">
											0</div>
										건이 조회되었습니다.
									</div>
								</div>

								<div class="col-5 ">
									<div class="input-group mb-2 "
										style="width: 100%; margin-top: -5px;">
										<span class="input-group-text"
											style="width: calc(20%); background-color: white;" id="grade">학년도</span>
										<input type="text" class="form-control form-control-sm"
											aria-label="학년도" value="2023" id="inputYear" numberOnly>
										<select class="form-select form-select-sm" name="crclm_half"
											aria-describedby="BtnSearch">
											<option value="0010">상반기</option>
											<option value="0020">하반기</option>
										</select>
										<button class="btn btn-outline-success" type="button"
											id="BtnSbjSearch">조회</button>
									</div>
								</div>
							</div>
							<div class="mb-5">
								<div class="d-flex align-items-center">
									<div id="sbjctInfo" class="mb-3 mt-1"
										style="width: 100%; height: 270px;"></div>
								</div>

							</div>

							<div class="row" style="width: 100%">
								<div class="d-flex align-items-center col-1">
									<h6 class="fw-bolder mb-2 px-2">
										<span class=" d-inline">학생정보</span>
									</h6>
								</div>
								<div class="col-6" style="margin-left: -30px; margin-top: 4px;">
									<div class="position-relative "
										style="display: flex; width: 150px; font-size: 13px; color: #a3a3a7; line-height: 30px; margin: 0 10px;">
										<div id="searchCountStu"
											style="width: 15px; font-size: 13px; color: #a3a3a7;">
											0</div>
										건이 조회되었습니다.
									</div>
								</div>
								<div class="col-5 ">
									<div class="input-group mb-2 "
										style="width: 100%; margin-top: -5px;">
										<span class="input-group-text"
											style="width: calc(20%); background-color: white;" id="grade">이름(학번)</span>
										<input type="text" class="form-control form-control-sm"
											aria-label="학년도" placeholder="이름(학번)을 입력하세요." id="inputYear"
											numberOnly>
										<button class="btn btn-outline-success" type="button"
											id="BtnStuSearch">조회</button>
									</div>
								</div>
							</div>
							<div class="mb-5">
								<div class="d-flex align-items-center">
									<div id="stuInfo" class="mb-3 mt-1"
										style="width: 100%; height: 400px;"></div>
								</div>

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
