<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String id = (String) session.getAttribute("id") ; 
if (id != null) {
   if (!session.getAttribute("groupCD").equals("0020")) {
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
		
		const id = '<%= id %>';

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

		const lectureList = new tui.Grid({

			el : document.getElementById('lectureList'),
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
				header : '훈련과정명',
				name : 'CRCLM_NM',
				sortable: true
			}, {
				header : '과목코드',
				name : 'SBJCT_NO',
				width : 80,
				sortable: true
			}, {
				header : '개설과목',
				name : 'SBJCT_NM',
				width : 250,
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
			},{
				header : '수강인원',
				name : 'cls_stdntNum',
				width : 80
			},  {
				header : '강의시간',
				name : 'cls_dayhour',
				width : 200
			}, {
				header : '강의실',
				name : 'ROOM_NM',
				width : 100,
				sortable: true
			} ],
			
			bodyHeight : 150,

		});
		
		const lecDetailList = new tui.Grid({

			el : document.getElementById('lecDetailList'),
			scrollX : true,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
			header : {
				height : 30
			},
			columns : [ {
				header : '주차',
				name : 'WEEK_NUM',
				width : 100,
			}, {
				header : '강의일자',
				name : 'LECT_YMD',
			}, {
				header : '요일',
				name : 'LECT_DAY_CD',
				width : 80,
			}, {
				header : '교시',
				name : 'CLS_CD',
				width : 80,
			}, {
				header : '비고',
				name : 'LECT_ETC',
				width : 80,
			}, {
				header : '출석인원 / 결석인원',
				name : 'ATND_SUM',
				width : 150,
			}, {
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
				hidden : true
			}  ],
			
			
			bodyHeight : 400,
			
		});
		
		const stuAtndList = new tui.Grid({

			el : document.getElementById('stuAtndList'),
			scrollX : false,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 40,
			header : {
				height : 30
			},
			columns : [ {
				header : '학번',
				name : 'STDNT_NO',
				width : 100,
				sortable: true
			}, {
				header : '이름',
				name : 'STDNT_NM',
				width : 80,
				sortable: true
			}, {
				header : '출결구분',
				name : 'ATND_STT',
				editor : {
					type : 'select',
					options: {
						listItems : [
							{
								text : '출석',
								value : '출석'
							},
							{
								text : '지각',
								value : '지각'
							},
							{
								text : '결석',
								value : '결석'
							}
						]
					}
				}
			}, {
				header : '비고',
				name : 'RMRK',
				width : 80,
				editor : 'text'
			} ],
			
			bodyHeight : 360
		});
	
		
// ---- 조회버튼 : 강의목록 ------		
		$("#getCrclmList").click(function(){
			
			//alert("강사아이디 : " + id);
			
			lecDetailList.resetData([]);
			stuAtndList.resetData([]);
			$("#setStuAtnd").prop("disabled", true);
			$("#lecWeekCount").html("0");
			$("#lec_date").html("");
			$("#lec_hour").html("");
			
			let crclm_year = $.trim($("#crclm_year").val());
			let crclm_half = $.trim($("#crclm_half").val());
			//alert("학년도 : " + crclm_year +" / "+ "상하반기 : " + crclm_half);
			
			let searchCrclm = $.trim($("#searchCrclm").val());
			let searchSbjct = $.trim($("#searchSbjct").val());
			let searchInstr = $.trim($("#searchInstr").val());
			//alert("과정명 : " + searchCrclm + " / 과목명 : " + searchSbjct + " / 강사명 : " + searchInstr);
			
			$.post({
				url : "/atndInstr-crclmList",
				data : {
					"id" : id,
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half,
					"searchCrclm" : searchCrclm,
					"searchSbjct" : searchSbjct,
					"searchInstr" : searchInstr
				},
				dataType : "json"
			}).done(function(data){
				//alert("성공");
				lectureList.resetData(data.crclmList);
				$("#crclmCount").html(lectureList.getRowCount());
				
			}).fail(function(xhr){
				alert("문제발생");
			});
			
		});
		
// ---- 강의목록 행 클릭 : 강의주차 출력 ----
		lectureList.on('click',function(ev){
			
			$('#setStuAtnd').prop("disabled", true);
			stuAtndList.resetData([]);
			$("#lec_date").html("");
			$("#lec_hour").html("");
			
			let rowKey = ev.rowKey;
			let row = lectureList.getRow(rowKey);
			let crclm_cd = lectureList.getValue(rowKey, "CRCLM_CD");
			let crclm_year = lectureList.getValue(rowKey, "CRCLM_YEAR");		
			let crclm_half = lectureList.getValue(rowKey, "CRCLM_HALF");
			let sbjct_no = lectureList.getValue(rowKey, "SBJCT_NO");
			//alert(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no);
			
			$.post({
				url : "/atndInstr-weekList",
				data : {
					"crclm_cd" : crclm_cd,
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half,
					"sbjct_no" : sbjct_no
				},
				dataType : "json"
			}).done(function(data){
				
				lecDetailList.resetData(data.weekList);
				$("#lecWeekCount").html(lecDetailList.getRowCount());
				
			}).fail(function(xhr){
				
			});
			
		});

// ---- 강의주차 행 클릭 : 수강생명단 출력 ----
		
		lecDetailList.on('click', function(ev){
			
			$("#setStuAtnd").prop("disabled", false);
			
			let rowKey = ev.rowKey;
			let row = lecDetailList.getRow(rowKey);
			let crclm_cd = lecDetailList.getValue(rowKey, 'CRCLM_CD');
			let crclm_year = lecDetailList.getValue(rowKey, 'CRCLM_YEAR');		
			let crclm_half = lecDetailList.getValue(rowKey, 'CRCLM_HALF');
			let sbjct_no = lecDetailList.getValue(rowKey, 'SBJCT_NO');
			let lec_date = (lecDetailList.getValue(rowKey, 'LECT_YMD')).replace(/-/g, '');
			let lec_day = lecDetailList.getValue(rowKey, 'LECT_DAY_CD');
			let cls_hour = "000" + ((lecDetailList.getValue(rowKey, 'CLS_CD')).substr(0, 1));
			//alert(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no + " / " + lec_date + " / " + lec_day + " / " + cls_hour);
			
			
			
			$.post({
				url : "/atndInstr-stdntList",
				data : {
					"crclm_cd" : crclm_cd,
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half,
					"sbjct_no" : sbjct_no,
					"lec_date" : lec_date,
					"lec_day" : lec_day,
					"cls_hour" : cls_hour
				},
				dataType : "json"
			}).done(function(data){
				
				stuAtndList.resetData(data.stdntList);
				$("#lec_date").html(data.stdntList[0].LECT_YMD);
				$("#lec_hour").html(data.stdntList[0].CLS_CD);
				
			}).fail(function(xhr){
				
			});
			
		});
		
// ---- 출결저장버튼 ----
		$("#setStuAtnd").click(function(){
			
			let lec_date = $("#lec_date").text();
			let lec_hour = $("#lec_hour").text();
			
			let dt_focusedCell = lecDetailList.getFocusedCell();
			let dt_focusedRow = lecDetailList.getRow(dt_focusedCell.rowKey);
			//console.log(dt_focusedCell);
			
			if(confirm(lec_date + " " + lec_hour + " 출결을 저장하시겠습니까?")){
				
				
				let crclm_cd = dt_focusedRow.CRCLM_CD;
				let crclm_year = dt_focusedRow.CRCLM_YEAR;
				let crclm_half = dt_focusedRow.CRCLM_HALF;
				let sbjct_no = dt_focusedRow.SBJCT_NO;
				let lect_ymd = (dt_focusedRow.LECT_YMD).replace(/-/g, '');
				let cls_cd = "000" + ((dt_focusedRow.CLS_CD).substr(0, 1));
				
				var stuAtndData = stuAtndList.getData();
				var stuAtndArr = [];
				
				for(let i = 0; i < stuAtndData.length; i++){
					
					let stdnt_no = stuAtndData[i].STDNT_NO;
					let atnd_stt = stuAtndData[i].ATND_STT;
					
					if(atnd_stt == '출석'){
						atnd_stt = '0010';
					} else if(atnd_stt == '지각'){
						atnd_stt = '0020';
					} else if(atnd_stt == '결석'){
						atnd_stt = '0030';
					}
					
					let rmrk = stuAtndData[i].RMRK;
					
					stuAtndArr.push({
						"crclm_cd" : crclm_cd,
						"crclm_year" : crclm_year,
						"crclm_half" : crclm_half,
						"sbjct_no" : sbjct_no,
						"lect_ymd" : lect_ymd,
						"cls_cd" : cls_cd,
						"stdnt_no" : stdnt_no,
						"atnd_stt" : atnd_stt,
						"rmrk" : rmrk
					});
				}
				
				function setStuAtnd(){
					return new Promise(function(resolve, reject){
						$.post({
							url : "/atndInstr-stuAtnd",
							data : JSON.stringify(stuAtndArr),
							contentType : "application/json"
						}).done(function(data){
							alert("저장이 완료되었습니다.");
							resolve();
						}).fail(function(xhr){
							alert("문제발생");
							
						});
					});
				}
				
				function reloadList(){
					
					let lec_focusedCell = lectureList.getFocusedCell();
					let lec_rowKey = lec_focusedCell.rowKey;
					//console.log("lec_focusedCell : " + lec_focusedCell.rowKey);
					
					let row = lectureList.getRow(lec_rowKey);
					let crclm_cd = lectureList.getValue(lec_rowKey, 'CRCLM_CD');
					let crclm_year = lectureList.getValue(lec_rowKey, 'CRCLM_YEAR');		
					let crclm_half = lectureList.getValue(lec_rowKey, 'CRCLM_HALF');
					let sbjct_no = lectureList.getValue(lec_rowKey, 'SBJCT_NO');
					//console.log(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no);
					
					$.post({
						url : "/atndInstr-weekList",
						data : {
							"crclm_cd" : crclm_cd,
							"crclm_year" : crclm_year,
							"crclm_half" : crclm_half,
							"sbjct_no" : sbjct_no
						},
						dataType : "json"
					}).done(function(data){
						
						lecDetailList.resetData(data.weekList);
						lecDetailList.focus(dt_focusedCell.rowKey, 'LECT_YMD', true);
						
					}).fail(function(xhr){
						
					});
					
					return "";
				}
				
				setStuAtnd().then(reloadList);
			
			}
			
		});
		
		
		
	});
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/instrtopbar.jsp"%>
		<!-- Page Content-->
		<div class="mt-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">출결관리</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<!-- Experience Section-->

					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<div class="mt-2">
								<div class="position-relative justify-content-center" style="display: flex; width: 100%; height: 45px; font-weight: bold; padding: 10px 0 10px 0; margin: 10px 0;">
									<div style="width: 70px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 10px 0 0;">
										학년도
									</div>
									<div style="width: 100px; height: 30px; margin: 0 10px 0 0;">
										<input type="number" value="2023" class="form-control" name="year" id="crclm_year" style="height: 25px; font-size: 13px;">
									</div>
									<div style="width: 100px; height: 25px; margin: 0 20px 0 0;">
										<select class="form-select form-select-sm" name="half" id="crclm_half" aria-label="Default select example" style="height: 25px; font-size: 13px; padding: 0 0 0 10px;">
											<option value="0010">상반기</option>
											<option value="0020">하반기</option>
										</select>
									</div>
									<div style="width: 100px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
										훈련과정명</div>
									<div>
										<div style="width: 300px; height: 30px; margin: 0 10px;">
											<input type="text" class="form-control" id="searchCrclm" style="height: 25px; font-size: 13px;">
										</div>
									</div>
									<!-- 
									<div style="width: 50px; height: 30px;">
										<i class="fa-solid fa-magnifying-glass" id="searchCrclmBtn" style="cursor: pointer;"></i>
									</div>
									 -->
									<div style="width: 80px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 10px;">
										강의과목</div>
									<div>
										<div style="width: 150px; height: 30px; margin: 0 10px;">
											<input type="text" class="form-control" id="searchSbjct"
												style="height: 25px; font-size: 13px;">
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
					<div class="pb-4"></div>
					<!-- Skillset Card-->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4 ">
	
							<!-- 강의목록 -->
							<div  style=" width: 100%; margin-right:15px;">
								<div class="mt-3 position-relative" style="display: flex; width: 100%;">
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
									<!-- 강의목록 그리드 -->
								</div>
								<div>
									<div class="mt-2" id="lectureList"></div>
								</div>
							</div>
							
							<!-- 출석부 & 수강생명단 -->
							<div  class="mt-3 position-relative" style="display: flex; width: 100%">
							
								<!-- 출석부 -->
								<div style="width: 60%; height: auto; margin-right:15px;">
									<div class="mt-3 position-relative" style="display: flex; width: 100%; height: 27px;">
										<div style="width: 10px; height: 27px; background-color: #498c5f;">
										</div>
										<div style="width: 80px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
											강의주차</div>
										<div class="position-relative"
											style="display: flex; width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
											<div id="lecWeekCount"
												style="width: 17px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px;">
												0</div>
											건이 조회되었습니다.
										</div>
									</div>
									<div class="mt-2" style="width: 100%; text-align: center; font-size: 14px;">
										<!-- 출석정보 그리드 -->
										<div id="lecDetailList"></div>
									</div>
								</div>
							
								<!-- 수강생명단 -->
								<div style="width: 40%; height: auto;">
									<div class="mt-3 position-relative" style="display: flex; width: 100%; height: 27px;">
										<div class="float-start" style="width: 10px; height: 27px; background-color: #498c5f;"></div>
										<div class="float-start" style="width: 100px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
											수강생명단</div>
										<div style="width: 300px; height: 30px; font-size: 13px; color: #a3a3a7; line-height: 15px; margin: 0 10px; color: red;">
											초기 출결상태는 '출석'입니다.<br> 수정 후 출결저장을 눌러야 저장됩니다.
										</div>
										<div class="position-absolute end-0" style="width: auto; color: #a3a3a7;">
											<button type="button" id="setStuAtnd" class="btn btn-secondary" style="height: 27px; font-size: 13px; padding: 0 10px;"
												disabled>출결저장
											</button>
										</div>
									</div>

									<div class="mt-2"
										style="width: 100%; text-align: center; font-size: 14px;">
										<div class="mt-2 position-relative"
											style="display: flex; width: 100%; height: 30px; line-height: 27px; padding: 0 20px; font-weight: bold; font-size: 14px; background-color: #f9f9f9; border-style: solid; border-width: 1px; border-color: lightgray;">
											<div style="width: 80px; text-align: center;">강의일자</div>
											<div id="lec_date"
												style="width: 230px; text-align: center; color: #08559c;"></div>
											<div style="width: 50px; text-align: center;">교시</div>
											<div id="lec_hour"
												style="width: 150px; text-align: center; color: #08559c;"></div>
										</div>
										<!-- 수강생명단 그리드 -->
										<div class="mt-2" id="stuAtndList"></div>
									</div>
								</div>
								<!-- 수강생명단 -->
							</div><!-- 강의주차 & 수강생명단 -->
						</div>
					</div> <!-- 두번째card -->
					
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
