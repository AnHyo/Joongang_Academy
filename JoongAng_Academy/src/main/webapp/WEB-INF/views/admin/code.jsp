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
	var code_search = $("#code_search").val();
		alert(code_search);//ok
		$.post({
			url : "/codeListAjax",
			dataType : "json",
			cache : false,
			data: {"code_search" : code_search}
		}).done(function(data) {
	  	  grid.resetData(data.list);
	  	  
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
	});
	
	//grid1 전체리스트     
	$.post({
		url : "/codeListAjax",
		dataType : "json"
	}).done(function(data) {
  	  grid.resetData(data.list);
	}).fail(function() {
		alert("문제가 발생했습니다.");
	});
	
	//td 클릭
	$(document).on('click', 'td', function() {
     var rowKey = $(this).attr('data-row-key'); //0(번째)
     //var columnKey = $(this).attr('data-column-name'); //CD_NM
     var CD_CLSFValue = grid.getValue(rowKey, 'CD_CLSF'); //td값
     //alert('Clicked CD_CLSF value:' + CD_CLSFValue); //0번째의 CD_CLSF값 //0000
     
	 	$.post({
			url : "/codeListAjax2",
			dataType : "json",
	 		data: {"CD_CLSFValue" : CD_CLSFValue}
		}).done(function(data) {
	  	  grid2.resetData(data.detaillist);
		}).fail(function() {
			alert("문제가 발생했습니다!");
		});
    });  
	
	//td 재클릭
	$("td").change(function(){
	   var rowKey = $(this).attr('data-row-key'); //0(번째)
	     //var columnKey = $(this).attr('data-column-name'); //CD_NM
	     var CD_CLSFValue = grid.getValue(rowKey, 'CD_CLSF'); //td값
	     //alert('Clicked CD_CLSF value:' + CD_CLSFValue); //0번째의 CD_CLSF값 //0000
	     
		 	$.post({
				url : "/codeListAjax2",
				dataType : "json",
		 		data: {"CD_CLSFValue" : CD_CLSFValue}
			}).done(function(data) {
		  	  grid2.resetData(data.detaillist);
			}).fail(function() {
			alert("문제가 발생했습니다!");
		});
	});
	
	//행추가
	/* $("#add_btn").click(function(){
		alelrt("클릭");
		grid.request('createDate');
	}); */
	
	const Grid = tui.Grid;
    Grid.applyTheme('clean');
    
	var grid = new tui.Grid({
		el : document.getElementById('grid'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 200,
		data: dataSource,
		rowHeaders : [ 'checkbox' ],
		columns : [ 
		{
			header : '코드분류',
			name : 'CD_CLSF',
			width: 100,
			align : 'center',
			editor: 'text'
		}, {
			header : '코드',
			name : 'CD',
			width: 100,
			align : 'center',
			editor: 'text'
		}, {
			header : '코드명',
			name : 'CD_NM',
			width: 250,
			align : 'center',
			editor: 'text'
		}, {
			header : '코드사용여부',
			name : 'CD_USE_YN',
			width: 100,
			align : 'center',
			copyOptions:{
				 useListItemText: true
			},formatter: 'listItemText',
	          editor: {
	              type: 'radio',
	              options: {
	                listItems: [
	                  { text: 'Y', value: '0010' },
	                  { text: 'N', value: '0020' }
	                ]
	              }
	            }
		}, {
			header : '코드설명',
			name : 'CD_EXPLN',
			align : 'center',
			editor: 'text'
		}, {
			header : '코드정렬일련번호',
			name : 'CD_SORT_SN',
			width: 120,
			align : 'center',
			editor: 'text'
		} ]
	});
	
	//양식
	var grid2 = new tui.Grid({
		el : document.getElementById('grid2'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 200,
		rowHeaders : [ 'checkbox' ],
		columns : [ 
			{
				header : '코드분류',
				name : 'CD_CLSF',
				width: 100,
				align : 'center',
				editor: 'text'
			}, {
				header : '코드',
				name : 'CD',
				width: 100,
				align : 'center',
				editor: 'text'
			}, {
				header : '코드명',
				name : 'CD_NM',
				width: 250,
				align : 'center',
				editor: 'text'
			}, {
				header : '코드사용여부',
				name : 'CD_USE_YN',
				width: 100,
				align : 'center',
				copyOptions:{
					 useListItemText: true
				},formatter: 'listItemText',
		          editor: {
		              type: 'radio',
		              options: {
		                listItems: [
		                  { text: 'Y', value: '0010' },
		                  { text: 'N', value: '0020' }
		                ]
		              }
		            }
			}, {
				header : '코드설명',
				name : 'CD_EXPLN',
				align : 'center',
				editor: 'text'
			}, {
				header : '코드정렬일련번호',
				name : 'CD_SORT_SN',
				width: 120,
				align : 'center',
				editor: 'text'
			} ],
	});

});


</script>
</head>
<style type="text/css">
.btns {
	float: right;
}

button {
	border: 1px solid gray;
}
</style>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">
						<h5 class="fw-bolder">공통코드관리</h5>
					</div>
					<hr style="height: 4px;" class="m-0 mb-1">
							<div style="float:left;"><h6 class="mt-3 fw-bolder">코드구분</h6></div>
					<div class="d-flex justify-content-end pb-1 mb-2 mt-2">
						<!-- 검색 -->
<!-- 						<form action="/code" name="searchForm" onsubmit="return false" method="get"> -->
							<div class="input-group"
								style="width: calc(20%); margin-right: 10px; float: left;">
								<input class="form-control form-control-sm" type="text" name="code_search" id="code_search"
									placeholder="검색어를 입력하세요" aria-describedby="btnNavbarSearch" />
								<button class="btn btn-secondary btn-sm" id="search_btn"
									type="button">
									<i class="fas fa-search"></i>
								</button>
							</div>
<!-- 						</form> -->
						<!-- 버튼 -->
						<div>
							<button type="button" class="btn btn-secondary btn-sm" onclick="grid.request('createData')" id="add_btn">신규</button>
							<button type="button" class="btn btn-secondary btn-sm">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm" onclick="grid.request('updateData')">저장</button>
						</div>
					</div>
					<div>
						<div id="grid"></div>
					</div>
					<div style="float:left;"><h6 class="mt-3 fw-bolder">코드정보</h6></div>
					<div class="d-flex justify-content-end pb-1 mb-2 mt-2">
						<div>
							<button type="button" class="btn btn-secondary btn-sm">신규</button>
							<button type="button" class="btn btn-secondary btn-sm">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm">저장</button>
						</div>
					</div>
					<div>
						<div id="grid2"></div>
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


	<!-- TOAST UI Grid -->
	<link rel="stylesheet"
		href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>


</body>
</html>
