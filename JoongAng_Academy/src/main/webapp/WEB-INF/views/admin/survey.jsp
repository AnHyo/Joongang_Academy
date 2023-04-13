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
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script type="text/javascript">
$(function() {
	var dataSource = {
			api: {
				  readData: { url: '/api/readData', method: 'GET' },
				  createData: { url: '/api/createData', method: 'POST' },
				  updateData: { url: '/api/updateData', method: 'PUT' },
				  modifyData: { url: '/api/modifyData', method: 'PUT' },//저장버튼(수정,삭제, 추가)
				  deleteData: { url: '/api/deleteData', method: 'DELETE' }
			}
		};
	//검색버튼
	$("#search_btn").click(function(){
	var survey_search = $("#survey_search").val();
		alert(survey_search);
		$.post({
			url : "/surveyListAjax",
			dataType : "json",
			cache : false,
			data: {"survey_search" : survey_search}
		}).done(function(data) {
	  	  grid.resetData(data.list);
	  	  
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
	});
	
		$.post({
			url : "/surveyListAjax",
			dataType : "json"

		}).done(function(data) {
			grid.resetData(data.list);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		const Grid = tui.Grid;
		Grid.applyTheme('clean');

		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			scrollX : false,
			scrollY : true,
			bodyHeight : 250,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : '설문번호',
				name : 'DGSTFN_NO'
			}, {
				header : '설문명',
				name : 'DGSTFN_TITLE',
			}, {
				header : '훈련과정',
				name : 'CRCLM_NM'
			}, {
				header : '등록일자',
				name : 'DGSTFN_YMD',
				editor: {
					type: 'datePicker',
					options: {
						formate: 'yyyy-MM-dd'
					}
				}
			}, {
				header : '설문시작일',
				name : 'DGSTFN_SDATE',
			}, {
				header : '설문종료일',
				name : 'DGSTFN_FDATE',
			}, {
				header : '년도',
				name : 'CRCLM_YEAR',
			}, {
				header : '분기',
				name : 'CRCLM_HALF'
			} ]
		});
		
		//surveyview
		var grid2 = new tui.Grid({
			el : document.getElementById('grid2'),
			scrollX : false,
			scrollY : true,
			bodyHeight: 150,
			rowHeaders : [ 'checkbox' ],
			columns : [ 
				{
					header : '문항번호',
					name : 'QITEM_CD',
					width: 100,
					align : 'center',
					editor: 'text'
				}, {
					header : '문항명',
					name : 'DGST_CN',
					width: 700,
					align : 'center',
					editor: 'text'
				}, {
					header : '답변방식',
					name : 'DGSTFN_ANS_T',
					width: 200,
					align : 'center',
					copyOptions:{
						 useListItemText: true
					},formatter: 'listItemText',
			          editor: {
			              type: 'radio',
			              options: {
			                listItems: [
			                  { text: '주관식', value: '0010' },
			                  { text: '객관식', value: '0020' }
			                ]
			              }
			            }
				}, {
					header : '답변허용갯수',
					name : 'DGSTFN_ANS_N',
					width: 100,
					align : 'center',
					editor: 'text'
				}],
		});
		
		//applinfoview
		var grid3 = new tui.Grid({
			el : document.getElementById('grid3'),
			scrollX : false,
			scrollY : true,
			bodyHeight: 150,
			rowHeaders : [ 'checkbox' ],
			columns : [ 
				{
					header : '사용자번호',
					name : 'USER_NO',
					width: 100,
					align : 'center',
					editor: 'text'
				}, {
					header : '성명',
					name : 'KORN_FLNM',
					width: 700,
					align : 'center',
					editor: 'text'
				}, {
					header : '훈련과정',
					name : 'CRCLM_NM',
					width: 200,
					align : 'center'
				}, {
					header : '휴대전화',
					name : 'TELNO',
					width: 100,
					align : 'center',
					editor: 'text'
				}],
		});

	});
</script>
<style type="text/css">
ml-10 { margin-left: 10px;}
</style>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">
						<h5 class="fw-bolder">설문조사관리</h5>
					</div>
					<hr style="height: 4px;" class="m-0 mb-1">
					<div class="d-flex justify-content-end pb-1 mb-2 mt-2">
						<div>
							<button type="button" class="btn btn-secondary btn-sm" id="search_btn">조회</button>
							<button type="button" class="btn btn-secondary btn-sm">신규</button>
							<button type="button" class="btn btn-secondary btn-sm">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm">저장</button>
						</div>
					</div>
					<div
						style="width: 100%; background-color: #F3FAFE; height: 60px; border: 1px solid #c0c0c0; position: relative;">
						<div
							style="position: absolute; width: 100%; top: 50%; transform: translateY(-50%) translateX(10%);">
							<div class="input-group " style="width: calc(20%); float: left;">
								학년도 <input type="text" class="form-control form-control-sm"
									style="margin-left: 10px;" placeholder="2023"> <select
									class="form-select form-select-sm">
									<option>상반기</option>
									<option>하반기</option>
								</select>
							</div>
							<!-- 검색 -->
							<div class="input-group "
								style="width: calc(15%); margin-left: 10px; float: left;">설문명(번호)
								<input class="form-control form-control-sm" type="text" name="survey_search" id="survey_search"
									placeholder="설문명(번호)" aria-describedby="btnNavbarSearch" style="margin-left: 10px;"/>
							</div>

							<div class="input-group "
								style="width: calc(40%); margin-left: 10px; float: left;">
								훈련과정명 <select class="form-select form-select-sm"
									style="margin-left: 10px;">
									<option>상반기</option>
									<option>하반기</option>
								</select>
							</div>
						</div>
					</div> <!-- 상단 끝 -->
					
					<!-- 설문정보 -->
					<h6 class="mt-3 fw-bolder">설문정보</h6>
					<div>
						<div id="grid"></div>
					</div>

					<!-- tab -->
					<div class="mt-3">
					<nav>
					  <div class="nav nav-tabs" id="nav-tab" role="tablist">
					    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">기본정보</button>
					    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">문항정보</button>
					    <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">참석자정보</button>
					  </div>
					</nav>	
						<!--기본정보 -->
						<div class="tab-content" id="nav-tabContent">
						  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
							<!--기본정보 -->
							<div class="mb-5" id="tab1"
								style="width: 100%; background-color: #F3FAFE; height: 420px; border: 1px solid #c0c0c0; position: relative;">
								<table
									style="width: 90%; position: absolute; top: 50%; transform: translateY(-50%) translateX(5%);">
									<tr style="height: 50px">
										<td class="col-1" style="text-align: right;">설문관리번호</td>
										<td class="col-2"><input type="text" class="form-control form-control-sm" style="margin-left: 10px;"></td>
										<td class="col-1" style="text-align: right;">학년도</td>
										<td class="col-2">
											<div class="input-group " style="float: left;">
												<input type="text" class="form-control form-control-sm"
													style="margin-left: 10px;" placeholder="2023"> <select
													class="form-select form-select-sm">
													<option>상반기</option>
													<option>하반기</option>
												</select>
											</div>
										</td>
										<td class="col-1" style="text-align: right;">교육과정</td>
										<td class="col-4">
											<div class="input-group " style="float: left;">
												<select class="form-select form-select-sm"
													style="margin-left: 10px;">
													<option>상반기</option>
													<option>하반기</option>
												</select>
											</div>
										</td>
									</tr>
									
									<tr style="height: 50px">
										<td style="text-align: right;">등록일자</td>
										<td class="col-2"><input type="text" class="form-control form-control-sm" style="margin-left: 10px;"></td>
										<td style="text-align: right;" >설문시작일시</td>
										<td class="col-2"><input type="text" class="form-control form-control-sm" style="margin-left: 10px;"></td>
										<td style="text-align: right;">설문종료일시</td>
										<td class="col-2"><input type="text" class="form-control form-control-sm" style="margin-left: 10px;"></td>
									</tr>
									
									<tr style="height: 50px">
										<td style="text-align: right;">설문명</td>
										<td><input type="text" class="form-control form-control-sm" style="margin-left: 10px;"></td>
									</tr>
									<tr>
										<td style="text-align: right; float:top;">안내문구</td>
										<td colspan="3"><textarea class="form-control"
												style="height: 200px; resize: none; margin-left: 10px;"></textarea></td>
									</tr>
								</table>
							</div>
							</div>
						  <!-- 문항정보 -->
						  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
							  <div>
								<div id="grid2"></div>
							  </div>
						  </div>
						  <!-- 참석자정보 -->
						  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
							  <div>
								<div id="grid3"></div>
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
</body>
</html>