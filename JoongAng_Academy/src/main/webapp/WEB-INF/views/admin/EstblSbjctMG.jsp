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
		
// 		main grid
		var Grid = tui.Grid;
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				});
		var grid = new tui.Grid({
			el : document.getElementById("grid"),
			scrollX : false,
			scrollY : true,
			bodyHeight : 200,
			options : {
				autoWidth: true
			},
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "연도",
				name : 'CRCLM_YEAR',
				sortable : true
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
				name : 'SBJCT_NO',
				sortable : true
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
				name : 'ROOM_NO',
				sortable : true
			}, {
				header : "필수과목여부",
				name : 'ESNTL_YN',
				sortable : true
			} ],
			selectionUnit: 'row' 
		});
		
// 		교육과정목록생성
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
				$("#c").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
// 		강의실목록생성
		$.post({
			url : "/estRoomList",
			dataType : "json"
		}).done(function(data) {
			$.each(data.estRoomList, function(index, element) {
				room = element.ROOM_NO;
				optionHTML = "<option value="+room+">" + room + "</option>";
				$("#i").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
// 		훈련과정을 선택하면 그 훈련 과정이 개설되어있는 연도를 모두 불러와서 select박스에 option으로 붙임
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
				$("#a").html(optionHTML);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		상동
		$("#c").change(function() {
			var crc = $("#c").val();
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
				$("#a").html(optionHTML);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		반기선택
		$("#halfSelect").append("<option value='0010'>상반기</option>");
		$("#halfSelect").append("<option value='0020'>하반기</option>");
		$("#b").append("<option value='0010'>상반기</option>");
		$("#b").append("<option value='0020'>하반기</option>");
		
// 		조회버튼을 클릭
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
					grid.on('focusChange', (ev) => {
						  grid.setSelectionRange({
						    start: [ev.rowKey, 0],
						    end: [ev.rowKey, grid.getColumns().length]
						  });
						  $.fn.gridClicker(ev);
					});
					$("#a").attr("disabled",true);
					$("#b").attr("disabled",true);
					$("#c").attr("disabled",true);
					$("#d").attr("disabled",true);
					$("#e").attr("disabled",true);
					$("#f").attr("disabled",true);
					$("#g").attr("disabled",true);
					$("#insertBtn").attr("disabled",false);
					grid.on('click', function(ev){
						$.fn.gridClicker(ev);
					});
					$("#a").val("");
					$("#b").val("");
					$("#c").val("");
					$("#d").val("");
					$("#e").val("");
					$("#f").val("");
					$("#g").val("");
					$("#h").attr("checked",false);
					$("#i").val("");
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
		});

		
// 		메인 그리드 내의 데이터를 클릭하면 작동하는 함수 
		$.fn.gridClicker = function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				$("#a").val(grid.getValue(ev.rowKey,"CRCLM_YEAR"));
				$("#b").val(grid.getValue(ev.rowKey,"CRCLM_HALF"));
				$("#c").val(grid.getValue(ev.rowKey,"CRCLM_CD"));
				$("#d").val(grid.getValue(ev.rowKey,"SBJCT_NO"));
				$("#e").val(grid.getValue(ev.rowKey,"SBJCT_NM"));
				$("#f").val(grid.getValue(ev.rowKey,"SBJCT_EXPLN"));
				$("#g").val(grid.getValue(ev.rowKey,"EDU_HR"));
				var h = grid.getValue(ev.rowKey,"SBJCT_PLAN_YN");
				if(h=='Y') {
					$("#h").attr("checked",true);
				}
				if(h=='N') {
					$("#h").attr("checked",false);
				}
				var o = grid.getValue(ev.rowKey,"ESNTL_YN");
				if(o=='Y') {
					$("#o").attr("checked",true);
				}
				if(o=='N') {
					$("#o").attr("checked",false);
				}
				$("#o").attr("disabled",false);
				$("#i").val(grid.getValue(ev.rowKey,"ROOM_NO"));
				$("#i").attr("disabled",false);
				$("#j").attr("disabled",false);
				$("#k").attr("disabled",false);
				$("#insertBtn").attr("disabled",false);
				$.post({
					url : "/estInstrAjax",
					data : {
						crc : grid.getValue(ev.rowKey,"CRCLM_CD"),
						year : grid.getValue(ev.rowKey,"CRCLM_YEAR"),
						hlf : grid.getValue(ev.rowKey,"CRCLM_HALF"),
						sbjno : grid.getValue(ev.rowKey,"SBJCT_NO")
					},
					dataType : "json"
				}).done(function(data) {
					$("#m").val(data.instr.KORN_FLNM);
					$("#n").val(data.instr.INSTR_NO);
					console.log(data.instr.KORN_FLNM,data.instr.INSTR_NO);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});

			}
		};
		
// 		메인 그리드 클릭시 함수 실행
		grid.on('click', function(ev){
			$.fn.gridClicker(ev);
		});
		
// 		신규 버튼 클릭 시 입력창이 모두 입력가능하게 바뀐다
		$("#insertBtn").click(function(){
			$("#insertBtn").attr("disabled",true);
			grid.off('click');
			grid.off('focusChange');
			$("#a").attr("disabled",false);
			$("#b").attr("disabled",false);
			$("#c").attr("disabled",false);
			$("#d").attr("disabled",false);
			$("#subjectSearchBtn").attr("disabled",false);
			$("#e").attr("disabled",false);
			$("#f").attr("disabled",false);
			$("#g").attr("disabled",false);
			$("#i").attr("disabled",false);
			$("#a").val("");
			$("#b").val("");
			$("#c").val("");
			$("#d").val("");
			$("#e").val("");
			$("#f").val("");
			$("#g").val("");
			$("#h").attr("checked",false);
			$("#o").attr("checked",false);
			$("#i").val("");
		});
		
// 		저장 버튼 클릭 시 입력된 데이터를 DB에 저장하고 입력창을 다시 비활성화
		$("#saveBtn").click(function(){
			year = $("#a").val();
			hlf = $("#b").val();
			crc = $("#c").val();
			sbjcd = $("#d").val();
			sbjnm = $("#e").val();
			sbjxp = $("#f").val();
			hrs = $("#g").val();
			room = $("#i").val();
			startHour = $("#j").val();
			endHour = $("#k").val();
			kornm = $("#m").val();
			insno = $("#n").val();
			esntl = $("#o").val();
			
			$.post({
				url : "/estSaveAjax",
				data : {
					crc : crc,
					year : year,
					hlf : hlf,
					sbjcd : sbjcd,
					sbjnm : sbjnm,
					sbjxp : sbjxp,
					hrs : hrs,
					room : room,
					startHour : startHour,
					endHour : endHour,
					kornm : kornm,
					insno : insno,
					esntl : esntl
				},
				dataType : "json"
			}).done(function(data) {
				alert("saved");
				$("#a").attr("disabled",true);
				$("#b").attr("disabled",true);
				$("#c").attr("disabled",true);
				$("#d").attr("disabled",true);
				$("#e").attr("disabled",true);
				$("#subjectSearchBtn").attr("disabled",true);
				$("#f").attr("disabled",true);
				$("#g").attr("disabled",true);
				grid.on('click', function(ev){
					$.fn.gridClicker(ev);
				});
				$("#insertBtn").attr("disabled",false);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		삭제 버튼 클릭 시 체크박스가 체크된 모든 데이터를 삭제할 예정, 현재는 값만 넘기고 구현되지 않음
		$("#deleteBtn").click(function(){
			var checkedRows = grid.getCheckedRows();
			console.log(checkedRows);
			$.each(checkedRows, function(index, row){
				$.post({
					url : "/estDelete",
					data : {
						crc : row.CRCLM_CD,
						year : row.CRCLM_YEAR,
						hlf : row.CRCLM_HALF,
						sbjno : row.SBJCT_NO
					},
					dataType : "json"
				}).done(function(data) {
					console.log("success");
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			})
		});
		
// 		과목선택 그리드
		var subgrid = new tui.Grid({
			el : document.getElementById("subjectGrid"),
			scrollX : true,
			scrollY : true,
			bodyHeight : 300,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "과목번호",
				name : 'SBJCT_NO',
				align:'center'
			}, {
				header : "과목명",
				name : 'SBJCT_NM',
				align:'center'
			}, {
				header : "과목설명",
				name : 'SBJCT_EXPLN',
		        align:'center'
			}, {
				header : "총강의시간",
				name : 'EDU_HR',
		        align:'center'
			} ]
		});
// 		강사선택 그리드
		var insgrid = new tui.Grid({
			el : document.getElementById("instructorGrid"),
			scrollX : true,
			scrollY : true,
			bodyHeight : 300,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "강사번호",
				name : 'INSTR_NO',
				align:'center'
			}, {
				header : "강사명",
				name : 'KORN_FLNM',
				align:'center'
			} ]
		});
		
// 		과목검색모달
		$("#subjectSearchBtn").click(function(){
			$("#estSubjectModal").modal("show");
		});
// 		강사검색모달
		$("#instructorSearchBtn").click(function(){
			$("#estInstructorModal").modal("show");
		});
		
// 		모달띄울때새로고침
		$("#estSubjectModal").on('shown.bs.modal', function(e) {
			subgrid.refreshLayout();
		});
// 		모달띄울때새로고침
		$("#estInstructorModal").on('shown.bs.modal', function(e) {
			insgrid.refreshLayout();
		});
		
// 		과목검색모달 내 조회버튼
		$("#estSubShow").click(function(){
			$.post({
				url : "/estSubjectListAjax",
				dataType : "json"
			}).done(function(data) {
				subgrid.refreshLayout();
				subgrid.resetData(data.estSubjectList);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
// 		강사검색모달 내 조회버튼
		$("#estInsShow").click(function(){
			$.post({
				url : "/estInstructorListAjax",
				dataType : "json"
			}).done(function(data) {
				insgrid.refreshLayout();
				insgrid.resetData(data.estInstructorList);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		모달내에서 선택된 값을 임시저장
		var sbjno,sbjnm,sbjxp,hrs;
		subgrid.on('click', function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				$("#estSubChoose").attr("disabled",false);
				sbjno = subgrid.getValue(ev.rowKey,'SBJCT_NO');
				sbjnm = subgrid.getValue(ev.rowKey,'SBJCT_NM');
				sbjxp = subgrid.getValue(ev.rowKey,'SBJCT_EXPLN');
				hrs = subgrid.getValue(ev.rowKey,'EDU_HR');
				console.log(sbjno,sbjnm,sbjxp,hrs);
			}
		});

		// 		모달내에서 선택된 값을 임시저장
		var insno,kornm;
		insgrid.on('click', function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				$("#estInsChoose").attr("disabled",false);
				insno = insgrid.getValue(ev.rowKey,'INSTR_NO');
				kornm = insgrid.getValue(ev.rowKey,'KORN_FLNM');
				console.log(insno,kornm);
			}
		});
		
		
// 		모달 내에서 선택된 값을 메인 입력창에 입력한다
		$("#estSubChoose").click(function(ev){
			$("#d").val(sbjno);
			$("#e").val(sbjnm);
			$("#f").val(sbjxp);
			$("#g").val(hrs);
			$("#estSubChoose").attr("disabled",true);
			$("#estSubjectModal").modal("hide");
			sbjno="";
			sbjnm="";
			sbjxp="";
			hrs="";
		});
// 		모달 내에서 선택된 값을 메인 입력창에 입력한다
		$("#estInsChoose").click(function(ev){
			$("#m").val(kornm);
			$("#n").val(insno);
			$("#estInsChoose").attr("disabled",true);
			$("#estInstructorModal").modal("hide");
			insno="";
			kornm="";
		});
		
// 		강의시간코드에 기반하여 목록생성
		$.post({
			url : "/estHourList",
			dataType : "json"
		}).done(function(data) {
			var code, name, optionHTML;
			$.each(data.estHourList, function(index, element) {
				code = element.CD;
				name = element.CD_NM;
				optionHTML = "<option value="+code+">" + name + "</option>";
				$("#j").append(optionHTML);
				$("#k").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
// 		강의시작시간이 변경되면 강의종료시간은 그 이후의 교시만 선택할 수 있다
		$("#j").change(function(){
			var j = $("#j").val();
			$.post({
				url : "/estHourList",
				dataType : "json"
			}).done(function(data) {
				var code, name, optionHTML;
				$.each(data.estHourList, function(index, element) {
					code = element.CD;
					name = element.CD_NM;
					console.log(parseInt(code),parseInt(j));
					if(parseInt(code)<parseInt(j)){
						
					}else{						
						optionHTML += "<option value="+code+">" + name + "</option>";
					}
					$("#k").html(optionHTML);
				})
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
		
		
	});
</script>
<style>
.tui-grid-cell {
  font-size: 14px;
}
</style>
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
					<h1 class="mt-4">개설교과목관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">Established Subject
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
						<button class="btn btn-info col-md-1" id="insertBtn">신규</button>
						<button class="btn btn-secondary col-md-1" id="saveBtn">저장</button>
						<button class="btn btn-danger col-md-1" id="deleteBtn">삭제</button>
						<div id="grid" class="mb-3" style="width: 100%;"></div>
					</div>
					<div>
						<div style="background-color:#F3FAFE; width:100%; height:300px;">
							<form>
							<div class="form-group">
							<label for="c" class="col-form-label">교육과정</label>
							<select id="c" disabled>
								<option></option>
							</select>
							<label for="a" class="col-form-label">연도</label>
							<select id="a" disabled>
								<option>연도선택</option>
							</select>
							<label for="b" class="col-form-label">반기</label>
							<select id="b" disabled>
								<option>반기선택</option>
							</select>
							</div>
							<div class="form-group">
							<label for="d" class="col-form-label">과목번호</label>
							<input id="d" type="text" disabled>
							<label for="e" class="col-form-label">과목명</label>
							<input id="e" type="text" disabled>
							<button type="button" id="subjectSearchBtn" disabled>검색</button>

							<label for="f" class="col-form-label">과목설명</label>
							<input id="f" type="text" disabled>
							<label for="g" class="col-form-label">총강의시간</label>
							<input id="g" type="text" disabled>
							</div>
							<div class="form-group">
							<label for="h" class="col-form-label">강의계획서작성여부</label>
							<input id="h" type="checkbox" disabled>
							<label for="o" class="col-form-label">필수과목여부</label>
							<input id="o" type="checkbox" value="Y" disabled>
							<label for="i" class="col-form-label">강의실</label>
							<select id="i" disabled>
								<option></option>
							</select>
							</div>
							<div class="form-group">
							<label for="j" class="col-form-label">시작교시</label>
							<select id="j" disabled>
								<option value="">선택</option>
							</select>
							<label for="k" class="col-form-label">종료교시</label>
							<select id="k" disabled>
								<option value="">선택</option>
							</select>
							
							<label for="m" class="col-form-label">담당강사</label>
							<input id="m" type="text" disabled>
							<button type="button" id="instructorSearchBtn">검색</button>
							<input id="n" type="hidden">
							</div>
							</form>
						</div>
					</div>
					</div>
				<div class="container-fluid"></div>
				<!-- 과목 검색모달  -->
					<div class="modal fade" id="estSubjectModal" tabindex="-1"
						role="dialog" data-bs-backdrop="static"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">
										<b>과목검색</b>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="mb-4 w-100" style="height: 18px;">
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="estSubClose" data-bs-dismiss="modal" aria-label="Close">닫기</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="estSubChoose"  disabled="disabled">선택</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="estSubShow">조회</button>
									</div>
									
									<div class="p-1 mb-4 border container-fluid" style="background-color: #F3FAFE">
									 <div class="row">	
										<span class="col-2 text-center ta font-set">과목</span>
										  <div class="col-10" style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
											<div class="input-group input-group-sm">
												<input type="text" class="form-control form-control-sm dep_Search_text" placeholder="검색어을 입력하세요"
													name="dep_Search_text" id="dep_Search_text" aria-describedby="basic-addon3">
											</div>
										   </div>	
										</div>	
									
									</div>
									<div class="head">
										<div class="float-start" style="width: 10px; height: 27px; background-color: #498c5f;"></div>
										<div class="fw-border" style="font-size: 17px; margin-left: 15px; padding-top: 2px;">과목 정보</div>
									</div>
									<div class="table-responsive" style="margin-top: 5px;">
										<div id="subjectGrid"></div>
									</div>

								</div>
								<!-- <div class="modal-footer"></div> -->
							</div>
						</div>
					</div>
				<!-- 강사 검색모달  -->
					<div class="modal fade" id="estInstructorModal" tabindex="-1"
						role="dialog" data-bs-backdrop="static"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">
										<b>과목검색</b>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="mb-4 w-100" style="height: 18px;">
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="estInsClose" data-bs-dismiss="modal" aria-label="Close">닫기</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="estInsChoose"  disabled="disabled">선택</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="estInsShow">조회</button>
									</div>
									
									<div class="p-1 mb-4 border container-fluid" style="background-color: #F3FAFE">
									 <div class="row">	
										<span class="col-2 text-center ta font-set">강사</span>
										  <div class="col-10" style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
											<div class="input-group input-group-sm">
												<input type="text" class="form-control form-control-sm dep_Search_text" placeholder="검색어을 입력하세요"
													name="dep_Search_text" id="dep_Search_text" aria-describedby="basic-addon3">
											</div>
										   </div>	
										</div>	
									
									</div>
									<div class="head">
										<div class="float-start" style="width: 10px; height: 27px; background-color: #498c5f;"></div>
										<div class="fw-border" style="font-size: 17px; margin-left: 15px; padding-top: 2px;">강사 정보</div>
									</div>
									<div class="table-responsive" style="margin-top: 5px;">
										<div id="instructorGrid"></div>
									</div>

								</div>
								<!-- <div class="modal-footer"></div> -->
							</div>
						</div>
					</div>
			</main>
<%-- 			<%@include file="../bar/footer.jsp"%> --%>
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
