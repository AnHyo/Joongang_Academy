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
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" /> <!-- 그리드 -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"> <!-- xeicon -->
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />

<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

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
</style>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<!-- 그리드 -->
<script type="text/javascript">

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
					background : '#f2f2f2',
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
			//rowHeaders : ['checkbox'],
			header : {
				height : 30
			},
			columns : [ {
				header : '훈련과정코드',
				name : 'crclm_cd',
				hidden : true
			},{
				header : '학년도',
				name : 'crclm_year',
				hidden : true
			}, {
				header : '기간',
				name : 'crclm_half',
				hidden : true
			}, {
				header : '훈련과정명',
				name : 'crclm_name',
			}, {
				header : '과목코드',
				name : 'sbjct_no',
				width : 80,
			}, {
				header : '개설과목',
				name : 'sbjct_name',
				width : 350,
			}, {
				header : '필수구분',
				name : 'esntl_yn',
				width : 80
			},{
				header : '강의시수',
				name : 'edu_hr',
				width : 80
			},{
				header : '수강인원',
				name : 'cls_stdntNum',
				width : 80
			}, {
				header : '담당강사',
				name : 'instr_name',
				width : 200
			}, {
				header : '강의시간',
				name : 'cls_dayhour',
				width : 300
			}, {
				header : '강의실',
				name : 'cls_room',
				width : 150
			} ],
			
			bodyHeight : 230,

		});
		
		const atndList = new tui.Grid({

			el : document.getElementById('atndList'),
			scrollX : true,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
			header : {
				height : 30
			},
			columns : [ {
				header : '학번',
				name : 'stdnt_no',
				width : 120,
			}, {
				header : '이름',
				name : 'stdnt_name',
				width : 100,
			}, {
				header : '출석시수',
				name : 'atnd_hour',
				width : 70,
			},{
				header : '결석시수',
				name : 'notAtnd_hour',
				width : 70,
			}, {
				header : '훈련과정코드',
				name : 'crclm_cd',
				hidden : true
			},{
				header : '학년도',
				name : 'crclm_year',
				hidden : true
			}, {
				header : '기간',
				name : 'crclm_half',
				hidden : true
			}, {
				header : '과목코드',
				name : 'sbjct_no',
				hidden : true
			}  ],
			
			bodyHeight : 230,
			
			columnStyles: {
			    age: {
			      fontSize: '16px'
			    }
			}
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
				header : '강의일자',
				name : 'lec_day',
				width : 100
			}, {
				header : '교시',
				name : 'cls_hour',
				width : 70,
			}, {
				header : '출결구분',
				name : 'atnd_stt',
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
				},
				copyOptions: {
	          	  useListItemText: true // 왜 안되지.. when this option is used, the copy value is concatenated text
	         	}
			} ],
			
			bodyHeight : 191
		});
		
		
// ---- 조회버튼 : 강의목록 ------		
		$("#getCrclmList").click(function(){
			
			atndList.resetData([]);
			atndList.getColumns().splice(8);
			stuAtndList.resetData([]);
			$("#stdnt_no").text('');
			$("#stdnt_name").text('');
			$("#setStuAtnd").prop('disabled', true);
			
			$("#delCrclmList").prop("disabled", false);
			$("#saveCrclmList").prop("disabled", false);
			
			let crclm_year = $.trim($("#crclm_year").val());
			let crclm_half = $.trim($("#crclm_half").val());
			alert("학년도 : " + crclm_year +" / "+ "상하반기 : " + crclm_half);
			
			let searchCrclm = $.trim($("#searchCrclm").val());
			let searchSbjct = $.trim($("#searchSbjct").val());
			let searchInstr = $.trim($("#searchInstr").val());
			alert("과정명 : " + searchCrclm + " / 과목명 : " + searchSbjct + " / 강사명 : " + searchInstr);
			
			$.post({
				url : "/atndCrclmList",
				data : {
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
			}).fail(function(xhr){
				alert("문제발생");
			});
			
		});
		
// ---- 강의목록 행 클릭 ----
		lectureList.on('click', function(ev){
			
			$("#setStuAtnd").prop('disabled', true);
			
			let rowKey = ev.rowKey;
			let row = lectureList.getRow(rowKey);		// 행
			let crclm_cd = lectureList.getValue(rowKey, 'crclm_cd');			// 해당 행의 hidden 컬럼을 가져오기.
			let crclm_year = lectureList.getValue(rowKey, 'crclm_year');		
			let crclm_half = lectureList.getValue(rowKey, 'crclm_half');
			let sbjct_no = lectureList.getValue(rowKey, 'sbjct_no');
			alert(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no);
			
			$.post({
				url : "/atndList",
				data : {
					"crclm_cd" : crclm_cd,
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half,
					"sbjct_no" : sbjct_no
				},
				dataType : "json"
			}).done(function(data){
				//alert("성공");
				
				// 개인출결리스트 초기화
				$("#stdnt_no").html('');
				$("#stdnt_name").html('');
				stuAtndList.resetData([]);
				
				let atndColumns = atndList.getColumns();
				
				// 새 컬럼을 추가했더니 기존 컬럼의 너비가 변경됨.. 다시 지정
				atndColumns[0].width = 120;
				atndColumns[1].width = 100;
				atndColumns[2].width = 70;
				atndColumns[3].width = 70;
				
				
				atndColumns.splice(8);
				
			// ------- 강의날짜 추가 ---------
				let dayList = data.dayList;
				
				let dayColumns = dayList.map(day => ({
 					//header : day.lec_day,
					name : day.lec_day,
					width: 50,
				}));
				
				let newColumns = atndColumns.concat(dayColumns);
				
				atndList.setColumns(newColumns);
				
			// ------- 학생리스트 출력(학번+이름+출석시수+결석시수) ---------
				atndList.resetData(data.stdntList);
			
			// ------- 날짜별 출석 --------
				let dayAtndList = data.dayAtndList;
			
				let rowCount = atndList.getRowCount();
				//console.log(rowCount);
				//console.log(newColumns.find(col => col.name == '01.03')); 
				
				for (let i = 0; i < dayAtndList.length; i++) {
					let dayAtnd = dayAtndList[i];
					//console.log("dayAtnd : " + (JSON.stringify(dayAtnd)));
					
					let stdnt_no = dayAtnd.STDNT_NO;
					let lec_day = dayAtnd.lec_day;
					let atnd_day = Number(dayAtnd.ATND_DAY);
					
					if(atnd_day == 2){
						atnd_day = ' ';
					} else if (atnd_day == 3){
						atnd_day = '△';
					} else if (atnd_day > 3 && atnd_day < 7){
						atnd_day = 'X';
					}
					
					let findColumn = atndList.getColumns().find(col => col.name == lec_day);
					let dayColumn = findColumn.name;
					
					let findRow = atndList.findRows(row => row.stdnt_no == stdnt_no);
					let rowKey = findRow[0].rowKey;
					//console.log(stdnt_name + " / " + lec_day + " / " + atnd_day);
					//console.log("dayColumn : " + (JSON.stringify(dayColumn)));
					//console.log("findRow : " + (JSON.stringify(findRow)));
					//console.log("rowKey : " + rowKey);
					
					atndList.setValue(rowKey, dayColumn, atnd_day);
					
				}
			
			}).fail(function(xhr){
				alert("문제발생");
			});
		});

// ---- 학생목록 행 클릭 ----
		atndList.on('click', function(ev){
			
			let rowKey = ev.rowKey;
			let row = atndList.getRow(rowKey);		// 행
			let crclm_cd = atndList.getValue(rowKey, 'crclm_cd');			// 해당 행의 hidden 컬럼을 가져오기.
			let crclm_year = atndList.getValue(rowKey, 'crclm_year');		
			let crclm_half = atndList.getValue(rowKey, 'crclm_half');
			let sbjct_no = atndList.getValue(rowKey, 'sbjct_no');
			let stdnt_no = atndList.getValue(rowKey, 'stdnt_no');
			let stdnt_name = atndList.getValue(rowKey, 'stdnt_name');
			let columnName = ev.columnName;
			
			let lectureDay = crclm_year + columnName.replace('.','');
			alert(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no + " / " + stdnt_no + " / " + lectureDay);
			
			$("#stdnt_no").html(stdnt_no);
			$("#stdnt_name").html(stdnt_name);
			
			$.post({
				url : "/stuAtndList",
				data : {
					"crclm_cd" : crclm_cd,
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half,
					"sbjct_no" : sbjct_no,
					"stdnt_no" : stdnt_no,
					"lectureDay" : lectureDay
				},
				dataType : "json"
			}).done(function(data){
				//alert("성공");

				stuAtndList.resetData(data.stuAtndList);
				if(stuAtndList.getData().length != 0){
					$("#setStuAtnd").prop('disabled', false);
				} else {
					$("#setStuAtnd").prop('disabled', true);
				}
				
			}).fail(function(xhr){
				alert("문제발생");
			}); 
			
		});

// ---- 출결저장버튼 클릭 ----
		$("#setStuAtnd").click(function(){
			
			let count = 0;
			const stuAtndData = stuAtndList.getData();
			//console.log(stuAtndData);
			
			const STDNT_NO = $("#stdnt_no").text();
			if(STDNT_NO != ''){
			
				if(confirm("저장하시겠습니까?")){
					//alert("!");
					
					for(let i = 0; i < stuAtndData.length; i++){
						
						let CRCLM_CD = stuAtndData[i].CRCLM_CD;
						let CRCLM_YEAR = stuAtndData[i].CRCLM_YEAR;
						let CRCLM_HALF = stuAtndData[i].CRCLM_HALF;
						let SBJCT_NO = stuAtndData[i].SBJCT_NO;
						let lec_day = CRCLM_YEAR + (stuAtndData[i].lec_day).replace('.','');
						let cls_hour = '000' + (stuAtndData[i].cls_hour).substr(0,1);
						let atnd_stt = stuAtndData[i].atnd_stt;
						
						if(atnd_stt == '출석'){
							atnd_stt = '0010';
						} else if(stuAtndData[i].atnd_stt == '지각'){
							atnd_stt = '0020';
						} else {
							atnd_stt = '0030';
						}
							
						$.post({
							url : "/setStuAtnd",
							data : {
								"STDNT_NO" : STDNT_NO,
			 					"CRCLM_CD" : CRCLM_CD,
								"CRCLM_YEAR" : CRCLM_YEAR,
								"CRCLM_HALF" : CRCLM_HALF,
								"SBJCT_NO" : SBJCT_NO,
								"lec_day" : lec_day,
								"cls_hour" : cls_hour,
								"atnd_stt" : atnd_stt
							},
							dataType : "json",
							async: false
						}).done(function(data){
							count+=1;
							alert(count);
						}).fail(function(xhr){
						
						});
					}
					
					if(count == stuAtndData.length){
						alert("저장이 완료되었습니다.");
						
						let lec_focusedCell = lectureList.getFocusedCell();
						let lec_rowKey = lec_focusedCell.rowKey;
						//console.log("lec_focusedCell : " + lec_focusedCell.rowKey);
						
						let row = lectureList.getRow(lec_rowKey);		// 행
						let crclm_cd = lectureList.getValue(lec_rowKey, 'crclm_cd');			// 해당 행의 hidden 컬럼을 가져오기.
						let crclm_year = lectureList.getValue(lec_rowKey, 'crclm_year');		
						let crclm_half = lectureList.getValue(lec_rowKey, 'crclm_half');
						let sbjct_no = lectureList.getValue(lec_rowKey, 'sbjct_no');
						//console.log(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no);
						
						$.post({
							url : "/atndList",
							data : {
								"crclm_cd" : crclm_cd,
								"crclm_year" : crclm_year,
								"crclm_half" : crclm_half,
								"sbjct_no" : sbjct_no
							},
							dataType : "json"
						}).done(function(data){
							
							// ------- 학생리스트 출력(학번+이름+출석시수+결석시수) ---------
							atndList.resetData(data.stdntList);
							
							// ------- 날짜별 출석 --------
							let dayAtndList = data.dayAtndList;
						
							let rowCount = atndList.getRowCount();
							
							for (let i = 0; i < dayAtndList.length; i++) {
								let dayAtnd = dayAtndList[i];
								
								let stdnt_no = dayAtnd.STDNT_NO;
								let lec_day = dayAtnd.lec_day;
								let atnd_day = Number(dayAtnd.ATND_DAY);
								
								if(atnd_day == 2){
									atnd_day = ' ';
								} else if (atnd_day == 3){
									atnd_day = '△';
								} else if (atnd_day > 3 && atnd_day < 7){
									atnd_day = 'X';
								}
								
								let findColumn = atndList.getColumns().find(col => col.name == lec_day);
								let dayColumn = findColumn.name;
								
								let findRow = atndList.findRows(row => row.stdnt_no == stdnt_no);
								let rowKey = findRow[0].rowKey;
								
								atndList.setValue(rowKey, dayColumn, atnd_day);
								
							}
						
						}).fail(function(xhr){
							alert("문제발생");
						});
					
					} else {
						alert("문제발생");
					}
				}
			} 
		});		
		
// ---- 출석부생성 버튼 ----		
		$("#createAtndList").click(function(){
			
			let crclm_year = $.trim($("#crclm_year").val());
			let crclm_half = $.trim($("#crclm_half").val());
			let crclm_half_name = $.trim($("#crclm_half option:checked").text());
			
			if(confirm(crclm_year + "학년도 " + crclm_half_name + "의 모든 훈련과정의 출석부를 생성하시겠습니까?")){
				
				// 해당 연도,상하반기의 수강신청 기간 종료여부
				
				function checkSchdlYN(){
					return new Promise(function(resolve, reject){
						$.post({
							url : "/checkSchdlYN",
							data : {
								"crclm_year" : crclm_year,
								"crclm_half" : crclm_half
							},
							dataType : "json"
						}).done(function(data){
							//alert(data.checkYN);
							if(data.checkYN != '1'){
								alert("출석부를 생성할 수 없습니다. \n" + crclm_year + "학년도 " + crclm_half_name + "의 수강신청일정을 확인하여 주세요.");
							} else {
								resolve();
							}
						}).fail(function(xhr){
							reject();
						});
					});
				}
				
				function createAtnd(){
					//alert("!!!!!");
					$.post({
						url : "/createAtnd",
						data : {
							"crclm_year" : crclm_year,
							"crclm_half" : crclm_half
						},
						dataType : "json"
					}).done(function(data){
						alert("생성성공!");
					}).fail(function(xhr){
						
					});
					return alert("출석부 생성을 완료했습니다.");
				}
				
				checkSchdlYN().then(createAtnd);
				
				
			}
			
		});
		
		
	});
	
</script>
</head>
<body class="sb-nav-fixed">
	<%-- 	<%@include file="../bar/topbar.jsp"%> --%>
	<!-- 	<div id="layoutSidenav"> -->
	<%-- 	<%@include file="../bar/sidebar.jsp"%> --%>
	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<div class="mt-4 position-relative row">
					<div style="width: 30px;">
						<img src="./image/joongang_logo.png" style="width: 25px;">
					</div>
					<div style="width: 200px; height: 30px;">
						<h5 style="font-weight: bold; color: #565757; line-height: 35px;">강의출결관리</h5>
					</div>
				</div>

				<div class="mt-2 mb-1"
					style="width: 100%; height: 1px; background-color: #c1c2c2;"></div>

				<div class="mt-2 marginPadding0 position-relative"
					style="width: 100%; height: 31px;">
					<div class="float-start"
						style="width: 300px; height: auto; padding: 0;">
						<button type="button" id="createAtndList" class="btn btn-sm btn-secondary">출석부생성</button>
						<button type="button" class="btn btn-sm btn-secondary">출석부출력</button>
						<button type="button" class="btn btn-sm btn-secondary">수강신청명단</button>
					</div>
					<div class="float-end"
						style="width: 50px; height: auto; padding: 0;">
						<button type="button" id="getCrclmList"
							class="btn btn-sm btn-secondary">조회</button>
						<!-- 
						<button type="button" id="delCrclmList"
							class="btn btn-sm btn-secondary" disabled>삭제</button>
						<button type="button" id="saveCrclmList"
							class="btn btn-sm btn-secondary" disabled>저장</button>
						-->
					</div>
				</div>

				<div class="mt-2">
					<div class="position-relative justify-content-center" style="display: flex; width: 100%; height: 45px; font-weight: bold; padding: 10px 0 10px 0; background-color: #eef4f8;">
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
							훈련과정명
						</div>
						<div>
							<div style="width: 300px; height: 30px; margin: 0 10px;">
								<input type="text" class="form-control" id="searchCrclm" style="height: 25px; font-size: 13px;">
							</div>
						</div>
						<div style="width:50px; height:30px;">
							<i class="fa-solid fa-magnifying-glass" id="searchCrclmBtn" style="cursor:pointer;"></i>
						</div>
						<div style="width: 100px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
							개설과목
						</div>
						<div>
							<div style="width: 150px; height: 30px; margin: 0 10px;">
								<input type="text" class="form-control" id="searchSbjct" style="height: 25px; font-size: 13px;">
							</div>
						</div>
						<div style="width: 100px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
							담당강사
						</div>
						<div>
							<div style="width: 150px; height: 30px; margin: 0 10px;">
								<input type="text" class="form-control" id="searchInstr" style="height: 25px; font-size: 13px;">
							</div>
						</div>
					</div>
				</div>

				<div class="mt-3 position-relative"
					style="display: flex; width: 100%; height: 27px;">
					<div style="width: 10px; height: 27px; background-color: #498c5f;">
					</div>
					<div
						style="width: 80px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
						강의목록</div>
					<div
						style="width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
						00건이 조회되었습니다.</div>
				</div>

				<div style="width: 100%; height: auto;">
					<!-- 강의목록 그리드 -->
					<div class="mt-2" id="lectureList"></div>
					<div class="mt-3 position-relative" style="display: flex;">
						<div style="width: 74%; height: auto; margin-right: 15px;">
							<div class="position-relative"
								style="display: flex; width: 100%; height: 27px;">
								<div
									style="width: 10px; height: 27px; background-color: #498c5f;">
								</div>
								<div
									style="width: 80px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
									출석정보</div>
								<div
									style="width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
									00건이 조회되었습니다.</div>
							</div>
							<div class="mt-2"
								style="width: 100%; text-align: center; font-size: 14px;">
								<!-- 출석정보 그리드 -->
								<div id="atndList"></div>
							</div>
						</div>
						<div style="width: 26%; height: auto;">
							<div class="position-relative"
								style="display: flex; width: 100%; height: 27px;">
								<div class="float-start"
									style="width: 10px; height: 27px; background-color: #498c5f;"></div>
								<div class="float-start"
									style="width: 70px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
									개인출결</div>
								<div
									style="width: 300px; height: 30px; font-size: 13px; color: #a3a3a7; line-height: 15px; margin: 0 10px; color: red;">
									초기 출결상태는 '출석'입니다.<br> 수정 후 출결저장을 눌러야 저장됩니다.
								</div>
								<div class="position-absolute end-0"
									style="width: auto; color: #a3a3a7;">
									<button type="button" id="setStuAtnd" class="btn btn-secondary"
										style="height: 27px; font-size: 13px; padding: 0 10px;" disabled>
										출결저장</button>
								</div>
							</div>
							<div class="mt-2 position-relative"
								style="display: flex; width: 100%; height: 30px; line-height: 27px; padding: 0; font-weight: bold; font-size: 14px; border: solid 1px; background-color: lightgray;">
								<div style="width: 50px; text-align: center;">학번</div>
								<div id="stdnt_no"
									style="width: 150px; text-align: center; color: navy;"></div>
								<div style="width: 50px; text-align: center;">이름</div>
								<div id="stdnt_name"
									style="width: 150px; text-align: center; color: navy;"></div>
							</div>
							<div class="mt-2"
								style="width: 100%; text-align: center; font-size: 14px;">
								<!-- 개인출결 그리드 -->
								<div id="stuAtndList"></div>
							</div>
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
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
	<!-- 그리드 -->
</body>
</html>
