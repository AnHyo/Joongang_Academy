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
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />

<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<style type="text/css">

.tui-grid-cell {
  font-size: 13px;
}

.marginPadding0{
	margin:0;
	padding:0;
}

.textheight25{
	height:25px;
}

.tui-grid-cell-content {
	text-align: center;
}

.tui-grid-body-area {
	cursor: pointer;
	text-align: center;
}

</style>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> <!-- 그리드 -->
<script type="text/javascript">

	$(function() {
		
		$("#delCrclmList").prop("disabled", true);
		$("#saveCrclmList").prop("disabled", true);

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
			rowHeaders : ['checkbox'],
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
				width : 300,
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
				width : 150
			}, {
				header : '강의시간',
				name : 'cls_dayhour',
				width : 200
			}, {
				header : '강의실',
				name : 'cls_room',
				width : 100
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
				name : 'notatnd_hour',
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
		
		
// ---- 강의목록 ------		
		$("#getCrclmList").click(function(){
			
			$("#delCrclmList").prop("disabled", false);
			$("#saveCrclmList").prop("disabled", false);
			
			let crclm_year = $.trim($("#crclm_year").val());
			let crclm_half = $.trim($("#crclm_half").val());
			alert("학년도 : " + crclm_year +" / "+ "상하반기 : " + crclm_half);
			
			$.post({
				url : "/atndCrclmList",
				data : {
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half
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
			var rowKey = ev.rowKey;
			var row = lectureList.getRow(rowKey);		// 행
			var crclm_cd = lectureList.getValue(rowKey, 'crclm_cd');			// 해당 행의 hidden 컬럼을 가져오기.
			var crclm_year = lectureList.getValue(rowKey, 'crclm_year');		
			var crclm_half = lectureList.getValue(rowKey, 'crclm_half');
			var sbjct_no = lectureList.getValue(rowKey, 'sbjct_no');
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
				
				const atndColumns = atndList.getColumns();
				
				// 새 컬럼을 추가했더니 기존 컬럼의 너비가 변경됨.. 다시 지정
				atndColumns[0].width = 120;
				atndColumns[1].width = 100;
				atndColumns[2].width = 70;
				atndColumns[3].width = 70;
				
				
				atndColumns.splice(8);
				
			// ------- 강의날짜 추가 ---------
				var dayList = data.dayList;
				
				const dayColumns = dayList.map(day => ({
 					//header : day.lec_day,
					name : day.lec_day,
					width: 50,
				}));
				
				const newColumns = atndColumns.concat(dayColumns);
				
				atndList.setColumns(newColumns);
				
			// ------- 학생리스트 출력 ---------
				atndList.resetData(data.stdntList);
			
			}).fail(function(xhr){
				alert("문제발생");
			});
		});
		
		
		const stuAtndList = new tui.Grid({

			el : document.getElementById('stuAtndList'),
			scrollX : false,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
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
				renderer : 'select'
			} ],
			
			bodyHeight : 191
		});
		
		const atndSelectOptions = ['출석', '지각', '결석'].map((atnd) => ({text : atnd, value : atnd}));
		
		stuAtndList.on('beforeDispatchEvent', function (ev) {
			  if (ev.type === 'click') {
			    const target = ev.target;
			    if (target.tagName !== 'SELECT') {
			      return;
			    }
			    const rowKey = target.parentNode.getAttribute('rowKey');
			    stuAtndList.setValue(rowKey, 'atnd_stt', target.value);
			  }
			});
		
		

// ---- 학생목록 행 클릭 ----
		atndList.on('click', function(ev){
			var rowKey = ev.rowKey;
			var row = atndList.getRow(rowKey);		// 행
			var crclm_cd = atndList.getValue(rowKey, 'crclm_cd');			// 해당 행의 hidden 컬럼을 가져오기.
			var crclm_year = atndList.getValue(rowKey, 'crclm_year');		
			var crclm_half = atndList.getValue(rowKey, 'crclm_half');
			var sbjct_no = atndList.getValue(rowKey, 'sbjct_no');
			var stdnt_no = atndList.getValue(rowKey, 'stdnt_no');
			var stdnt_name = atndList.getValue(rowKey, 'stdnt_name');
			alert(crclm_cd + " / " + crclm_year + " / " + crclm_half + " / " + sbjct_no + " / " + stdnt_no);
			
			$("#stdnt_no").html(stdnt_no);
			$("#stdnt_name").html(stdnt_name);
			
			
			$.post({
				url : "/stuAtndList",
				data : {
					"crclm_cd" : crclm_cd,
					"crclm_year" : crclm_year,
					"crclm_half" : crclm_half,
					"sbjct_no" : sbjct_no,
					"stdnt_no" : stdnt_no
				},
				dataType : "json"
			}).done(function(data){
				alert("성공");
				//stuAtndList.resetData(data.stuAtndList);
				//stuAtndList.updateData(data);
				
				const atndSelectOptions = data.stuAtndList.map((atnd) => ({ text: atnd, value: atnd }));
				  const selectRenderer = stuAtndList.getColumn('atnd_stt').renderer;

				  // 기존에는 첫 번째 옵션 값을 선택했지만, 이제는 ajax로 받아온 첫 번째 옵션 값을 선택하도록 합니다.
				  stuAtndList.setValue(rowKey, 'atnd_stt', atndSelectOptions[0].value);

				  // 옵션 값을 변경해줍니다.
				  selectRenderer.options = atndSelectOptions;

				  // 셀렉트 박스를 열어줍니다.
				  stuAtndList.editCell(rowKey, 'atnd_stt');
				
			}).fail(function(xhr){
				alert("문제발생");
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
				<div class="container-fluid px-4">
					<div class="mt-4 position-relative row">
						<div style="width:30px;">
						<img src="./image/joongang_logo.png" style="width:25px;">
						</div>
						<div style="width:200px; height:30px;  "> 
							<h5 style="font-weight: bold; color:#565757; line-height:35px;">강의출결관리</h5>
						</div>
					</div>
					
					<div class="mt-2 mb-1" style="width:100%; height:1px; background-color:#c1c2c2;"></div>
					
					<div class="mt-2 marginPadding0 position-relative" style="width:100%; height:31px;">
						<div class="float-start" style="width:170px; height:auto; padding:0; ">
							<button type="button" class="btn btn-sm btn-secondary">출석부</button>
							<button type="button" class="btn btn-sm btn-secondary">수강신청명단</button>
						</div>
						<div class="float-end" style="width:150px; height:auto; padding:0;">
							<button type="button" id="getCrclmList" class="btn btn-sm btn-secondary">조회</button>
							<button type="button" id="delCrclmList" class="btn btn-sm btn-secondary">삭제</button>
							<button type="button" id="saveCrclmList" class="btn btn-sm btn-secondary">저장</button>
						</div>
					</div>
					
					<div class="mt-2">
						<div class="position-relative justify-content-center" style="display:flex; width:100%; height: 45px; font-weight:bold; padding:10px 0 10px 0; background-color:#eef4f8;">
							<div style="width: 70px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 10px 0 0;">
								학년도</div>
							<div style="width: 100px; height: 30px; margin: 0 10px 0 0;">
								<input type="number" value ="2023" class="form-control" name="year" id="crclm_year" style="height: 25px;  font-size: 13px;">
							</div>
							<div style="width:100px; height:25px; margin:0 20px 0 0;">
								<select class="form-select form-select-sm" name="half" id="crclm_half" aria-label="Default select example" style="height:25px; font-size:13px; padding:0 0 0 10px;">
									<option value="0010">상반기</option>
									<option value="0020">하반기</option>
								</select>
							</div>
							<div style="width:100px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 0 0 20px;">
								훈련과정명
							</div>
							<div>
								<div style="width:250px; height:30px; margin:0 10px;">
									<input type="text" class="form-control"  style=" height:25px; font-size:13px; ">
								</div>
							</div>
							<div style="width:100px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 0 0 20px;">
								개설과목
							</div>
							<div>
								<div style="width:150px; height:30px; margin:0 10px;">
									<input type="text" class="form-control"  style=" height:25px;font-size:13px; ">
								</div>
							</div>
							<div style="width:100px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 0 0 20px;">
								담당강사
							</div>
							<div>
								<div style="width:150px; height:30px; margin:0 10px;">
									<input type="text" class="form-control"  style=" height:25px; font-size:13px;  ">
								</div>
							</div>
						</div>
					</div>
					
					<div class="mt-3 position-relative"  style="display:flex; width:100%; height:27px;">
							<div style="width:10px; height:27px; background-color:#498c5f;">
							</div>
							<div style="width:80px; height:27px; font-size:17px; font-weight: bold; line-height:30px; margin:0 10px;">
								강의목록
							</div>
							<div style="width:150px; height:27px; font-size:13px; color:#a3a3a7; line-height:35px; margin:0 10px;">
								00건이 조회되었습니다.
							</div>
					</div>

					<div style="width: 100%; height: auto;">
					<!-- 강의목록 그리드 -->
						<div class="mt-2" id="lectureList"></div>
						<div class="mt-3 position-relative" style="display:flex;">
							<div style=" width:75%; height:auto; margin-right:15px;">
								<div class="position-relative"  style="display:flex; width:100%; height:27px;">
									<div style="width:10px; height:27px; background-color:#498c5f;">
									</div>
									<div style="width:80px; height:27px; font-size:17px; font-weight: bold; line-height:30px; margin:0 10px;">
										출석정보
									</div>
									<div style="width:150px; height:27px; font-size:13px; color:#a3a3a7; line-height:35px; margin:0 10px;">
										00건이 조회되었습니다.
									</div>
								</div>
								<div class="mt-2" style="width:100%; text-align:center; font-size:14px;">
								<!-- 출석정보 그리드 -->
									<div id="atndList"></div>
								</div>
							</div>
							<div style=" width:25%; height:auto;">
								<div class="position-relative"  style="display:flex; width:100%; height:27px; ">
									<div class="float-start" style="width:10px; height:27px; background-color:#498c5f;"></div>
									<div class="float-start" style="width:80px; height:27px; font-size:17px; font-weight: bold; line-height:30px; margin:0 10px;">
										개인출결
									</div>
									<div class="position-absolute end-0" style="width:auto; color:#a3a3a7;">
										<button type="button" class="btn btn-secondary" style="height:27px; font-size:13px; padding:0 10px;">출결저장</button>
									</div>
								</div>
								<div class="mt-2 position-relative"  style="display:flex; width:100%; height:30px; line-height:27px; padding:0; font-weight:bold; font-size:14px; border: solid 1px; background-color: lightgray;">
									<div style="width:50px; text-align:center;">학번</div>
									<div id="stdnt_no" style="width:150px; text-align:center; color:navy;"></div>
									<div style="width:50px; text-align:center;">이름</div>
									<div id="stdnt_name" style="width:150px; text-align:center; color:navy;"></div>
								</div>
								<div class="mt-2" style="width:100%; text-align:center; font-size:14px;">
									<!-- 개인출결 그리드 -->
									<div id="stuAtndList"></div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</main>
			<%@include file="../bar/footer.jsp" %>
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
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> <!-- 그리드 -->
</body>
</html>
