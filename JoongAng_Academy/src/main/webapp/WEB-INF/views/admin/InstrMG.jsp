<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>강사관리</title>
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
<script src="js/teacher/teacher_info.js"></script>	
<script src="js/student/studentpost.js"></script>
<script>


	$(function() {
		
		$("#deleteCenBtn").hide();

		var Grid = tui.Grid;
		Grid.applyTheme('clean');
		var grid = new tui.Grid({
			el : document.getElementById("grid"),
			scrollX : false,
			scrollY : true,
			bodyHeight : 300,
			rowHeaders : [ 'checkbox' ],
			checkboxOnly: true,
			columns : [ {
				header : "강사번호",
				name : 'INSTR_NO',
				align: 'center',
				width : 160,
				sortingType: 'asc',
				sortable: true
			}, {
				header : "성명",
				name : 'KORN_FLNM',
				width : 120,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			}, {
				header : "생년월일",
				name : 'USER_BRDT',
				width : 160,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			}, {
				header : "이메일",
				name : 'EML_ADDR',
				align: 'center',
				sortingType: 'asc',
				sortable: true
			}, {
				header : "연락처",
				name : 'TELNO',
				align: 'center',
				sortingType: 'asc',
				sortable: true
			},
			{
				header : "우편번호",
				name : 'ZIP',
				hidden : true,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			},
			{
				header : "주소",
				name : 'ADDR',
				align: 'center',
				sortingType: 'asc',
				sortable: true
			},
			{
				header : "상세주소",
				name : 'DADDR',
				hidden : true,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			},
			{
				header : "성별",
				name : 'GENDER_CD_NAME',
				width: 120,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			}, 
			{
				header : "사용자번호",
				name : 'USER_NO',
				hidden : true,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			},
			{
				header : "교육기관",
				name : 'ENDST_NM',
				align: 'center',
				sortingType: 'asc',
				sortable: true
			},
			{
				header : "재직여부",
				name : 'INSTR_DEL_NAME',
				width : 100,
				align: 'center',
				sortingType: 'asc',
				sortable: true
			}]
		});
		
		// -- 해더 부분 checkbox 막기
		$('.tui-grid-cell-row-header input[type="checkbox"]').prop('disabled', true);
		
		 // -- 체크박스 1개만 체크되게 하기 
		  var lastCheckedRowKey = null;
		  grid.on('check', (ev) => {
			  var checkedRows = grid.getCheckedRows();
			  
			  // 마지막으로 체크한 행의 체크를 해제
			  if (lastCheckedRowKey !== null && ev.rowKey !== lastCheckedRowKey) {
			    grid.uncheck(lastCheckedRowKey);
			  }
			  
			  // 마지막으로 체크한 행의 키를 업데이트
			  lastCheckedRowKey = ev.rowKey;
		  });
		
		
		// -- 조회 그리드 함수
		function insListAjax (){
			var name = $("#searchName").val();
			$.post({
				url : "/insListAjax",
				data : { name : name },
				dataType : "json"
			}).done(function(data) {
				grid.resetData(data.insList);
				//alert(data.insList[0].GENDER_CD);
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		}
		
		// -- 조회
		$("#searchBtn").click(function() {
			//grid.refreshLayout();
			insListAjax();
		});
		
		var lastCheckedRow;
		
		grid.on('click', function(ev){
			
			var rowKey = grid.getFocusedCell().rowKey;
			//alert(rowKey);
			grid.check(rowKey);
			
			if(ev.rowKey == null){
				return false;
			}else{
				if(grid.getValue(ev.rowKey,'INSTR_DEL') == 'N'){
					$("#d").prop("disabled", true);
					$("#postNum").prop("disabled", true);
					$("#addrInfo").prop("disabled", true);
					$("#addrDetail").prop("disabled", true);
					$("#e").prop("disabled", true);
					$("#k").prop("disabled", true);
					$("#postSearch").prop("disabled", true);
					$("#saveBtn").prop("disabled", true);
					$("#deleteBtn").hide();
					$("#deleteCenBtn").show();
				} else {
					
					$("#d").prop("disabled", false);
					$("#postNum").prop("disabled", false);
					$("#addrInfo").prop("disabled", false);
					$("#addrDetail").prop("disabled", false);
					$("#e").prop("disabled", false);
					$("#k").prop("disabled", false);
					$("#postSearch").prop("disabled", false);
					$("#saveBtn").prop("disabled", false);
					$("#deleteBtn").show();
					$("#deleteCenBtn").hide();
				}	
					
					console.log(grid.getRow(ev.rowKey));
					$("#a").val(grid.getValue(ev.rowKey,'INSTR_NO'));
					$("#b").val(grid.getValue(ev.rowKey,'KORN_FLNM'));
					$("#c").val(grid.getValue(ev.rowKey,'USER_BRDT'));
					$("#d").val(grid.getValue(ev.rowKey,'EML_ADDR'));
					$("#e").val(grid.getValue(ev.rowKey,'TELNO'));
					$("#postNum").val(grid.getValue(ev.rowKey,'ZIP'));
					$("#addrInfo").val(grid.getValue(ev.rowKey,'ADDR'));
					$("#addrDetail").val(grid.getValue(ev.rowKey,'DADDR'));
					$("#i").val(grid.getValue(ev.rowKey,'GENDER_CD'));
					$("#j").val(grid.getValue(ev.rowKey,'USER_NO'));
					$("#k").val(grid.getValue(ev.rowKey,'ENDST_NO'));
					
				
			}
			  
		});
		

		$("#saveBtn").click(function(){
			if($("#a").val() == "" || $("#a").val() < 1){
				alert("수정할 강사정보가 없습니다.");
				return false;
			} else {
				//정규식 검사(email형식이 맞는지)
				var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				//전화번호 정규식
				var RegExp  = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ A-Z\uAC00-\uD7A3\u3131-\u3163]/gim;
				
				if(! (filter.test($("#d").val()) )){
					alert("올바른 email형식을 입력하세요.");
					var a = $('#d').val().replace(/ /gi, '');
					$('#d').val(a);
					$("#d").focus();
					return false;
				}
				
				if($("#e").val() == "" || $("#e").val().length > 11 || 
						RegExp.test($("#e").val())	){
						alert("전화번호는 숫자만 입력해 주세요.");
						var b = $('#e').val().replace(RegExp, '');
						$('#e').val(b);
						$("#e").focus();
						return false;
				}
				
				if($("#k").val() == ""){
					alert("소속 교육기관을 선택해 주세요.");
					$("#k").focus();
					return false;
				}
				
				var inst_no = $("#a").val();
				
				//중복확인
				$.post({
					url: "/telChenck",
					data:{"inst_no":inst_no},
					cache: false,
					dataType: "json"
				}).done(function(data) {
					//alert("성공");
					var result = data.telList;
					for(let i = 0; result.length > i; i++){
							if($("#e").val() == result[i].TELNO){
							alert("이미 등록되어있는 전화번호입니다.");
							$("#e").focus();
							return false;
							}
						}
					
					var instrNo = $("#a").val();
					var email = $("#d").val();
					var tel = $("#e").val();
					var postNumber = $("#postNum").val();
					var addr = $("#addrInfo").val();
					var daddr = $("#addrDetail").val();
					var endst = $("#k").val();
					
					 $.post({
						url: "/teacherInfoUpdate",
						data:{
							"email":email,
							"tel":tel,
							"postNumber":postNumber,
							"addr":addr,
							"daddr":daddr,
							"endst":endst,
							"instrNo":instrNo
						},
						cache: false,
						dataType: "json"
					}).done(function(data) {
						if (data.result == "1") {
							alert("수정이 완료되었습니다.");
							$("#d").prop("disabled", true);
							$("#postNum").prop("disabled", true);
							$("#addrInfo").prop("disabled", true);
							$("#addrDetail").prop("disabled", true);
							$("#e").prop("disabled", true);
							$("#k").prop("disabled", true);
							$("#postSearch").prop("disabled", true);
							insListAjax();
						} else{
							alert("수정이 실패하였습니다.\n잠시 뒤 다시 시도해주세요.");
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); // -- 수정 끝

				}).fail(function() {
					alert("문제가 발생했습니다.");
				});	// -- 중복확인 끝
				
			}
		});
		
		// -- 삭제
		$("#deleteBtn").click(function(){
			var checkedRows = grid.getCheckedRows();
			  if(checkedRows.length > 0){
				    var firstRow = checkedRows[0];
				    var instrNo = firstRow.INSTR_NO;
				    var instrDel = firstRow.INSTR_DEL
				    if(instrDel == 'N'){
				    	alert("이미 삭제된 강사정보입니다.");
				    	return false;
				    }
				    
				     $.post({
						url: "/instrFoCheck",
						data:{
							"instrNo":instrNo,
						},
						cache: false,
						dataType: "json"
					}).done(function(data) {
						var result = data.foCheck[0];
						var INSTR_INFO = result.INSTR_INFO;
						var SBJCT_INSTR = result.SBJCT_INSTR;
						var CRCLM_INFO = result.CRCLM_INFO;
						if(SBJCT_INSTR == null && CRCLM_INFO == null){
							//alert(instrNo);
						  if(confirm("삭제하시겠습니까?")){
						 	$.post({
								url: "/instrDel",
								data:{"instrNo":instrNo},
								cache: false,
								dataType: "json"
							}).done(function(data) {
								if(data.result == '1'){
									alert("삭제되었습니다.");
									insListAjax();
								} else {
									alert("삭제에 실패했습니다.");
								}
								
							}).fail(function() {
								alert("문제가 발생했습니다.");
							}); // -- 삭제 처리
						  }
						} else if(SBJCT_INSTR != null && CRCLM_INFO == null){
							alert("대표강사설정에 데이터가 존재하므로 삭제할 수 없습니다.");
						} else if(CRCLM_INFO != null && SBJCT_INSTR == null) {
							alert('교육훈련과정설정에 데이터가 존재하므로 삭제할 수 없습니다');
						} else if (SBJCT_INSTR != null && CRCLM_INFO != null){
							alert('대표강사설정과 교육훈련과정설정에 데이터가 존재하므로 삭제 할 수 없습니다.');
						}
						
					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); // -- 참조 확인
				    
				 } else {
					 alert("삭제할 강사를 체크해 주세요.");
				 }
			  
		}); // -- 삭제 끝
		
		// -- 삭제 취소 버튼
		$("#deleteCenBtn").on("click", function(){
			var checkedRows = grid.getCheckedRows();
			  if(checkedRows.length > 0){
				 var firstRow = checkedRows[0];
				 var instrNo = firstRow.INSTR_NO;
				 $.post({
						url: "/instrDelCen",
						data:{"instrNo":instrNo},
						cache: false,
						dataType: "json"
					}).done(function(data) {
						if(data.result == '1'){
							alert("복구되었습니다.");
							insListAjax();
						} else {
							alert("복구에 실패했습니다.");
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); // -- 복구 끝
			  
			  } else {
				  alert("복원할 강사를 선택해 주세요.");
			  }
		});
		
	/* 	$(".tui-grid-row-checkbox").on("check", function() {
			  if (this.checked) {
			    $(".tui-grid-row-checkbox").not(this).prop("checked", false);
			  }
		}); */
		
		
		// -- 탭바 클릭시 초기화
		
		$(document).on("click","#nav-profile-tab",function(){
			grid.resetData([]);
			
			$("form").on("reset", function() {
				  // input, select, textarea 요소 초기화
				  $(this).find("input, select, textarea").val("");
				  // select 요소의 첫번째 옵션 선택
				  $(this).find("select").prop("selectedIndex", 0);
			});
			
			$("form").trigger("reset");
			
			$("#d").prop("disabled", true);
			$("#postNum").prop("disabled", true);
			$("#addrInfo").prop("disabled", true);
			$("#addrDetail").prop("disabled", true);
			$("#e").prop("disabled", true);
			$("#k").prop("disabled", true);
			$("#i").prop("disabled", true);
			$("#postSearch").prop("disabled", true);
			
		});
		
	  // -- 우편번호 input 클릭 시 API창 뜨게
	 	$("#postNum").on("click", function(){
			if ($("#postNum").val() == ""){
				$("#postSearch").click();
			} 
		});
		
		
	});
	
	
	$(document).ready(function() {
		  const currentUrl = window.location.href;
		  const menuUrl = "http://localhost/admin";

		  if (currentUrl !== menuUrl) {
		    window.location.replace(menuUrl); // 변수를 사용하도록 변경
		  }
	});		
</script>	
<style type="text/css">
span{
display: block;
}
.ta{
 line-height: 51px;
}

.font-set{
	font-size: 14px;
}
.div-padding{
	padding: 10px;
}
.head{
	margin: 0 auto;
	padding: 0;
	width: auto;
	height: auto;
}
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
					<div class="mt-4 position-relative row">
						<div style="width:30px;">
						<img src="./image/joongang_logo.png" style="width:25px;">
						</div>
						<div style="width:200px; height:30px;  "> 
							<h5 style="font-weight: bold; color:#565757; line-height:30px;">강사관리</h5>
						</div>
					</div>
					<div class="mt-2 mb-2" style="width:100%; height:1px; background-color:#c1c2c2;"></div>
				
				<!-- 탭바 -->
				<div class="mb-2">
				  <nav>
				   <div class="nav nav-tabs" id="nav-tab" role="tablist">
					  <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-inquire" type="button" role="tab" aria-controls="nav-inquire" aria-selected="true">강사조회</button>
					  <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-registered" type="button" role="tab" aria-controls="nav-registered" aria-selected="false">강사등록</button>
				   </div>	
				  </nav>
				</div>  
				
				
					<form>
					<div class="tab-content" id="nav-tabContent">						
						
						<!-- 강사조회 -->
						<div class="tab-pane fade show active" id="nav-inquire" role="tabpanel" aria-labelledby="nav-home-tab">
							<div class="mb-2">
								<div class="row mb-2">
									<div class="col-5">
										<div class="input-group input-group-sm">
											<input type="text" class="form-control form-control-sm col-md-2" id="searchName" aria-describedby="basic-addon3" placeholder="이름 or 연락처">
											<button class="btn btn-primary btn-sm col-md-1" id="searchBtn" type="button">조회</button>
										</div>
									</div>
									<div class="col-7">
										<button class="btn btn-sm btn-danger col-md-1 float-end" id="deleteBtn" type="button" style="margin-left: 5px;">삭제</button>
										<button class="btn btn-sm btn-danger col-md-1 float-end" id="deleteCenBtn" type="button" style="margin-left: 5px;">삭제취소</button>
										<button class="btn btn-sm btn-secondary col-md-1 float-end" id="saveBtn" type="button" style="margin-left: 5px;">저장</button>
									</div>
								</div>
								<div id="grid" class="mb-3" style="width: 100%;"></div>
							</div>
						</div>
						
						<!-- 강사등록 -->
						<div class="tab-pane fade" id="nav-registered" role="tabpanel" aria-labelledby="nav-profile-tab">
						<div class="mb-2">
								<div class="row mb-2">
									<div class="col-6">
									</div>
									<div class="col-6">
										<button class="btn btn-sm btn-secondary col-md-1 float-end" id="newSaveBtn" type="button" style="margin-left: 5px;">저장</button>
									</div>
								</div>
								<div id="tchgrid" class="mb-3" style="width: 100%;"></div>
							</div>
						</div>
					</div>
					
					<!-- 정보 -->
					
						<div class="p-1 mt-4 mb-4 border container-fluid" style="background-color: #F3FAFE">
						<div style="width: auto; height: auto;margin-left: 100px;">
						<div class="row">
						<!-- 첫번째 줄 -->
						  <div class="col-4">
						  <div class="row">
								<span class="col-4 text-center ta font-set">강사번호</span>
								<div class="col-7 div-padding">
									<input class="form-control form-control-sm" id="a" name="a" type="text" aria-label="Disabled input example" disabled>
						  		</div>
						  </div>
						  </div>
						  <!-- 연락처 -->
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">성명</span>
								<div class="col-8 div-padding">
									<input class="form-control form-control-sm" id="b" name="b" type="text" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
						 <!-- 비상연락처 -->
						  <div class="col-3">
						  	<div class="row">
						  		<span class="col-4 text-center ta font-set">생년월일</span>
						  		<div class="col-8 div-padding">
						  			<input type="text" id="c" name="c" class="form-control form-control-sm" aria-describedby="passwordHelpInline" disabled>
  								</div>
  							</div>
						  	</div>
						  </div> <!-- 첫째줄 끝 -->
						  
						  
						  <!-- 두번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
						  <div class="row">
								<span class="col-4 text-center ta font-set">이메일</span>
								<div class="col-7 div-padding">
									<input class="form-control form-control-sm" id="d" name="d" type="text" aria-label="Disabled input example" disabled>
						  		</div>
						  </div>
						  </div>
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">연락처</span>
								<div class="col-8 div-padding">
									<input class="form-control form-control-sm" maxlength="11" id="e" name="e" type="text" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
						  <div class="col-3">
						  	<div class="row">
						  		<span class="col-4 text-center ta font-set">성별</span>
						  		<div class="col-8 div-padding">
						  			<select class="form-select form-select-sm" id="i" name="i" aria-label=".form-select-sm example" disabled>
											<option selected value="">선택</option>
											<c:forEach items="${gender }" var="g" varStatus="status">
											<option value="${g.CD }">${g.CD_NM }</option>
											</c:forEach>
									</select>
  								</div>
  							</div>
						  	</div>
						</div>
					
					
					 <!-- 세번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
						  <div class="row">
								<span class="col-4 text-center ta font-set">우편번호</span>
								<div class="col-7 div-padding">
								  <div class="input-group input-group-sm">
									<input class="form-control form-control-sm col-10" type="text" id="postNum" name="postNum" aria-label=".form-control-sm example" disabled readonly="readonly">
									<button class="btn btn-secondary btn-sm col-2" id="postSearch" type="button" onclick="stuent_post()" disabled><i class="fas fa-search"></i></button>
								  </div>
						  		</div>
						  </div>
						  </div>
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">주소</span>
								<div class="col-8 div-padding">
									<input class="form-control form-control-sm" id="addrInfo" name="addrInfo" type="text" aria-label=".form-control-sm example" disabled readonly="readonly">
								</div>
							</div>
						 </div>
						  <div class="col-4">
						  	<div class="row">
						  		<span class="col-3 text-center ta font-set">상세주소</span>
						  		<div class="col-9 div-padding">
						  			<input type="text" id="addrDetail" name="addrDetail" class="form-control form-control-sm" aria-describedby="passwordHelpInline" disabled>
  								</div>
  							</div>
						  	</div>
					</div>
					
				<!-- 네번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
							  	<div class="row">
							  		<span class="col-4 text-center ta font-set">사용자번호</span>
									<div class="col-7 div-padding">
										<input class="form-control form-control-sm" type="text" id="j" name="j" aria-label="Disabled input example" disabled>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-4">
						  	<div class="row">
								<span class="col-3 text-center ta font-set">교육기관번호</span>
								<div class="col-7 div-padding">
									<select class="form-select form-select-sm" id="k" name="k" aria-label=".form-select-sm example" disabled>
											<option selected value="">선택</option>
											<c:forEach items="${endst }" var="e" varStatus="status">
											<option value="${e.ENDST_NO}">${e.ENDST_NM }</option>
											</c:forEach>
									</select>
								</div>
							</div>
						 </div>
					</div>		 
			</div>		
							
					</div>
					</form>
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
	
	<!-- 우편번호 조회 API -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
</body>
</html>
