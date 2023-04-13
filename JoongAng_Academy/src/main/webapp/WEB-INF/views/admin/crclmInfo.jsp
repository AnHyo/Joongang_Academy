<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script>
	$(function(){
		//상단 - 강사명 검색
		$("#btnInstrSearch").click(function(){
			var insname= $("#inputInstrSearch").val();
			$.post({
				url : "/listCrclmAjax",
				cache : false,
				data :{"insname": insname},
				dataType : "json"
			}).done(function(data){
			    grid.resetData(data.listCrclm);
			}).fail(function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			});
		});//강사명검색
		
		//상단 - 과정명 검색
		$("#btnCrclmSearch").click(function(){
			var crclmname= $("#inputCrclmSearch").val();
			$.post({
				url : "/listCrclmAjax",
				cache : false,
				data :{"crclmname": crclmname},
				dataType : "json"
			}).done(function(data){
			    grid.resetData(data.listCrclm);
			}).fail(function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			});
		});//과정명검색
		
		//상단 - 조회 버튼
		$("#listBtn").click(function(){
			var year =$("#inputYear").val(); //입력한년도
			var selectval =$('select[name=crclm_half]').val(); //상/하반기 선택
			var  radioval = $('input:radio[name=radioStatus]:checked').val(); //과정현황 선택
		
			$.post({
				url : "/listCrclmAjax",
				cache : false,
				data :{"year":year , "half":selectval , "radioval":radioval },
				dataType : "json"
			}).done(function(data) {
				 grid.resetData(data.listCrclm);
				//alert(data);
			}).fail(function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			});
			const Grid = tui.Grid;
	        Grid.applyTheme('clean');
	      
	        
		});
		  
	        var grid = new tui.Grid({
				el : document.getElementById('grid'),
				scrollX : false,
				scrollY : true,
				bodyHeight: 250,
				rowHeaders : [ 'checkbox' ],
				columns : [ {
					header : '훈련과정코드',
					name : 'CRCLM_CD',
					width: 150,
					align : 'center',
				}, {
					header : '훈련과정명',
					name : 'CRCLM_NM',
					width: 400,
					align : 'center',
				}, {
					header : '상/하반기',
					name : 'CRCLM_HALF',
					width: 150,
					align : 'center',
					copyOptions:{
						 useListItemText: true
					},formatter: 'listItemText',
			          editor: {
			              type: 'radio',
			              options: {
			                listItems: [
			                  { text: '상반기', value: '1' },
			                  { text: '하반기', value: '2' }
			                ]
			              }
			            }
				}, {
					header : '시작일',
					name : 'EDU_BGNG_YMD',
					align : 'center',
					
				}, {
					header : '종료일',
					name : 'EDU_END_YMD',
					align : 'center',
				}, {
					header : '대표강사',
					name : 'KORN_FLNM',
					align : 'center',
				}, {
					header : '과정현황',
					name : 'CRCLM_SCHDL_CD',
					align : 'center',
					copyOptions:{
						 useListItemText: true
					},formatter: 'listItemText',
			          editor: {
			              type: 'radio',
			              options: {
			                listItems: [
			                  { text: '모집', value: '0010' },
			                  { text: '훈련', value: '0020' },
			                  { text: '수료', value: '0030' }
			                ]
			              }
			            }
					
				}, {
					header : '종료여부',
					name : 'EDU_FNSH_YN',
					align : 'center',
				
				}  
				]
	      
			});//grid
			
			//grid 행 클릭시    	
	        grid.on('click', function(ev) {
	            var rowKey = ev.rowKey; // 클릭한 행의 키값
	            var rowData = grid.getRow(rowKey); // 클릭한 행의 데이터
	            var ccd = rowData.CRCLM_CD; // 과정코드 
	            var cyear = rowData.CRCLM_YEAR; // 연도
	            var chalf = rowData.CRCLM_HALF; // 상/하반기
	            var cname = rowData.CRCLM_NM; // 과정명
	            var econtent = rowData.EDU_CN; // 훈련내용
	            var ecost = rowData.EDU_COST; // 훈련비용
	            var bgYMD = rowData.EDU_BGNG_YMD; // 시작일
	            var endYMD = rowData.EDU_END_YMD; // 종료일
	            var efnYN = rowData.EDU_FNSH_YN; // 종료여부
	            var schedule= rowData.CRCLM_SCHDL_CD; // 과정현황
	            var instrname = rowData.KORN_FLNM; 	//강사명
	            var crclmNo = rowData.CRCLM_NO; 
				//alert(crclmNo);
	            
				$(".cno").val(crclmNo);
	            $(".cyear").val(cyear);
	            $(".chalf").val(chalf);
	            $(".ccd").val(ccd);
	            $(".ccd").css("background-color","white");
	            $(".cname").val(cname);
	            $(".bgYMD").val(bgYMD);
	            $(".endYMD").val(endYMD);
	            $(".ecost").val(ecost);
	            $(".econtent").val(econtent);
	            $(".instrname").val(instrname);
	            $(".schedule").val(schedule);
	            $(".efnYN").val(efnYN);
	            
	       
	        });
			//상단 - 저장버튼 
			$("#saveBtn").click(function(){
				var cno= $(".cno").val();
				var cyear =$(".cyear").val();
				var chalf =$(".chalf").val();
				var bgYMD =$(".bgYMD").val();
	            var endYMD=$(".endYMD").val();
	            var ecost=$(".ecost").val();
	            var econtent=$(".econtent").val();
	            var instrname=$(".instrname").val();
	            var schedule=$(".schedule").val();
	            var efnYN =$(".efnYN").val();
	           
	             $.post({
					url : "/saveCrclmAjax",
					cache : false,
					data :{"cno":cno , "cyear":cyear , "bgYMD":bgYMD, "chalf":chalf,
					"endYMD":endYMD ,"ecost":ecost ,"econtent":econtent ,"instrname":instrname,
					"schedule":schedule ,"efnYN":efnYN },
					dataType : "json"
				}).done(function(data) {
					// grid.resetData(data.listCrclm);
					alert("수정성공");
				}).fail(function(xhr, status, errorThrown) {
					alert("문제가 발생했습니다.");
				}); 
	    		
	    	});//저장버튼
		
	    	//수정수정수정
	    	
	    	
	});//func
</script>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h5 class="mt-3 fw-bolder">교육훈련과정 정보관리</h5>
					<hr>
					<div style="width: 100%; position: relative;">
						<div style="position: absolute; right: 0">
							<button class="btn btn-secondary  btn-sm" id="listBtn">조회</button>
							<button class="btn btn-secondary btn-sm">신규</button>
							<button class="btn btn-secondary btn-sm">삭제</button>
							<button class="btn btn-secondary btn-sm" id="saveBtn">저장</button>
						</div>
					</div>
					<br>
					<br>
					
					<div style="width: 100%; background-color: #F3FAFE; height: 80px; border: 1px solid #c0c0c0;  
					 position :relative;">
						<div style=" position: absolute; width: 100%; top:50%; transform: translateY(-50%)" class="d-flex justify-content-center">
						<div class="input-group "
							style="width: calc(20%); float: left;">
							학년도 <input type="text" class="form-control form-control-sm" style="margin-left:10px;"
							placeholder="2023" id="inputYear">
							<select class="form-select form-select-sm" name="crclm_half">
								<option value="" >상/하반기</option>
								<option value="1">상반기</option>
								<option value="2">하반기</option>
							</select>
						</div>
						<div class="input-group "
							style="width: calc(15%); margin-left: 10px; float: left;">
							<input class="form-control form-control-sm" "type="text"
								placeholder="과정명" aria-describedby="btnCrclmSearch"  id="inputCrclmSearch"/>
							<button class="btn btn-secondary btn-sm" id="btnCrclmSearch"
								type="button">
								<i class="fas fa-search"></i>
							</button>
						</div>
						<div class="input-group "
							style="width: calc(15%); margin-left: 10px; float: left;">
							<input class="form-control form-control-sm" type="text"
								placeholder="강사명" aria-describedby="btnInstrSearch" id="inputInstrSearch" />
							<button class="btn btn-secondary btn-sm" id="btnInstrSearch" type="button">
								<i class="fas fa-search"></i>
							</button>
						</div>
						<div class="input-group "
							style="width: calc(30%); margin-left: 10px; float: left;">
							과정현황
							<div class="form-check form-check-inline" style="margin-left: 5px;">
								<input class="form-check-input" type="radio"
									name="radioStatus"   checked="checked" value="">전체
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="radioStatus"  value="0010">모집
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="radioStatus"  value="0020"> 훈련
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="radioStatus"  value="0030">수료
							</div>
						</div>
					</div>
				</div>
					<!-- 상단 끝 -->
					<div>
					<div class="float-start" style="width:10px; height:27px; background-color:#498c5f; margin-right: 10px;"></div>
					<h6 class="mt-3 fw-bolder">교육훈련과정</h6>
						<div id="grid" ></div>
					</div>
					
					<div>
					<div class="float-start" style="width:10px; height:27px; background-color:#498c5f; margin-right: 10px;"></div>
					<h6 class="mt-3 fw-bolder" >훈련과정정보</h6>
						<div class="mb-5" style="width: 100%; background-color: #F3FAFE; height: 420px; border: 1px solid #c0c0c0;  
					 	position :relative;">
					 		
					 		<table style="width:90%;position: absolute; top:50%; transform: translateY(-50%) translateX(5%); ">
					 			<tr style="height:50px">
					 				<td class="col-1" style="text-align:right;">학년도</td>
					 				<td class="col-2"><input type="text" class="form-control form-control-sm cyear" ></td>
					 				<td class="col-1" style="text-align:right; ">훈련과정코드</td>
					 				<td class="col-2"><input type="hidden" class="cno">
										<input type="text" class="form-control form-control-sm ccd" readonly style="background-color:#C0C0C0;"></td>
					 				<td class="col-1" style="text-align:right;">훈련과정명</td>
					 				<td class="col-4" colspan='3'>
									<input type="text" class="form-control form-control-sm cname" readonly>
									</td>
								<!--<td class="col-1" style="text-align:right;">훈련과정명</td>
					 				<td class="col-4" colspan='3'>
									<select class="form-select form-select-sm">
										<option>상반기</option>
										<option>하반기</option>
									</select>
									</td> -->
					 			</tr>
					 			<tr style="height:50px">
					 				<td style="text-align:right;">상/하반기</td>
					 				<td>
									<select class="form-select form-select-sm chalf">
										<option value="1">상반기</option>
										<option value="2">하반기</option>
									</select>
									</td>
					 				<td style="text-align:right;">대표강사명</td>
					 				<td>
					 				<div class="input-group ">
					 					<input class="form-control form-control-sm instrname" type="text"
										placeholder="강사명" aria-describedby="btnNavbarSearch" />
										<button class="btn btn-secondary btn-sm" id="btnNavbarSearch"
										type="button">
										<i class="fas fa-search"></i>
										</button></div></td>
					 				<td style="text-align:right;">시작일</td>
					 				<td ><input type="text" class="form-control form-control-sm bgYMD"></td>
					 				<td style="text-align:right;">종료일</td>
					 				<td ><input type="text" class="form-control form-control-sm endYMD"></td>
					 			</tr>
					 			<tr style="height:50px">
					 				<td style="text-align:right;">훈련비용</td>
					 				<td><input type="text" class="form-control form-control-sm ecost"></td>
					 				<td style="text-align:right;">과정현황</td>
					 				<td>
					 					<select class="form-select form-select-sm schedule">
											<option value="0010">모집</option>
											<option value="0020">훈련</option>
											<option value="0030">수료</option>
										</select>
					 				</td>
					 				<td style="text-align:right;">종료여부</td>
					 				<td>
					 					<select class="form-select form-select-sm efnYN">
											<option value="N">N</option>
											<option value="Y">Y</option>
										</select>
					 				</td>
					 			</tr>
					 			<tr>
					 				<td style="text-align:right;">훈련내용</td>
					 			</tr>
					 			<tr>
					 				<td></td>
					 				<td colspan="7"><textarea class="form-control econtent" style="height:200px; resize: none;"></textarea></td>
					 			</tr>
					 			
					 		</table>
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
</body>
</html>