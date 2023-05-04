<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%>
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
$(function(){
var Grid = tui.Grid;
	Grid.applyTheme('clean', { 
		  row: { 
			    hover: { 
			      background: '#e9ecef' 
			    }
			  }
	});
	
	var searchParams = new URLSearchParams(location.search);
	var CC = searchParams.get('CC'); 
	var CY = searchParams.get('CY'); 
	var CH = searchParams.get('CH'); 
	var SN = searchParams.get('SN'); 
	
 /* 	$.post({
		url: "/ResultDetailAjax",
		data: {
			"CRCLM_CD": CC,
			"CRCLM_YEAR": CY,
			"CRCLM_HALF": CH,
			"SBJCT_NO": SN
		},
		cache: false,
		dataType: "json"
	}).done(function(data) {
	var resultDetail = data.resultDetail;
	var dgstfnNo = data.dgstfnNo;
	
	   var dgstfnNoColumns = dgstfnNo.map(function(item) {
	        return {
	            header: item.DGSTFN_NO,
	            name: item.DGSTFN_NO + '번',
	            width:140
	        }
	    });
   
	   var grid1 = new tui.Grid({
	       el: document.getElementById('grid1'),
	       scrollX: true,
	       scrollY: true,
	       rowHeaders: [
	           {
	               type: 'rowNum',
	               header: 'No.'
	           }
	       ],
	       columns: dgstfnNoColumns,
	       data: resultDetail,
	       selectionUnit: 'row'
	   }); 
   
	}).fail(function() {
		alert("문제가 발생 했습니다.");
	}); */

   
		    
		 var grid2 = new tui.Grid({
		        el: document.getElementById('grid2'),
		        scrollX: true,
		        scrollY: true,
		        columns: [
		        {
		        	header : '문항명',
					name : 'DGSTFN_CN',
					align : 'center',
					sortable: true,
				    sortingType: 'desc'	
		        },
		        {
		        	header : '응답자',
					name : 'DGSTFN_CN',
					align : 'center',
					sortable: true,
				    sortingType: 'desc'	
		        },
		        {
		        	header : '평균',
					name : 'DGSTFN_CN',
					align : 'center',
					sortable: true,
				    sortingType: 'desc'	
		        },
		        {
		        	header : '여자',
					name : 'DGSTFN_CN',
					align : 'center',
					sortable: true,
				    sortingType: 'desc'	
		        },
		        {
		        	header : '남자',
					name : 'DGSTFN_CN',
					align : 'center',
					sortable: true,
				    sortingType: 'desc'	
		        },
		        	
		        ],
		        selectionUnit: 'row'
		    });
	
		 $.post({
				url: "/ResultDetailAjax",
				data: {
					"CRCLM_CD": CC,
					"CRCLM_YEAR": CY,
					"CRCLM_HALF": CH,
					"SBJCT_NO": SN
				},
				cache: false,
				dataType: "json"
			}).done(function(data) {

				
			}).fail(function() {
				alert("문제가 발생 했습니다.");
			});
	
	
	
});

</script>
<style type="text/css">
.tui-grid-cell {
  font-size: 14px;
}
</style>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<!-- Page Content-->
		<!-- 설문조사 현황 -->
		<div id ="readySuv">
		<div class="my-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">설문조사 결과 조회</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-xlg-11 col-xl-9 col-xxl-8">
					
					<input type="hidden" id="loginID" value="${sessionScope.id}">


					<!-- Divider-->
					<div class="pb-5"></div>
					
					<div class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">설문조사결과</h4>
					</div>
					<!-- 설문조사결과  -->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="mt-2" id="grid1"></div>
						</div>
					</div>
					
					<div class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">총계표</h4>
					</div>
					<!-- 총계표  -->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="mt-2" id="grid2"></div>
						</div>
					</div>

				</div>
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