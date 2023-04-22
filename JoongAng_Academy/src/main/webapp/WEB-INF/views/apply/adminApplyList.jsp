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
	function loadData2(){
	var searchNM = $.trim($("#searchNM2").val());
	var searchyear = $.trim($("#crclm_year").val());
	var searchhalf = $.trim($("#crclm_half").val());
	var searchCN = $.trim($("#crclm_cd_name").val());
	
		 $.post({
				url : "/stuListAjax",
				 data : {
					"searchnm" : searchNM,
					"searchyear" : searchyear,
					"searchhalf" : searchhalf,
					"searchCN" : searchCN
					
				}, 
				dataType : "json"

			}).done(function(data) {
				var list = data.list;
				stuList.resetData(list);
				var rowCount = stuList.getRowCount();
				
				let selectedRowKey = null;
				// cell 하나 클릭시 한 줄 전체 범위 지정
				stuList.on('focusChange', (ev) => {
					stuList.setSelectionRange({
					    start: [ev.rowKey, 0],
					    end: [ev.rowKey, stuList.getColumns().length]
					  });
				});

				
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
	};
	function loadData(){
	var searchNM = $.trim($("#searchNM").val());
		 $.post({
				url : "/stuListAjax",
				 data : {
					"searchnm" : searchNM
				}, 
				dataType : "json"

			}).done(function(data) {
				var list = data.list;
				stuList.resetData(list);
				var rowCount = stuList.getRowCount();
				
				let selectedRowKey = null;
				// cell 하나 클릭시 한 줄 전체 범위 지정
				stuList.on('focusChange', (ev) => {
					stuList.setSelectionRange({
					    start: [ev.rowKey, 0],
					    end: [ev.rowKey, stuList.getColumns().length]
					  });
				});

				
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
	};
	
	//모달 띄울때 그리드 새로고침
	$('#stuSearchModal').on('shown.bs.modal', function(e) {
		stuList.refreshLayout();
		stuList.off('click');	
		 $.post({
				url : "/stuListAjax",
				dataType : "json"

			}).done(function(data) {
				var list = data.crclmlist;
				if(list != null){
				var option ="<option value='' hidden selected>선택</option>";
					for(var i = 0; i < list.length; i++){
						option += "<option value='"+list[i].CD+"'>"+list[i].CD_NM+"</option>";
					}
					$(".crclmNameList").append(option);
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
	});

	//화면 끌 경우 초기화
	$('#stuSearchModal').on('hidden.bs.modal', function(e) {
		stuList.resetData([]);
		$(".crclmNameList").empty();
		stuList.off('click');
	});
	
	$("#searchbtn").click(function(){
		if($("#searchNM").val() == ""){
			alert("학번이나 이름을 입력해주세요");
			$("#searchNM").focus();
			return false;
		}
		$("#stuSearchModal").modal("show");
		$("#searchNM2").val($("#searchNM").val());
		loadData();
	});
	$("#searchNM").keydown(function(key){
		  if(key.keyCode == 13){
			$("#searchbtn").click();
		  }
		});
	
	$("#searchbtn2").click(function(){
		$("#searchNM2").val($("#searchNM2").val());
		loadData2();
	});

	$("#searchNM2,#crclm_year,#crclm_half,#crclm_cd_name").on("keydown", function(key) {
		 if(key.keyCode == 13){
				$("#searchNM2").val($("#searchNM2").val());
				$("#searchbtn2").click();
			  }
	});

	
 	const Grid = tui.Grid;
	
	Grid.applyTheme('clean', { 
		  row: { 
			    hover: { 
			      background: '#e9ecef' 
			    }
			  }
	});
	 $("#stuSearchModal").on("keydown", function(key) {
		    if (key.keyCode == 13 ) {
		       $("#selectbtn").click();
		    }
	 });
	
	var stuList = new tui.Grid({
  		el : document.getElementById('stuList'),
		scrollX : false,
		scrollY : true,
		bodyHeight : 400,
		rowHeaders: ['rowNum'],
		columns : [ 
		{
			header : '학번',
			name : 'STDNT_NO',
			width : 150,
			align:'center'
		}, {
			header : '이름',
			name : 'KORN_FLNM_S',
			width : 150,
			align:'center'
		}, {
			header : '성별',
			name : 'GENDER_CD_NAME',
			width : 80,
			align:'center'
		}, {
			header : '생일',
			name : 'USER_BRDT',
			width : 200,
			align:'center'
		}, {
			header : '학적상태',
			name : 'REG_CD_NAME',
			width :130,
			align:'center'
		} ] 
	});
	
	var CRCLM_HALF = "";
	var CRCLM_CD = "";
	var CRCLM_YEAR ="";
	var stdnt_no ="";
	$("#selectbtn").click(function(){
		const rowKey = stuList.getFocusedCell().rowKey
		var obj = stuList.getRow(rowKey);
		var values = Object.values(obj);
		stdnt_no = values[0];
		
		 $.post({
				url : "/stuinfoAjax",
				data : {
					"stdnt_no" : stdnt_no
				},
				dataType : "json"

			}).done(function(data) {
				var info = data.info;
				$("#stuSearchModal").modal("hide");
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
						url : "/applyHistAjax",
						data : {
							
							"CRCLM_HALF" : CRCLM_HALF,
							"CRCLM_CD" : CRCLM_CD,
							"CRCLM_YEAR" : CRCLM_YEAR,
							"STDNT_NO" : stdnt_no
						},
						dataType : "json"

					}).done(function(data) {
						var aHist = data.applyHist;
						applyHist.resetData(aHist);
						$("#search_value").attr("disabled",false);
						$("#sbjSearchbtn").attr("disabled",false);
					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); //applyHistAjax 
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		 
		 
	});
	$("#search_value").keydown(function(key){
		  if(key.keyCode == 13){
			$("#sbjSearchbtn").click();
		  }
	});
	$("#sbjSearchbtn").click(function(){
		var search_value = $.trim($("#search_value").val());
		 $.post({
				url : "/applyHistAjax",
				data : {
					
					"CRCLM_HALF" : CRCLM_HALF,
					"CRCLM_CD" : CRCLM_CD,
					"CRCLM_YEAR" : CRCLM_YEAR,
					"STDNT_NO" : stdnt_no,
					"search_value" : search_value
				},
				dataType : "json"

			}).done(function(data) {
				var aHist = data.applyHist;
				applyHist.resetData(aHist);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			}); //applyHistAjax Search 
		
		
	});

	
	var applyHist = new tui.Grid({
  		el : document.getElementById('applyHist'),
		scrollX : false,
		scrollY : true,
		bodyHeight : 450,
		columns : [ 
		 {
			header : '필수구분',
			name : 'ESNTL_YN',
			width : 150,
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
			width : 350,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강사명',
			name : 'KORN_FLNM_L',
			width : 180,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강의시간',
			name : 'CLASSTM',
			width : 200,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		},{
			header : '강의실',
			name : 'ROOM_NM',
			width : 150,
			align:'center',
		 	sortable: true,
		    sortingType: 'desc'
		}, {
			header : '강의계획서 등록여부',
			name : 'SBJCT_PLAN_YN',
			width : 200,
			minwidth:'auto',
			align:'center',
			sortable: true,
		    sortingType: 'desc'
		},{
			header:'구분',
			name : 'CD',
			width:150,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
			
		},{
			header:'신청일자',
			name : 'DT',
			width:220,
			align:'center',
			sortable: true,
		    sortingType: 'desc'
			
		}] 
	}); //applyHist grid
	
	

	
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
						<h5 class="fw-bolder">수강신청내역</h5>
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
								<div class="col-8 mt-3">
									<div class="input-group">
										<input type="text" class="form-control form-control-sm"
											id="stdntNo" disabled> <input type="text"
											class="form-control form-control-sm" placeholder="이름"
											id="searchNM">
										<button class="btn btn-dark btn-sm" type="button"
											id="searchbtn">
											<i class="fas fa-search"></i>
										</button>
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

					<div class="d-flex justify-content-between">
						<div class="col-10">
							<div class="float-start"
								style="width: 10px; height: 32px; background-color: #498c5f; margin-top: -5px; margin-right: 10px;"></div>
							<h6 class="fw-bolder" style="margin-top:2px;">수강신청내역</h6>
						</div>
						<div class="col-2" style="margin-top: 2px;">
							<div class="input-group" style="margin-top: -5px;">
								<input type="text" name="search_value" id="search_value"
									disabled="disabled"
									class="form-control form-control-sm border-gray col-md-10"
									placeholder="과목명을 검색하세요.">
								<button class="btn btn-dark btn-sm" type="button"
									disabled="disabled" id="sbjSearchbtn">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</div>
					<div id="applyHist" class="mb-3 mt-2"
						style="width: 100%; height: 500px;"></div>






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