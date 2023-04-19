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
			columns : [ {
				header : "연도",
				name : 'CRCLM_YEAR'
			}, 
			{
				header : "반기코드",
				name : 'CRCLM_HALF',
				hidden : true
			}, 
			{
				header : "반기",
				name : 'HALF'
			}, 
			{
				header : "교육과정코드",
				name : 'CRCLM_CD',
				hidden : true
			},
			{
				header : "교육과정",
				name : 'CRCLM_NM'
			}, {
				header : "과목번호",
				name : 'SBJCT_NO'
			}, {
				header : "과목명",
				name : 'SBJCT_NM'
			}, {
				header : "과목설명",
				name : 'SBJCT_EXPLN'
			}, {
				header : "총강의시간",
				name : 'EDU_HR'
			}, {
				header : "강의계획서 작성여부",
				name : 'SBJCT_PLAN_YN'
			}, {
				header : "강의실",
				name : 'ROOM_NO'
			} ]
		});
		$.post({
			url : "/estCrclmList",
			dataType : "json"
		}).done(function(data) {
			var code, name, optionHTML;
			$.each(data.estCrcList, function(index, element) {
				code = element.CD;
				name = element.CD_NM;
				optionHTML = "<option value="+code+">" + name + "</option>";
				$("#crclmSelect").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		$("#crclmSelect").change(function() {
			var crc = $("#crclmSelect").val();
			$.post({
				url : "/estYearList",
				data : {
					crc : crc
				},
				dataType : "json"
			}).done(function(data) {
				var year, optionHTML;
				if(data.estYearList.length==0){
					optionHTML = "<option value=''>" + "연도선택" + "</option>";
				}else{
					optionHTML = "<option value=''>" + "연도선택" + "</option>";
					$.each(data.estYearList, function(index, element) {
					year = element.CRCLM_YEAR;
					optionHTML += "<option value="+year+">" + year + "</option>";
					});
				}
				$("#yearSelect").html(optionHTML);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		$("#halfSelect").append("<option value='0010'>상반기</option>");
		$("#halfSelect").append("<option value='0020'>하반기</option>");
		$("#searchBtn").click(function() {
			var crc = $("#crclmSelect").val();
			var year = $("#yearSelect").val();
			var hlf = $("#halfSelect").val();
			if (crc == "") {
				alert("교육과정을 선택해주세요");
				return false;
			} else {
				$.post({
					url : "/estListAjax",
					data : {
						crc : crc,
						year : year,
						hlf : hlf
					},
					dataType : "json"
				}).done(function(data) {
					grid.resetData(data.estList);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
		});
		grid.on('click', function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				var crc = grid.getValue(ev.rowKey,'CRCLM_NM');
				var year = grid.getValue(ev.rowKey,'CRCLM_YEAR');
				var hlf = grid.getValue(ev.rowKey,'HALF');
				var sbj = grid.getValue(ev.rowKey,'SBJCT_NO');
				$.post({
					url : "/estPlan",
					data : {
						crc : crc,
						year : year,
						hlf : hlf,
						sbj : sbj
					},
					dataType : "json"
				}).done(function(data) {
					$("#crc").val(crc);
					$("#year").val(year);
					$("#hlf").val(hlf);
					$("#sbj").val(sbj);
					$("#a").val(data.subjectPlan.SBJCT_TRGT);
					$("#b").val(data.subjectPlan.SBJCT_CN);
					$("#c").val(data.subjectPlan.CRS_BOOK);
					$("#l").val(data.subjectPlan.SBJCT_MTHD_CD);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
		});

// 		강의방법코드에 기반하여 목록 생성
		$.post({
			url : "/estMethodList",
			dataType : "json"
		}).done(function(data) {
			var code, name, optionHTML;
			$.each(data.estMethodList, function(index, element) {
				code = element.CD;
				name = element.CD_NM;
				optionHTML = "<option value="+code+">" + name + "</option>";
				$("#l").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
		$("#saveBtn").click(function(){
			var crc = $("#crc").val();
			var year = $("#year").val();
			var hlf = $("#hlf").val();
			var sbj = $("#sbj").val();
			var trgt = $("#a").val();
			var cn = $("#b").val();
			var book = $("#c").val();
			var method = $("#l").val();
			console.log(crc,year,hlf,sbj);
			$.post({
				url : "/estPlanSave",
				data : {
					crc : crc,
					year : year,
					hlf : hlf,
					sbj : sbj,
					trgt : trgt,
					cn : cn,
					book : book,
					method : method
				},
				dataType : "json"
			}).done(function(data) {
				alert("저장했다");
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
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
					<h1 class="mt-4">강의계획서관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">Subject Plan
							Management</li>
					</ol>
					<div class="row">
						<div class="col-md-4">
							<select class="form-select" id="crclmSelect">
								<option selected value=''>교육과정선택</option>
							</select>
						</div>
						<div class="col-md-2">
							<select class="form-select" id="yearSelect">
								<option selected value=''>연도선택</option>
							</select>
						</div>
						<div class="col-md-2">
							<select class="form-select" id="halfSelect">
								<option selected value=''>반기선택</option>
							</select>
						</div>
						<button class="btn btn-primary col-md-1" id="searchBtn">조회</button>
						<button class="btn btn-secondary col-md-1" id="saveBtn">저장</button>
						<div id="grid" class="mb-3" style="width: 100%;"></div>
					</div>
					<div>
						<div style="background-color:#F3FAFE; width:100%; height:300px;">
							<form>
							<input type="text" id="crc" readonly>
							<input type="text" id="year" readonly>
							<input type="text" id="hlf" readonly>
							<input type="text" id="sbj" readonly>
							<label for="l" class="col-form-label">강의방법</label>
							<select id="l">
								<option value="">선택</option>
							</select>
							<div class="form-group row">
							<label for="a" class="col-sm-2 col-form-label">강의목표</label>
							<input id="a" type="text" class="form-control">
							</div>
							<div class="form-group row">
							<label for="b" class="col-sm-2 col-form-label">강의내용</label>
							<input id="b" type="text" class="form-control">
							</div>
							<div class="form-group row">
							<label for="c" class="col-sm-2 col-form-label">교재</label>
							<input id="c" type="text" class="form-control">
							</div>
							</form>
						</div>
						<div>
							<c:forEach items="${detailList }" var="d">
								${d.DTL_NO }
							</c:forEach>
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
