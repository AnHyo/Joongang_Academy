<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script>
$(function(){
 	const Grid = tui.Grid;
	
	Grid.applyTheme('clean', { 
		  row: { 
			    hover: { 
			      background: '#e9ecef' 
			    }
			  }
	});

		var CRCLM_HALF = "";
		var CRCLM_CD = "";
		var CRCLM_YEAR ="";
		var stdnt_no =$("#loginID").val();
		
		 $.post({
				url : "/stuinfoAjax",
				data : {
					"stdnt_no" : stdnt_no
				},
				dataType : "json"

			}).done(function(data) {
				var info = data.info;
				$("#stdntNo").val(info[0].STDNT_NO);
				$("#searchNM").val(info[0].KORN_FLNM_S);
				$("#regNM").val(info[0].REG_CD_NAME);
				$("#crclmYear").val(info[0].CRCLM_YEAR);
				$("#crclmHalf").val(info[0].CRCLM_HALF_NAME);
				$("#crclmNM").val(info[0].CRCLM_CD_NAME);
				$("#userBrdT").val(info[0].USER_BRDT);
				$("#genderNM").val(info[0].GENDER_CD_NAME);
				$("#relTel").val(info[0].TELNO);
				$("#emailAddr").val(info[0].EML_ADDR);
				$("#rprsNM").val(info[0].KORN_FLNM_L);
				
				 CRCLM_HALF = info[0].CRCLM_HALF;
				 CRCLM_CD = info[0].CRCLM_CD;
				 CRCLM_YEAR = info[0].CRCLM_YEAR;
				 $.post({
						url : "/estblSBJAjax",
						data : {
							
							"CRCLM_HALF" : CRCLM_HALF,
							"CRCLM_CD" : CRCLM_CD,
							"CRCLM_YEAR" : CRCLM_YEAR,
							"STDNT_NO" : stdnt_no
						},
						dataType : "json"

					}).done(function(data) {
						var estbl = data.estblSBJ;
						estblSBJ.resetData(estbl);
						var apply = data.applySBJ;
						applySBJ.resetData(apply);
						
						$("#search_value").attr("disabled",false);
						$("#search_name").attr("disabled",false);
						$(".esntlchk").attr("disabled",false);
						$("#sbjSearchbtn").attr("disabled",false);
					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); //estblSBJAjax 
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		 
		 
	
	
	
	class buttonRenderer{
		constructor(props) {
			const el = document.createElement('input');
			
			el.type='button';
			
			this.el = el;
			this.render(props);
			this.el.addEventListener('click', (event) => {
				
				var STDNT_NO=$("#stdntNo").val();
				var SBJCT_NO= el.getAttribute("data-value");

	 			$.post({
					url : "/addApplyAjax",
					data : {
						"STDNT_NO" : STDNT_NO,
						"SBJCT_NO" : SBJCT_NO,
						"CRCLM_HALF" : CRCLM_HALF,
						"CRCLM_CD" : CRCLM_CD,
						"CRCLM_YEAR" : CRCLM_YEAR
					},
					dataType : "json"

				}).done(function(data) {
					let check = data.check;
					let result = data.result;
					let classTMChk = data.classTMChk;
					if(check == 0){
						if(classTMChk == 0){
							if(result == 1){
							alert("신청을 완료했습니다.");
							var apply = data.applySBJ;
							applySBJ.resetData(apply);
							} else{
								alert("문제가 발생했습니다. 다시 시도 해주세요.");
							}
						} else{
							alert("시간이 중복됩니다.");
						}
					} else{
						alert("이미 신청한 과목입니다.");
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
				
				
			});
			
		}
		
		
		getElement(){
			return this.el;
		}
		
		render(props){
			this.el.value="신청";
			this.el.id="applybtn";
			this.el.setAttribute("data-value", props.value);
			this.el.setAttribute("class", "applybtn");
		}
	}
	
	class buttonRenderer2{
		constructor(props) {
			const el = document.createElement('input');
			
			el.type='button';
			
			this.el = el;
			this.render(props);
			this.el.addEventListener('click', (event) => {
				
				var STDNT_NO=$("#stdntNo").val();
				var SBJCT_NO= el.getAttribute("data-value");
				 $.post({
						url : "/delApplyAjax",
						data : {
							"STDNT_NO" : STDNT_NO,
							"SBJCT_NO" : SBJCT_NO,
							"CRCLM_HALF" : CRCLM_HALF,
							"CRCLM_CD" : CRCLM_CD,
							"CRCLM_YEAR" : CRCLM_YEAR
						},
						dataType : "json"

					}).done(function(data) {
						let result = data.result;
						let esntl = data.esntl;
						if(esntl == 0){
							if(result == 1){
								alert("신청을 취소했습니다.");
								var apply = data.applySBJ;
								applySBJ.resetData(apply);
							}
						} else{
							alert("필수과목입니다.");
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});  
				
				
				
			});
			
		}
		
		
		getElement(){
			return this.el;
		}
		
		render(props){
			this.el.value="삭제";
			this.el.id="delbtn";
			this.el.setAttribute("data-value", props.value);
			this.el.setAttribute("class", " delbtn");
		}
	}
	
	var estblSBJ = new tui.Grid({
  		el : document.getElementById('estblSBJ'),
		scrollX : false,
		scrollY : true,
		bodyHeight : 450,
		columns : [ 
		 {
			header : '필수구분',
			name : 'ESNTL_YN',
			width : 80,
			align:'center',
			formatter: function(e) {
			    if (e.value == 'Y') {
			      return '필수';
			    } else if(e.value == 'N') {
			      return '선택';
			    }
			 },
			 sortable: true,
			 sortingType: 'desc'
		}, {
			header : '개설과목명',
			name : 'SBJCT_NM',
			width : 210,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강사명',
			name : 'KORN_FLNM',
			width : 80,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강의시간',
			name : 'CLASSTM',
			width : 150,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		},{
			header : '강의실',
			name : 'ROOM_NM',
			width : 100,
			align:'center',
		 	sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강의계획서',
			name : 'SBJCT_PLAN_YN',
			width : 100,
			minwidth:'auto',
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		},{ 	
			header : '신청',
			name: 'SBJCT_NO', 
			renderer: { type: buttonRenderer },
			width: 60,
			align:'center'
		} ] 
	}); //estblSBJ grid
	
	
	
	var applySBJ = new tui.Grid({
  		el : document.getElementById('applySBJ'),
		scrollX : false,
		scrollY : true,
		bodyHeight : 450,
		columns : [ 
		 {
			header : '필수구분',
			name : 'ESNTL_YN',
			width : 80,
			align:'center',
			formatter: function(e) {
			    if (e.value == 'Y') {
			      return '필수';
			    } else if(e.value == 'N') {
			      return '선택';
			    }
			 },
			 sortable: true,
			 sortingType: 'desc'
		}, {
			header : '개설과목명',
			name : 'SBJCT_NM',
			width : 210,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강사명',
			name : 'KORN_FLNM',
			width : 80,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강의시간',
			name : 'CLASSTM',
			width : 150,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		},{
			header : '강의실',
			name : 'ROOM_NM',
			width : 100,
			align:'center',
		 	sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강의계획서',
			name : 'SBJCT_PLAN_YN',
			width : 100,
			minwidth:'auto',
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		},{ 	header : '삭제',
			name: 'SBJCT_NO', 
			renderer: { type: buttonRenderer2 },
			width: 60,
			align:'center'
		} ] 
	});// applySBJ grid

	$("#search_value,input[name=esntlchk]").on("keydown", function(key) {
		 if(key.keyCode == 13){
				$("#sbjSearchbtn").click();
		}
	});
	$("#sbjSearchbtn").click(function(){
		var search_value = $.trim($("#search_value").val());
		var search_name = $("#search_name").val();
		var esntlchk = $("input[name=esntlchk]:checked").val();
		 $.post({
				url : "/estblSBJAjax",
				data : {
					
					"CRCLM_HALF" : CRCLM_HALF,
					"CRCLM_CD" : CRCLM_CD,
					"CRCLM_YEAR" : CRCLM_YEAR,
					"STDNT_NO" : stdnt_no,
					"search_value" : search_value,
					"search_name" : search_name,
					"esntlchk" : esntlchk
				},
				dataType : "json"

			}).done(function(data) {
				var estbl = data.estblSBJ;
				estblSBJ.resetData(estbl);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			}); //estblSBJAjax Search 
		
		
	});
	
	
}); //function()
	

	
	
	
</script>
</head>

<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>
		<%@include file="./searchModal.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">
						<h5 class="fw-bolder">수강신청(학생)</h5>
					</div>
					<hr class="m-0 mb-2">
					<div class="float-start mb-2"
						style="width: 10px; height: 27px; background-color: #498c5f; margin-right: 10px;"></div>
					<h6 class="fw-bolder" style="line-height: 27px;">기본정보</h6>

					<!-- 검색 -->
					<div class="mb-3 d-flex justify-content-center">
						<div class="row"
							style="width: 100%; height: 120px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">
							<div class="row col-4">
								<div class="col-4 mt-4 d-flex justify-content-end fw-bolder"
									style="font-size: 14px;">학번(이름)</div>
								<input type="hidden" id="loginID" value="${sessionScope.id}">
								<div class="col-8 mt-3">
									<div class="input-group">
										<input type="text" class="form-control form-control-sm"
											id="stdntNo" disabled placeholder="학번"> <input
											type="text" class="form-control form-control-sm"
											placeholder="이름" id="searchNM" disabled>

									</div>
								</div>
							</div>
							<div class="row col-2" style="margin-left: 3px;">
								<div class="col-5 mt-4 d-flex justify-content-end fw-bolder"
									style="font-size: 14px;">학적상태</div>
								<div class="col-7 mt-3">
									<input type="text" class="form-control form-control-sm"
										id="regNM" disabled>
								</div>
							</div>
							<div class="row col-6">
								<div class="col-2 mt-4 d-flex justify-content-end fw-bolder"
									style="font-size: 14px;">과정구분</div>
								<div class="col-10 mt-3 ">
									<div class="input-group">
										<div class="col-2">
											<input type="text" class="form-control form-control-sm"
												style="border-radius: 5px 0 0 5px;" id="crclmYear" disabled>
										</div>
										<div class="col-2">
											<input type="text" class="form-control form-control-sm"
												style="border-radius: 0;" disabled id="crclmHalf">
										</div>
										<div class="col-8">
											<input type="text" class="form-control form-control-sm"
												style="border-radius: 0 5px 5px 0;" id="crclmNM" disabled>
										</div>
									</div>
								</div>
							</div>
							<div style="margin-left: 55px;">
								<div class="d-flex justify-content-center">
									<div class="row col-4">
										<div class="col-3 mt-2 d-flex justify-content-end fw-bolder"
											style="font-size: 14px;">생년월일</div>
										<div class="col-8 mt-1">
											<div class="input-group" style="margin-right: 5px;">
												<div class="col-8">
													<input type="text" class="form-control form-control-sm"
														style="border-radius: 5px 0 0 5px;" id="userBrdT" disabled>
												</div>
												<div class="col-4">
													<input type="text" class="form-control form-control-sm"
														style="border-radius: 0 5px 5px 0;" id="genderNM" disabled>
												</div>
											</div>
										</div>
									</div>
									<div class="row col-3">
										<div class="col-2 mt-2 d-flex justify-content-end fw-bolder"
											style="font-size: 14px;">연락처</div>
										<div class="col-8 mt-1">
											<input type="text" class="form-control form-control-sm"
												id="relTel" disabled>
										</div>
									</div>
									<div class="row col-3">
										<div class="col-2 mt-2 d-flex justify-content-end fw-bolder"
											style="font-size: 14px;">이메일</div>
										<div class="col-8 mt-1">
											<input type="text" class="form-control form-control-sm"
												id="emailAddr" disabled>
										</div>
									</div>
									<div class="row col-3">
										<div class="col-3 mt-2 d-flex justify-content-end fw-bolder"
											style="font-size: 14px;">대표강사</div>
										<div class="col-5 mt-1">
											<input type="text" class="form-control form-control-sm"
												id="rprsNM" disabled>
										</div>
									</div>


								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-6">
							<div class="row">
								<div class="col-3">
									<div class="float-start"
										style="width: 10px; height: 32px; background-color: #498c5f; margin-top: -5px; margin-right: 10px;"></div>
									<h6 class="fw-bolder">개설강좌</h6>
								</div>
								<div class="col-4">
									<div class="row"
										style="margin-left: 40px; margin-right: -50px;">
										<div class="col-4" style="margin-left: 20px;">
											<input type="radio" style="cursor: pointer;"
												disabled="disabled" checked="checked"
												class="form-check-input esntlchk" name="esntlchk"
												id="allchk" value=""> <label for="allchk"
												style="cursor: pointer; font-size: 14px;"
												class="text-center form-check-label">전체</label>
										</div>
										<div class="col-4" style="margin-left: -20px;">
											<input type="radio" style="cursor: pointer;"
												disabled="disabled" class="form-check-input esntlchk"
												name="esntlchk" id="Ychk" value="Y"> <label
												for="Ychk" style="cursor: pointer; font-size: 14px;"
												class="text-center form-check-label">필수</label>
										</div>
										<div class="col-4" style="margin-left: -20px;">
											<input type="radio" style="cursor: pointer;"
												disabled="disabled" class="form-check-input esntlchk"
												name="esntlchk" id="Nchk" value="N"> <label
												for="Nchk" style="cursor: pointer; font-size: 14px;"
												class="text-center form-check-label">선택</label>
										</div>
									</div>
								</div>
								<div class="col-5">
									<div class="input-group" style="margin-top: -5px;">
										<div class="col-3">
											<select class="form-control form-control-sm"
												disabled="disabled" name="search_name" id="search_name"
												style="border-radius: 5px 0 0 5px;">
												<option value="all" selected>전체</option>
												<option value="sbjNM">과목명</option>
												<option value="instrNM">강사명</option>
											</select>
										</div>
										<input type="text" name="search_value" id="search_value"
											disabled="disabled"
											class="form-control form-control-sm border-gray col-md-8"
											placeholder="검색어를 입력하세요">
										<button class="btn btn-dark btn-sm" type="button"
											disabled="disabled" id="sbjSearchbtn">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="float-start"
								style="width: 10px; height: 32px; background-color: #498c5f; margin-top: -5px; margin-right: 10px;"></div>
							<h6 class="fw-bolder">신청강좌</h6>
						</div>
					</div>
					<div class="row">
						<div class="col-6">
							<div id="estblSBJ" class="mb-3 mt-1"
								style="width: 100%; height: 500px;"></div>
						</div>
						<div class="col-6">
							<div id="applySBJ" class="mb-3 mt-1"
								style="width: 100%; height: 500px;"></div>
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
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>