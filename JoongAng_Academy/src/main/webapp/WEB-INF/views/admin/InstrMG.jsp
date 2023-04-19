<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="css/styles.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(document).ready(function() {

		var Grid = tui.Grid;
		Grid.applyTheme('clean');
		var grid = new tui.Grid({
			el : document.getElementById("grid"),
			scrollX : false,
			scrollY : true,
			bodyHeight : 200,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "강사번호",
				name : 'INSTR_NO'
			}, {
				header : "성명",
				name : 'KORN_FLNM'
			}, {
				header : "생년월일",
				name : 'USER_BRDT'
			}, {
				header : "이메일",
				name : 'EML_ADDR'
			}, {
				header : "연락처",
				name : 'TELNO'
			},
			{
				header : "우편번호",
				name : 'ZIP',
				hidden : true
			},
			{
				header : "주소",
				name : 'ADDR'
			},
			{
				header : "상세주소",
				name : 'DADDR',
				hidden : true
			},
			{
				header : "성별",
				name : 'GENDER_CD'
			}, 
			{
				header : "사용자번호",
				name : 'USER_NO',
				hidden : true
			},
			{
				header : "교육기관",
				name : 'ENDST_NO'
			} ]
		});
		$("#searchBtn").click(function() {
				var name = $("#searchName").val();
				$.post({
					url : "/insListAjax",
					data : { name : name },
					dataType : "json"
				}).done(function(data) {
					grid.resetData(data.insList);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
		});
		grid.on('click', function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				console.log(grid.getRow(ev.rowKey));
				$("#a").val(grid.getValue(ev.rowKey,'INSTR_NO'));
				$("#b").val(grid.getValue(ev.rowKey,'KORN_FLNM'));
				$("#c").val(grid.getValue(ev.rowKey,'USER_BRDT'));
				$("#d").val(grid.getValue(ev.rowKey,'EML_ADDR'));
				$("#e").val(grid.getValue(ev.rowKey,'TELNO'));
				$("#f").val(grid.getValue(ev.rowKey,'ZIP'));
				$("#g").val(grid.getValue(ev.rowKey,'ADDR'));
				$("#h").val(grid.getValue(ev.rowKey,'DADDR'));
				$("#i").val(grid.getValue(ev.rowKey,'GENDER_CD'));
				$("#j").val(grid.getValue(ev.rowKey,'USER_NO'));
				$("#k").val(grid.getValue(ev.rowKey,'ENDST_NO'));
			}
		});
		$("#insertBtn").click(function(){
			
		});
		$("#saveBtn").click(function(){
			
		});
		$("#deleteBtn").click(function(){
			var checkedRows = grid.getCheckedRows();
			console.log(checkedRows);
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
				<!-- 탭 메뉴 -->
				<div class="bg-dark text-white" style="width: 100%; height: 40px;">
					
				</div>
				<div class="container-fluid px-4">
					<h1 class="mt-4">강사관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">Instructor
							Management</li>
					</ol>
					<div class="row">
						<input type="text" class="col-md-2" id="searchName">
						<button class="btn btn-primary col-md-1" id="searchBtn">조회</button>
						<button class="btn btn-info col-md-1" id="insertBtn">신규</button>
						<button class="btn btn-secondary col-md-1" id="saveBtn">저장</button>
						<button class="btn btn-danger col-md-1" id="deleteBtn">삭제</button>
						<div id="grid" class="mb-3" style="width: 100%;"></div>
					</div>
					<div>
						<div style="background-color:#F3FAFE; width:100%; height:300px;">
							<form>
							<div class="d-flex justify-content">
							<div class="form-group col-3">
							<label for="a" class="col-form-label col-4">강사번호</label>
							<input id="a" type="text" disabled>
							</div>
							<div class="form-group col-3">
							<label for="b" class="col-form-label col-4">성명</label>
							<input id="b" type="text">
							</div>
							<div class="form-group col-3">
							<label for="c" class="col-form-label col-4">생년월일</label>
							<input id="c" type="text">
							</div>
							</div>
							
							<div class="d-flex justify-content">
							<div class="form-group col-3">
							<label for="d" class="col-form-label col-4">이메일</label>
							<input id="d" type="text">
							</div>
							<div class="form-group col-3">
							<label for="e" class="col-form-label col-4">연락처</label>
							<input id="e" type="text">
							</div>
							<div class="form-group col-3">
							<label for="i" class="col-form-label col-4">성별</label>
							<input id="i" type="text">
							</div>
							</div>
							
							<div class="d-flex justify-content">
							<div class="form-group col-3">
							<label for="f" class="col-form-label col-4">우편번호</label>
							<input id="f" type="text">
							</div>
							<div class="form-group col-3">
							<label for="g" class="col-form-label col-4">주소</label>
							<input id="g" type="text">
							</div>
							<div class="form-group col-3">
							<label for="h" class="col-form-label col-4">상세주소</label>
							<input id="h" type="text">
							</div>
							</div>
							
							<div class="d-flex justify-content">
							<div class="form-group col-3">
							<label for="j" class="col-form-label col-4">사용자번호</label>
							<input id="j" type="text" disabled>
							</div>
							<div class="form-group col-3">
							<label for="k" class="col-form-label col-4">교육기관번호</label>
							<input id="k" type="text">
							</div>
							</div>
							</form>
						</div>
					</div>
					</div>
				<div class="container-fluid"></div>
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
