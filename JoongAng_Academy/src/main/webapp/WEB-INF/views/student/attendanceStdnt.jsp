<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
if (id != null) {
   if (!session.getAttribute("groupCD").equals("0010")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
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

<style type="text/css">
.tui-grid-cell {
	font-size: 13px;
}

.marginPadding0 {
	margin: 0;
	padding: 0;
}
.margin0{
	margin: 0;
}
.textheight25 {
	height: 25px;
}

.tui-grid-cell-content {
	text-align: center;
}

.tui-grid-body-area {
	cursor: pointer;
	text-align: center;
}
.tui-grid-cell.selectedRow{
	background-color: #edfdf2;
}
</style>

<script>
	$(function() {
		
		tui.Grid.applyTheme('default', {
			cell : {
				normal : {
					background : '#fff',
					border : '#e0e0e0',
					showVerticalBorder : false,
					showHorizontalBorder : true
				},
				header : {
					background : '#f9f9f9',
					border : '#e0e0e0'
				},
				selectedHeader : {
					background : '#e0e0e0'
				}
			}
		});

		const sbjctList = new tui.Grid({

			el : document.getElementById('sbjctList'),
			scrollX : false,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
			header : {
				height : 30
			},
			columns : [ {
				header : '훈련과정코드',
				name : 'CRCLM_CD',
				hidden : true
			},{
				header : '학년도',
				name : 'CRCLM_YEAR',
				hidden : true
			}, {
				header : '기간',
				name : 'CRCLM_HALF',
				hidden : true
			}, {
				header : '과목코드',
				name : 'SBJCT_NO',
				width : 80,
				sortable: true
			}, {
				header : '필수구분',
				name : 'ESNTL_YN',
				width : 80,
				formatter : function(value){
					let YN = value.row.ESNTL_YN;
					if(YN == 'Y'){
						return '필수';
					} else {
						return '선택';
					}
				},
				sortable: true
			}, {
				header : '과목명',
				name : 'SBJCT_NM',
				sortable: true
			}, {
				header : '담당강사',
				name : 'KORN_FLNM',
				width : 80,
				sortable: true
			}, {
				header : '강의시간',
				name : 'cls_dayhour',
				width : 180
			}, {
				header : '강의실',
				name : 'ROOM_NM',
				width : 100,
				sortable: true
			}, {
				header : '강의시간',
				name : 'EDU_HR',
				hidden : true
			} ],
			
			bodyHeight : 577,

		});
		
		const atndDetailList = new tui.Grid({

			el : document.getElementById('atndDetailList'),
			scrollX : false,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
			header : {
				height : 30
			},
			columns : [ {
				header : '훈련과정코드',
				name : 'CRCLM_CD',
				hidden : true
			},{
				header : '학년도',
				name : 'CRCLM_YEAR',
				hidden : true
			}, {
				header : '기간',
				name : 'CRCLM_HALF',
				hidden : true
			}, {
				header : '주차',
				name : 'WEEK_NUM'
			}, {
				header : '수업일자',
				name : 'LECT_YMD',
				width : 70
			}, {
				header : '요일',
				name : 'LECT_DAY',
				width : 70,
			}, {
				header : '교시',
				name : 'CLS_KORN',
				width : 70
			}, {
				header : '출결',
				name : 'ATND_KORN',
				width : 60,
				sortable: true
			}, {
				header : '비고',
				name : 'RMRK',
				width : 70
			} ],
			
			bodyHeight : 510,

		});
		
		
// ---- 내 정보	----	
		const id = '<%= id %>';
		
		$.post({
			url : "/atndStdnt-stdntInfo",
			data : { "id" : id },
			dataType : "json"
		}).done(function(data){
			$("#year").html(data.stdntInfo.CRCLM_YEAR);
			$("#half").html(data.stdntInfo.CRCLM_HALF);
			$("#crclmName").html(data.stdntInfo.CRCLM_NM);
		}).fail(function(xhr){
			alert("문제발생");
		});
		
		$("#summarySbjctName").html("");
		$("#summaryEduHour").html("");
		$("#summaryAtndHour").html("");
		$("#summaryAbscHour").html("");
		$("#summaryAtndPercent").html("");
		
		//alert("학생아이디 : " + id)
		atndDetailList.resetData([]);
		
		let searchSbjct = $.trim($("#searchSbjct").val());
		
		$.post({
			url : "/atndStdnt-sbjctList",
			data : {
				"id" : id,
				"searchSbjct" : searchSbjct,
			},
			dataType : "json"
		}).done(function(data){
			sbjctList.resetData(data.sbjctList);
			$("#crclmCount").html(sbjctList.getRowCount());
			
		}).fail(function(xhr){
			alert("문제발생");
		});
				

// ---- 강의목록 행 클릭 ----
		sbjctList.on('click',function(ev){
			
			$("#summarySbjctName").html("");
			$("#summaryEduHour").html("");
			$("#summaryAtndHour").html("");
			$("#summaryAbscHour").html("");
			$("#summaryAtndPercent").html("");
			
			let rowKey = ev.rowKey;
			let row = sbjctList.getRow(rowKey);
			let sbjct_no = sbjctList.getValue(rowKey, 'SBJCT_NO');
			let sbjct_name = sbjctList.getValue(rowKey, 'SBJCT_NM');
			let edu_hour = sbjctList.getValue(rowKey, 'EDU_HR');
			
			$.post({
				url : "/atndStdnt-atndList",
				data : { 
					"id" : id,
					"sbjct_no" : sbjct_no
				},
				dataType : "json"
			}).done(function(data){
				
				atndDetailList.resetData(data.atndList);
				$("#summarySbjctName").html(sbjct_name);
				$("#summaryEduHour").html(edu_hour);
				
				let atnd_hour = data.atndHour.atnd_hour;
				$("#summaryAtndHour").html(atnd_hour);
				$("#summaryAbscHour").html(data.atndHour.notAtnd_hour);
				
				if(atnd_hour){
					let atndPercent = Math.floor( (Number(atnd_hour)) / (Number(edu_hour)) * 100 );
					atndPercent = atndPercent + "" + "%";
					$("#summaryAtndPercent").html(atndPercent);
				}
				
			}).fail(function(xhr){
				alert("문제발생");
			});
			
		});
		
	});
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<!-- Page Content-->
		<div class="mt-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">출결확인</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<!-- Experience Section-->

					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<div class="mt-2">
								<div class="position-relative justify-content-center" style="display: flex; width: 100%; height: 45px;  padding: 10px 0 10px 0; margin: 10px 0;">
									<div style="width: 70px; height: 25px; font-size: 14px; text-align: right; font-weight: bold; line-height: 25px; margin: 0 20px 0 0;">
										학년도
									</div>
									<div id="year" style="width: 50px; height: 25px; margin: 0 10px 0 0; font-size: 15px; text-align:right; line-height:25px; color: black;">
									</div>
									<div id="half" style="width: 50px; height: 25px; margin: 0 10px 0 0; font-size: 15px; text-align:center; line-height:25px; color: black;">
									</div>
									<div style="width: 100px; height: 25px; font-size: 14px; font-weight: bold; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
										훈련과정명</div>
									<div id="crclmName" style="width: 400px; height: 25px; margin: 0 10px 0 0; font-size: 15px; text-align:center; line-height:25px; color: black;">
									</div>
								</div>
							</div>
						</div>
					</div>



					<!-- Divider-->
					<div class="pb-5"></div>
					<!-- Skills Section-->
					<!-- Skillset Card-->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4 ">
	
							<!-- 강의목록 & 출석정보 -->
							<div  class="position-relative" style="display: flex; width: 100%">
							
								<!-- 강의목록 -->
								<div style="width: 60%; height: auto; margin-right:15px;">
									<div class="mt-3 position-relative" style="display: flex; width: 100%; height: 27px;">
										<div style="width: 10px; height: 27px; background-color: #498c5f;">
										</div>
										<div style="width: 80px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
											강의목록</div>
										<div class="position-relative"
											style="display: flex; width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
											<div id="crclmCount"
												style="width: 17px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px;">
												0</div>
											건이 조회되었습니다.
										</div>
									</div>
									<div class="mt-2" style="width: 100%; text-align: center; font-size: 14px;">
										<!-- 강의목록 그리드 -->
										<div id="sbjctList"></div>
									</div>
								</div>
								
								<!-- 출석정보 -->
								<div style="width: 40%; height: auto;">
									<div class="mt-3 position-relative" style="display: flex; width: 100%; height: 27px;">
										<div class="float-start" style="width: 10px; height: 27px; background-color: #498c5f;"></div>
										<div class="float-start" style="width: 100px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
											출석정보</div>
									</div>
									
									<div class="mt-2 summary"
										style="width: 100%; text-align: center; font-size: 14px;">
										<!-- 출석정보 요약 -->
										<table style="width: 100%; height: 60px; font-size:14px; border-top: 1px solid; border-bottom: 1px solid; border-color: #aaaaaa; text-align: center;">
											<thead style="height: 30px; background-color: #f9f9f9;  border-bottom: 1px solid; border-color: #e0e0e0;">
												<tr class="row margin0">
													<th class="col-3">과목</th>
													<th class="col-3">총수업시수</th>
													<th class="col-2">출석시수</th>
													<th class="col-2">결석시수</th>
													<th class="col-2">출석률</th>
												</tr>
											</thead>
											<tbody>
												<tr  class="row margin0">
													<td  class="col-3" id="summarySbjctName"></td>
													<td  class="col-3" id="summaryEduHour"></td>
													<td  class="col-2" id="summaryAtndHour"></td>
													<td  class="col-2" id="summaryAbscHour"></td>
													<td  class="col-2" id="summaryAtndPercent"></td>
												</tr>
											</tbody>
										</table>
									</div>

									<div class="mt-2"
										style="width: 100%; text-align: center; font-size: 14px;">
										<!-- 출석정보 디테일 그리드 -->
										<div class="mt-2" id="atndDetailList"></div>
									</div>
								</div>
							</div>
						</div>
					</div> <!-- 두번째card -->
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
