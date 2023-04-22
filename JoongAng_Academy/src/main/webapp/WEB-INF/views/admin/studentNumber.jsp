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
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<!-- 그리드 -->
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />

<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<style type="text/css">
body {
	color: #565757;
}

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

		const crclmList = new tui.Grid({

			el : document.getElementById('crclmList'),
			scrollX : false,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
			header : {
				height : 30
			},
			columns : [ {
				header : '과정코드',
				name : 'crclm_cd',
				width : 60
			}, {
				header : '훈련과정명',
				name : 'crclm_name',
			}, {
				header : '모집인원',
				name : 'person_no',
				width : 80,
				selectable : false
			}, {
				header : '입학인원',
				name : 'applCount',
				width : 80,
				selectable : false
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
			} ],
			
			bodyHeight : 550
			

		});
		
		const studentList = new tui.Grid({
			el : document.getElementById('studentList'),
			scrollX : false,
			scrollY : true,
			rowHeight : 30,
			minRowHeight : 30,
			header : {
				height : 30
			},
			columns : [ {
				header : '과정코드',
				name : 'crclm_cd',
				width : 60
			}, {
				header : '학번',
				name : 'stu_no',
			}, {
				header : '성명',
				name : 'stu_name',
				width : 150,
			}, {
				header : '연락처',
				name : 'stu_tel',
			}, {
				header : '학번확정(Y/N)',
				name : 'ID_YN',
				width : 150,
			} ],
			
			bodyHeight : 550
		});

		$("#select").click(function() {
			
			let year = $.trim($("#year").val());
			let half = $.trim($("#half").val());
			let crclmName = $.trim($("#crclmName").val());
			$("#crclmName").val(crclmName);
			let stdntName = $.trim($("#stdntName").val());
			$("#stdntName").val(stdntName);
			//alert(year + " / " + half);

			
			if (year == "") {
				alert("학년도는 필수입력사항입니다.");
				return false;
			}
			
			if(stdntName != ""){
				$.post({
					url : "/searchName",
					data : {
						"year" : year,
						"half" : half,
						"stdntName" : stdntName,
					},
					dataType : "json"
				}).done(function(data){
					//alert("성공");
					crclmList.resetData([]);
					studentList.resetData([]);
					$("#stdntCount").html('0');
					
					if(data.stuList != ""){
						crclmList.resetData(data.crclmList);
						studentList.resetData(data.stuList);
						
						let crclmCount = crclmList.getRowCount();
						let stdntCount = studentList.getRowCount();
		 				$("#crclmCount").html(crclmCount);
		 				$("#stdntCount").html(stdntCount);
					}
					
				}).fail(function(xhr){
					alert("문제발생");
				});
				
			} else {
				$.post({
					url : "/getCrclmList",
					data : {
						"year" : year,
						"half" : half,
						"crclmName" : crclmName,
						"stdntName" : stdntName
					},
					dataType : "json"
				}).done(function(data) {
	 				//alert("성공" + data.list);
	 				//alert(data.list[0].crclm_name);
	 				crclmList.resetData([]);
					studentList.resetData([]);
					$("#stdntCount").html('0');
					
					crclmList.resetData(data.crclmList);
					
					let crclmCount = crclmList.getRowCount();
					let stdntCount = studentList.getRowCount();
	 				$("#crclmCount").html(crclmCount);
	 				$("#stdntCount").html(stdntCount);
					
				}).fail(function(xhr) {
					alert("문제발생");
				});
				
			}
			

		});
		
		crclmList.on('click', function(ev){
			var rowKey = ev.rowKey;
			var row = crclmList.getRow(rowKey);		// 행
			var crclm_cd = crclmList.getValue(rowKey, 'crclm_cd');			// 해당 행의 hidden 컬럼을 가져오기.
			var year = crclmList.getValue(rowKey, 'crclm_year');		
			var half = crclmList.getValue(rowKey, 'crclm_half');
			// alert(crclm_cd + " / " + crclm_year + " / " + crclm_half);
			
			$.post({
				url : "/getStuList",
				data : {
					"crclm_cd" : crclm_cd,
					"year" : year,
					"half" : half
				},
				dataType : "json"
			}).done(function(data){
				//alert(data.stuList);
				studentList.resetData(data.stuList);
				
				let stdntCount = studentList.getRowCount();
 				$("#stdntCount").html(stdntCount);
			}).fail(function(xhr){
				alert("문제발생");
			});
			
		});
	
		$("#setStudentNo").click(function(){
			if(confirm("2023학년도 상반기 학번을 생성하시겠습니까?") == true){
				
				let year = $.trim($("#year").val());
				let half = $.trim($("#half").val());
				
				$.post({
					url : "/setStdntNo",
					data : {
						"year" : year,
						"half" : half
					},
					dataType : "json"
				}).done(function(data){
					if(data.setNoResult == "1"){
						alert("학번을 생성하였습니다.");
						$("#radio_all").prop("checked", true);
						crclmList.resetData([]);
						studentList.resetData([]);
					}
				}).fail(function(xhr){
					alert("문제발생");
				});
				
			}
		});
		
		$("#setStudentId").click(function(){
			if(confirm("2023학년도 상반기 학번을 확정하시겠습니까?") == true){
				let year = $.trim($("#year").val());
				let half = $.trim($("#half").val());
				
				$.post({
					url : "/setStdntIdPw",
					data : {
						"year" : year,
						"half" : half
					},
					dataType : "json"
				}).done(function(data){
					alert("학번이 확정되었습니다.");
					$("#radio_all").prop("checked", true);
					crclmList.resetData([]);
					studentList.resetData([]);
				}).fail(function(xhr){
					alert("문제발생");
				});
			}
			
		});
		
		$("input[name='radio']").change(function(){
			let radioVal = $("input[name='radio']:checked").val();
			//alert(radioVal);
			
			let year = $.trim($("#year").val());
			let half = $.trim($("#half").val());
			
			$.post({
				url : "/chooseRadio",
				data : {
					"year" : year,
					"half" : half,
					"radioVal" : radioVal
				},
				dataType : "json"
			}).done(function(data){
				crclmList.resetData(data.crclmList);
				studentList.resetData(data.radioList);
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
						<div style="width: 30px;">
							<img src="./image/joongang_logo.png" style="width: 25px;">
						</div>
						<div style="width: 200px; height: 30px;">
							<h5 style="font-weight: bold; color: #565757; line-height: 35px;">학번생성관리</h5>
						</div>
					</div>

					<div class="mt-2 mb-1"
						style="width: 100%; height: 1px; background-color: #c1c2c2;"></div>

					<div class="mt-2 marginPadding0 position-relative"
						style="width: 100%; height: 31px;">
						<div class="float-start"
							style="width: 170px; height: auto; padding: 0;">
							<button type="button" id="setStudentNo" class="btn btn-sm btn-secondary">학번생성</button>
							<button type="button" id="setStudentId" class="btn btn-sm btn-secondary">학번확정</button>
							<!-- 학번확정은 학생의 아이디를 학번으로 저장하고 초기비밀번호를 설정하는 용도 -->
						</div>
						<div class="float-end"
							style="width: 50px; height: auto; padding: 0;">
							<button type="button" id="select"
								class="btn btn-sm btn-secondary">조회</button>
						</div>
					</div>

					<div class="mt-2">
						<div class="position-relative justify-content-center"
							style="display: flex; width: 100%; height: 45px; font-weight: bold; padding: 10px 0 10px 0; background-color: #eef4f8;">
							<div style="width: 70px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 10px 0 0;">
								학년도</div>
							<div style="width: 100px; height: 30px; margin: 0 10px 0 0;">
								<input type="number" value ="2023" class="form-control" id="year" style="height: 25px;  font-size: 13px;">
							</div>
							<div style="width: 100px; height: 25px; margin: 0 20px 0 0;">
								<select class="form-select form-select-sm" name="half" id="half"
									aria-label="Default select example"
									style="height: 25px; font-size: 13px; padding: 0 0 0 10px;">
									<option value="0010">상반기</option>
									<option value="0020">하반기</option>
								</select>
							</div>
							<div style="width: 100px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
								훈련과정명</div>
							<div>
								<div style="width: 250px; height: 30px; margin: 0 10px;">
									<input type="text" id="crclmName" class="form-control" style="height: 25px; font-size: 13px;">
								</div>
							</div>
							<div style="width: 80px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 0 0 20px;">
								성명</div>
							<div>
								<div style="width: 150px; height: 30px; margin: 0 10px;">
									<input type="text" id="stdntName" class="form-control" style="height: 25px; font-size: 13px;">
								</div>
							</div>
							<div
								style="width: 100px; height: 25px; font-size: 14px; text-align: right; line-height: 25px; margin: 0 10px 0 20px;">
								학번부여</div>
							<div class="position-relative"
								style="display: flex; height: 200px; line-height: 25px; font-size: 14px;">
								<div class="form-check " style="margin: 0 10px;">
									<input class="form-check-input" type="radio" name="radio" id="radio_all" checked value="all"> 
									<label class="form-check-label" for="radio_all"> 전체 </label>
								</div>
								<div class="form-check" style="margin: 0 10px;">
									<input class="form-check-input" type="radio" name="radio" id="radio_setNo" value="setNo"> 
									<label class="form-check-label" for="radio_setNo"> 확정 </label>
								</div>
								<div class="form-check" style="margin: 0 10px;">
									<input class="form-check-input" type="radio" name="radio" id="radio_not" value="not"> 
									<label class="form-check-label" for="radio_not"> 미정 </label>
								</div>
							</div>
						</div>
					</div>

					<div class="mt-3 position-relative" style="display: flex;">
						<div style="width: 50%; height: 400px; margin-right: 15px;">
							<div class="position-relative"
								style="display: flex; width: 100%; height: 27px;">
								<div style="width: 10px; height: 27px; background-color: #498c5f;">
								</div>
								<div style="width: 110px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
									입학인원조회</div>
								<div class="position-relative" style="display:flex; width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
									<div id="crclmCount" style="width: 17px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px;">
									0</div>건이 조회되었습니다.
								</div>
							</div>
							<div class="mt-2"
								style="width: 100%; height: 500px; text-align: center; font-size: 14px;">
								<!-- 입학인원조회 그리드 -->
								<div id="crclmList" style="text-align: center;"></div>
							</div>
						</div>
						<div style="width: 50%; height: 610px;">
							<div class="position-relative"
								style="display: flex; width: 100%; height: 27px;">
								<div class="float-start"
									style="width: 10px; height: 27px; background-color: #498c5f;"></div>
								<div class="float-start"
									style="width: 110px; height: 27px; font-size: 17px; font-weight: bold; line-height: 30px; margin: 0 10px;">
									학번조회</div>
								<div class="position-relative" style="display:flex; width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px; margin: 0 10px;">
									<div id="stdntCount" style="width: 17px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 35px;">
										0</div>건이 조회되었습니다.
								</div>
								<div class="position-absolute end-0"
									style="width: auto; height: 27px; line-height: 35px; font-size: 13px; color: red;">
									* 초기비밀번호는 학번확정시에 설정됩니다.</div>
							</div>
							<div class="mt-2" style="width: 100%; text-align: center; font-size: 14px;">
								<!-- 학번부여관리 그리드 -->
								<div id="studentList"></div>
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
