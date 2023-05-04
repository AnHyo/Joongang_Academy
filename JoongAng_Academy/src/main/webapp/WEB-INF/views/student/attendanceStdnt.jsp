<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
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

<style type="text/css">
.tui-grid-cell {
	font-size: 13px;
}

.marginPadding0 {
	margin: 0;
	padding: 0;
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
			}, {
				header : '필수구분',
				name : 'ESNTL_YN',
				width : 80,
			}, {
				header : '과목명',
				name : 'SBJCT_NM',
				width : 200,
			}, {
				header : '담당강사',
				name : 'KORN_FLNM',
				width : 80
			}, {
				header : '강의시간',
				name : 'cls_dayhour',
				width : 180
			}, {
				header : '강의실',
				name : 'ROOM_NM',
				width : 100
			} ],
			
			bodyHeight : 500,

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
				name : 'WEEK_NUM',
				width : 70
			}, {
				header : '수업일자',
				name : 'LECT_YMD',
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
				width : 70
			}, {
				header : '비고',
				name : 'RMRK',
				width : 70
			} ],
			
			bodyHeight : 500,

		});
		
// ---- 내 정보	----	
		const id = '<%= id %>';
		
		$.post({
			url : "/atnd_stdntInfo",
			data : { "id" : id },
			dataType : "json"
		}).done(function(data){
			$("#year").html(data.stdntInfo.CRCLM_YEAR);
			$("#half").html(data.stdntInfo.CRCLM_HALF);
			$("#crclmName").html(data.stdntInfo.CRCLM_NM);
		}).fail(function(xhr){
			
		});
				
// ---- 조회버튼 : 강의목록 ------		
		$("#getCrclmList").click(function(){
			
			alert("학생아이디 : " + id)
			atndDetailList.resetData([]);
			
			let searchSbjct = $.trim($("#searchSbjct").val());
			alert("과목명 : " + searchSbjct);
			
			$.post({
				url : "/atndStdnt_sbjctList",
				data : {
					"id" : id,
					"searchSbjct" : searchSbjct,
				},
				dataType : "json"
			}).done(function(data){
				//alert("성공");
				sbjctList.resetData(data.sbjctList);
				
			}).fail(function(xhr){
				alert("문제발생");
			});
			
		});

// ---- 강의목록 행 클릭 ----
		sbjctList.on('click',function(ev){
			
			let rowKey = ev.rowKey;
			let row = sbjctList.getRow(rowKey);
			let crclm_cd = sbjctList.getValue(rowKey, 'CRCLM_CD');
			let crclm_year = sbjctList.getValue(rowKey, 'CRCLM_YEAR');		
			let crclm_half = sbjctList.getValue(rowKey, 'CRCLM_HALF');
			let sbjct_no = sbjctList.getValue(rowKey, 'SBJCT_NO');
			alert(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no);
			
			$.post({
				url : "/atndStdnt_atndList",
				data : { "id" : id },
				dataType : "json"
			}).done(function(data){
				
				atndDetailList.resetData(data.atndList);
				
			}).fail(function(xhr){
				
			});
			
		});
		
		
		
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

					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<div class="mt-2">
								<div class="position-relative justify-content-center" style="display: flex; width: 100%; height: 45px; font-weight: bold; padding: 10px 0 10px 0; margin: 10px 0;">
									<div style="width: 70px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 20px 0 0;">
										학년도
									</div>
									<div id="year" style="width: 50px; height: 25px; margin: 0 10px 0 0; font-size: 15px; text-align:right; line-height:25px; color: blue;">
									</div>
									<div id="half" style="width: 50px; height: 25px; margin: 0 10px 0 0; font-size: 15px; text-align:center; line-height:25px; color: blue;">
									</div>
									<div style="width: 100px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
										훈련과정명</div>
									<div id="crclmName" style="width: 400px; height: 25px; margin: 0 10px 0 0; font-size: 15px; text-align:center; line-height:25px; color: blue;">
									</div>
									<!-- 
									<div>
										<div style="width: 300px; height: 30px; margin: 0 10px;">
											<input type="text" class="form-control" id="searchCrclm" style="height: 25px; font-size: 13px; " readOnly>
										</div>
									</div>
									 -->
									<div style="width: 60px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 10px;">
										과목명</div>
									<div>
										<div style="width: 150px; height: 30px; margin: 0 10px;">
											<input type="text" class="form-control" id="searchSbjct" style="height: 25px; font-size: 13px;">
										</div>
									</div>
									<div class="float-end" style="width: 75px; height: auto; padding: 0; margin: 0 0 0 40px;">
										<button type="button" id="getCrclmList" class="btn btn-secondary"
											style="width: 75px; height: 25px; font-size: 14px; line-height: 5px; margin-top:-3px;">
											조회
										</button>
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
										<div style="width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
											00건이 조회되었습니다.</div>
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

									<div class="mt-2"
										style="width: 100%; text-align: center; font-size: 14px;">
										<!-- 출석정보 요약 그리드 -->
										<!-- 
										<table style="width: 100%; border-style: solid; border-width: 1px;">
											<thead>
												<tr>
													<th>총훈련일수</th>
													<th>실시일수</th>
													<th>출석일</th>
													<th>결석일</th>
													<th>출석률</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</tbody>
										</table>
										 -->
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
