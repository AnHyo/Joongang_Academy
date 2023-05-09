<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%>
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
<script type="text/javascript">
$(document).ready(function(){
	
	var loginID = $("#loginID").val(); //(로그인된 ID)
	
	$.fn.changetag = function(str){
		var result = "";
		result = str.replace('<',"&lt");
		result = result.replace(">","&gt");
		return result;
	}
	
	//수강신청이 시작했는지 체크하는 함수
	var clsBgngChecker = 0;
	$.fn.clsBgngCheck = function(crc,year,hlf){
		return $.post({
			url : "/estClsBgngCheck",
			data : {
				crc : crc,
				year : year,
				hlf : hlf					
			},
			dataType : "json"
		}).done(function(data) {
			if(data.result==1){
				clsBgngChecker = 1;
			}else{
				clsBgngChecker = 0;
			}
		}).fail(function() {
			alert("문제가 발생했습니다.");
			clsBgngChecker = -1;
		});
	};		
					
	var Grid = tui.Grid;
	Grid.applyTheme('clean', {
		row : {
			hover : {
				background : '#e9ecef'
			}
		}
	});
	var grid = new tui.Grid({
		el : document.getElementById("grid"),
		scrollX : true,
		scrollY : true,
		bodyHeight : 200,
		options : {
			autoWidth : true
		},
		columns : [ {
			header : "연도",
			name : 'CRCLM_YEAR',
			sortable : true,
			width : 50,
			align : 'center'
		}, {
			header : "반기코드",
			name : 'CRCLM_HALF',
			hidden : true
		}, {
			header : "반기",
			name : 'HALF',
			width : 50,
			align : 'center'
		}, {
			header : "교육과정코드",
			name : 'CRCLM_CD',
			hidden : true
		}, {
			header : "교육과정",
			name : 'CRCLM_NM',
			width : 400,
			align : 'center'
		}, {
			header : "과목번호",
			name : 'SBJCT_NO',
			align : 'center',
			width : 50,
			sortable : true
		}, {
			header : "과목명",
			name : 'SBJCT_NM',
			width : 150
		}, {
			header : "과목설명",
			name : 'SBJCT_EXPLN',
			width : 150
		}, {
			header : "강의계획서",
			name : 'SBJCT_PLAN_YN',
			align : 'center',
			width : 70
		}, {
			header : "총강의시간",
			name : 'EDU_HR',
			align : 'center',
			width : 70
		}, {
			header : "강의실",
			name : 'ROOM_NO',
			sortable : true,
			align : 'center',
			width : 50
		}, {
			header : "필수",
			name : 'ESNTL_YN',
			align : 'center',
			width : 50
		} ],
		selectionUnit : 'row',
		columnOptions : {
			minWidth : 100
		},
		autoWidth : true
	});

	var detailPlanGrid = new tui.Grid({
		el : document.getElementById("detailPlanGrid"),
		scrollX : true,
		scrollY : true,
		bodyHeight : 200,
		options : {
			autoWidth : true
		},
		rowHeaders : [ 'checkbox' ],
		columns : [ {
			header : "번호",
			name : 'DTL_NO',
			sortable : true,
			width : 50,
			align : 'center'
		}, {
			header : "강의제목",
			name : 'LECT_TTL_NM',
			align : 'center'
		}, {
			header : "강의주제",
			name : 'LECT_TPC_NM',
			hidden : true
		}, {
			header : "강의내용",
			name : 'LECT_CN',
			hidden : true
		} ],
		selectionUnit : 'row',
		autoWidth : true
	});
	$.post({
		url : "/estCrclmList",
		dataType : "json"
	}).done(function(data) {
		var code, name, optionHTML;
		$.each(data.estCrcList, function(index,	element) {
			code = element.CD;
			name = element.CD_NM;
			optionHTML = "<option value="+code+">"
						+ name + "</option>";
			$("#crclmSelect").append(optionHTML);
		})
	}).fail(function() {
		alert("문제가 발생했습니다.");
	});

	$("#halfSelect").append(
							"<option value='0010'>상반기</option>");
	$("#halfSelect").append(
							"<option value='0020'>하반기</option>");
	$("#searchBtn").click(function() {
		var crc = $("#crclmSelect").val();
		var year = $("#yearSelect").val();
		var hlf = $("#halfSelect").val();
		$.fn.planSearch(crc,year,hlf);
	});
	
	$.fn.planSearch = function(crc,year,hlf) {
		$.post({
			url : "/estListForInstr",
			data : {
				crc : crc,
				year : year,
				hlf : hlf,
				loginID : loginID
			},
			dataType : "json"
		}).done(function(data) {
			grid.resetData(data.estList);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
	};
	
	$.fn.planSearch('','','');
	
	grid.on('click',function(ev) {
		if (ev.rowKey == null) {
			return false;
		} else {
			var crc = grid.getValue(ev.rowKey, 'CRCLM_CD');
			var year = grid.getValue(ev.rowKey,'CRCLM_YEAR');
			var hlf = grid.getValue(ev.rowKey,'CRCLM_HALF');
			var sbj = grid.getValue(ev.rowKey, 'SBJCT_NO');
			
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
					$("#crc").val(grid.getValue(ev.rowKey,'CRCLM_NM'));
					$("#crclmCd").val(crc);
					$("#year").val(year);
					$("#hlf").val(grid.getValue(ev.rowKey,'HALF'));
					$("#crclmHalf").val(hlf);
					$("#sbj").val(grid.getValue(ev.rowKey,'SBJCT_NM'));
					$("#sbjno").val(sbj);
					$("#a").val(data.subjectPlan.SBJCT_TRGT);
					$("#b").val(data.subjectPlan.SBJCT_CN);
					$("#c").val(data.subjectPlan.CRS_BOOK);
					$("#l").val(data.subjectPlan.SBJCT_MTHD_CD);
					$("#dtlno").val("");
					$("#d").val("");
					$("#e").val("");
					$("#f").val("");
					$.fn.clsBgngCheck(crc,year,hlf).then(function(){
						if(clsBgngChecker==1){
							$("#a").attr("disabled",true);
							$("#b").attr("disabled",true);
							$("#c").attr("disabled",true);
							$("#l").attr("disabled",true);
						}else{
							$("#a").attr("disabled",false);
							$("#b").attr("disabled",false);
							$("#c").attr("disabled",false);					
							$("#l").attr("disabled",false);					
						}
					});
					if (data.subjectPlan.PLAN_WRT_CMPTL == 'Y') {
						$("#nav-detail-tab").attr("disabled",false);
					} else {
						$("#nav-detail-tab").attr("disabled",true);
						$("#nav-home-tab").tab("show");
					}
	
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			
			$.fn.detailPlan(crc, year, hlf, sbj);
		}
	});

	//강의상세계획을 불러옴
	$.fn.detailPlan = function(crc, year, hlf, sbj) {
		$.post({
			url : "/estPlanDetail",
			data : {
				crc : crc,
				year : year,
				hlf : hlf,
				sbj : sbj
			},
			dataType : "json"
		}).done(function(data) {
			detailPlanGrid.refreshLayout();
			detailPlanGrid.resetData(data.detailList);

		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
	}
	$("#nav-detail-tab").click(function() {
		detailPlanGrid.refreshLayout();
	});
	//상세강의계획그리드클릭
	detailPlanGrid.on("click", function(ev) {
		if (ev.rowKey == null) {
			return false;
		} else {
			if(clsBgngChecker==1){
				$("#initDetail").attr("disabled",true);
				$("#insDetail").attr("disabled",true);
				$("#delDetail").attr("disabled",true);
			}else{
				$("#initDetail").attr("disabled",false);
				$("#insDetail").attr("disabled",false);
				$("#delDetail").attr("disabled",false);					
			}
			$("#dtlno").val(detailPlanGrid.getValue(ev.rowKey,"DTL_NO"));
			$("#d").val(detailPlanGrid.getValue(ev.rowKey,"LECT_TTL_NM"));
			$("#e").val(detailPlanGrid.getValue(ev.rowKey,"LECT_TPC_NM"));
			$("#f").val(detailPlanGrid.getValue(ev.rowKey,"LECT_CN"));
		}
	});

	// 		강의방법코드에 기반하여 목록 생성
	$.post({
		url : "/estMethodList",
		dataType : "json"
	}).done(function(data) {
		var code, name, optionHTML;
		$.each(data.estMethodList, function(index,element) {
			code = element.CD;
			name = element.CD_NM;
			optionHTML = "<option value="+code+">"
						+ name + "</option>";
			$("#l").append(optionHTML);
		})
	}).fail(function() {
		alert("문제가 발생했습니다.");
	});

	$("#saveBtn").click(function() {
		var crc = $("#crclmCd").val();
		var year = $("#year").val();
		var hlf = $("#crclmHalf").val();
		var sbj = $("#sbjno").val();
		var trgt = $("#a").val();
		trgt = $.fn.changetag(trgt);
		var cn = $("#b").val();
		cn = $.fn.changetag(cn);
		var book = $("#c").val();
		book = $.fn.changetag(book);
		var method = $("#l").val();
		if (crc == '' || year == ''|| hlf == '' || sbj == ''
			|| trgt.trim() == ''|| cn.trim() == ''|| method == '') {
			alert("입력이 완료됐는지 다시 확인해보세요");
			return false;
		}
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
			$.fn.planSearch();
			$("#nav-detail-tab").attr("disabled",false);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});

	});

	$("#insDetail").click(function() {
		var crc = $("#crclmCd").val();
		var year = $("#year").val();
		var hlf = $("#crclmHalf").val();
		var sbj = $("#sbjno").val();
		var ttl = $("#d").val();
		ttl = $.fn.changetag(ttl);
		var tpc = $("#e").val();
		tpc = $.fn.changetag(tpc);
		var cn = $("#f").val();
		cn = $.fn.changetag(cn);
		var dtlno = $("#dtlno").val();
		if (ttl.trim() == "" || tpc.trim() == ""|| cn.trim() == "") {
			alert("입력해주세요");
			return false;
		}
		if (dtlno == "") {

			$.post({
				url : "/estDetailSave",
				data : {
					crc : crc,
					year : year,
					hlf : hlf,
					sbj : sbj,
					ttl : ttl,
					tpc : tpc,
					cn : cn
				},
				dataType : "json"
			}).done(function(data) {
				alert("저장했다");
				$.fn.detailPlan(crc, year,hlf, sbj);
				$("#d").val("");
				$("#e").val("");
				$("#f").val("");

			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		} else {
			$.post({
				url : "/estDetailUpdate",
				data : {
					crc : crc,
					year : year,
					hlf : hlf,
					sbj : sbj,
					ttl : ttl,
					tpc : tpc,
					cn : cn,
					dtlno : dtlno
				},
				dataType : "json"
			}).done(function(data) {
				alert("저장했다");
				$.fn.detailPlan(crc, year,hlf, sbj);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		}
	});
					
	$("#initDetail").click(function() {
		$("#dtlno").val("");
		$("#d").val("");
		$("#d").focus();
		$("#e").val("");
		$("#f").val("");
	});

	$("#delDetail").click(function() {
		var checkedRows = detailPlanGrid.getCheckedRows();
		if (checkedRows.length == 0) {
			alert("삭제할 항목의 체크박스를 클릭해주세요");
			return false;
		} else {
			if (confirm("정말로 삭제합니까?") == true) {
				var crc = $("#crclmCd").val();
				var year = $("#year").val();
				var hlf = $("#crclmHalf").val();
				var sbj = $("#sbjno").val();
				var result = 0;
				$.fn.clsBgngCheck(crc,year,hlf);
				if(clsBgngChecker==1){
					alert("삭제할 수 없습니다");
					return false;
				}
				$.each(checkedRows,function(index,element) {
					$.post({
						url : "/estDetailDelete",
						data : {
							crc : crc,
							year : year,
							hlf : hlf,
							sbj : sbj,
							dtlno : element.DTL_NO
						},
						dataType : "json"
					}).done(function(data) {
						result += data.result;
					if (result == checkedRows.length) {
						alert("삭제했습니다.");
					$.fn.detailPlan(crc,year,hlf,sbj);
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		})
	}
}
});

	
});

</script>
<style type="text/css">
.tui-grid-cell {
  font-size: 14px;
}
</style>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<!-- Page Content-->
		<div id ="readySuv">
		<div class="my-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">강의계획서</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-xlg-11 col-xl-9 col-xxl-8">
					
					<input type="hidden" id="loginID" value="${sessionScope.id}">


					<!-- Divider-->
					<div class="pb-5"></div>
					
					<div class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">강의 목록</h4>
					</div>
					<!-- 강의 목록  -->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
											<div class="row d-flex align-items-center"
					style="height: 55px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">
					<div class="col-md-6">
						<select class="form-select" id="crclmSelect">
							<option selected value=''>교육과정선택</option>
						</select>
					</div>
					<div class="col-md-2">
						<input type="number" class="form-control" id="yearSelect">
					</div>
					<div class="col-md-2">
						<select class="form-select" id="halfSelect">
							<option selected value=''>반기선택</option>
						</select>
					</div>
					<div class="col-md-2 d-flex justify-content-center">
						<button class="btn btn-primary" id="searchBtn">조회</button>
						<button class="btn btn-secondary" id="saveBtn">저장</button>
					</div>

				</div>
							<div class="mt-2" id="grid"></div>
						</div>
					</div>

					<div class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">강의 계획서</h4>
					</div>
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
											<div>

					<div
						style="background-color: #F3FAFE; width: 100%; min-height: 200px;  border:1px solid #c0c0c0;">
						<div class="mt-3">
							<!--탭설정 -->
							<nav>
								<div class="nav nav-tabs" id="nav-tab" role="tablist">
									<button class="nav-link active" id="nav-home-tab"
										data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
										role="tab" aria-controls="nav-home" aria-selected="true">강의계획서</button>
									<button class="nav-link" id="nav-detail-tab"
										data-bs-toggle="tab" data-bs-target="#nav-detail"
										type="button" role="tab" aria-controls="nav-detail"
										aria-selected="false">상세강의계획</button>
								</div>
							</nav>
							<div class="tab-content" id="nav-tabContent">
								<!--강의계획  -->
								<div class="tab-pane fade show active" id="nav-home"
									role="tabpanel" aria-labelledby="nav-home-tab">
									<div class="d-flex justify-content-center">
										<form id="subjectPlanMain" style="width: 95%;">
											<div class="row">
												<div class="form-group col-md-4">
													<label for="crc" class="col-form-label">교육과정</label> <input
														type="text" class="form-control" id="crc" readonly>
													<input type="hidden" id="crclmCd">
												</div>
												<div class="form-group col-md-2">
													<label for="year" class="col-form-label">연도</label> <input
														type="text" class="form-control" id="year" readonly>
													<input type="hidden" id="crclmYear">
												</div>
												<div class="form-group col-md-2">
													<label for="hlf" class="col-form-label">반기</label> <input
														type="text" class="form-control" id="hlf" readonly>
													<input type="hidden" id="crclmHalf">
												</div>
												<div class="form-group col-md-2">
													<label for="sbj" class="col-form-label">과목</label> <input
														type="text" class="form-control" id="sbj" readonly>
													<input type="hidden" id="sbjno">
												</div>
												<div class="form-group col-md-2">
													<label for="l" class="col-form-label">강의방법</label> <select
														id="l" class="form-control" disabled>
														<option value="">선택</option>
													</select>
												</div>
											</div>
											<br>
											<div class="form-group row">
												<label for="a" class="col-sm-2 col-form-label">강의목표</label>
												<div class="col-sm-10">
													<input id="a" type="text" class="form-control" disabled>
												</div>
											</div>
											<div class="form-group row">
												<label for="b" class="col-sm-2 col-form-label">강의내용</label>
												<div class="col-sm-10">
													<textarea id="b" class="form-control" disabled></textarea>
												</div>
											</div>
											<div class="form-group row">
												<label for="c" class="col-sm-2 col-form-label">교재</label>
												<div class="col-sm-10">
													<input id="c" type="text" class="form-control" disabled>
												</div>
											</div>
										</form>
									</div>
								</div>
								<!--상세계획  -->
								<div class="tab-pane fade" id="nav-detail" role="tabpanel"
									aria-labelledby="nav-detail-tab">
									<div class="d-flex justify-content-center">
										<div class="row" style="width: 95%;">
											<div class="col-md-4">
												<div id="detailZone">
													<table id="detailTable" class="table table-bordered">

													</table>
												</div>
												<div id="detailPlanGrid"></div>
											</div>
											<div class="col-md-8">
												<div id="detailEnter">
													<form id="subjectPlanDetail">
														<div class='d-flex justify-content-end col-md-12'>
															<button type="button" class="btn btn-outline-dark"
																id="initDetail" disabled>신규</button>
															<button type="button" class="btn btn-outline-dark"
																id="insDetail" disabled>저장</button>
															<button type="button" class="btn btn-outline-danger"
																id="delDetail" disabled>삭제</button>
														</div>
														<div class="form-group row">
															<label for="d" class="col-sm-2 col-form-label">계획번호</label>
															<div class="col-sm-10">
																<input type="text" id="dtlno" class="form-control"
																	readonly>
															</div>
														</div>
														<div class="form-group row">
															<label for="d" class="col-sm-2 col-form-label">강의제목</label>
															<div class="col-sm-10">
																<input id="d" type="text" class="form-control" disabled>
															</div>
														</div>
														<div class="form-group row">
															<label for="e" class="col-sm-2 col-form-label">강의주제</label>
															<div class="col-sm-10">
																<input id="e" type="text" class="form-control" disabled>
															</div>
														</div>
														<div class="form-group row">
															<label for="f" class="col-sm-2 col-form-label">강의내용</label>
															<div class="col-sm-10">
																<input id="f" type="text" class="form-control" disabled>
															</div>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>




							</div>


						</div>
					</div>
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
</body>

</html>