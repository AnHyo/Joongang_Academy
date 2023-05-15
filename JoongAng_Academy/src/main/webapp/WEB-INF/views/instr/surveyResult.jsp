<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0020")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
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
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Custom Google font-->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@100;200;300;400;500;600;700;800;900&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="css/styles2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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
	
	var loginID = $("#loginID").val(); //(로그인된 ID)
	
	/* 설문과목정보 ajax */
	$.post({
		url: "/surveyResultAjax",
		async: false,
		data: {
			"loginID": loginID
		},
		cache: false,
		dataType: "json"
	}).done(function(data) {
		var list = data.list;

		class buttonRenderer{
			constructor(props) {
				const el = document.createElement('input');
				el.type='button';
				const Nn = document.createElement('span');
				Nn.textContent = '';
				this.value = props.value; // 1 (해당 컬럼 값)
				this.rowKey = props.rowKey;
				this.el = el;
				this.n = Nn;
				this.render(props);
			}
			
			getElement(){    	
				if(this.value =='0'){
					return this.n;
				} 
				else {
					return this.el;
				}
			}
			
			render(props){
				var { rowKey } = props;
				var row = suvGrid.getRow(rowKey);
				var CRCLM_CD = row.CRCLM_CD;
				var CRCLM_YEAR = row.CRCLM_YEAR;
				var CRCLM_HALF = row.CRCLM_HALF;
				var SBJCT_NO = row.SBJCT_NO;
				
				this.el.value="결과보기"; //value 값
				this.el.id="survRs"; // id 값
				this.el.setAttribute("class", "btn btn-success rounded-2 fw-bold "); // class값
				this.el.setAttribute("style","width:60px; color:white;"); //style값
				
				this.el.addEventListener('click', (event) => {
					window.location.href = 
					"http://localhost/surveyResultDetail?CC=" + 
					CRCLM_CD + "&CY=" + CRCLM_YEAR + "&CH=" + CRCLM_HALF + "&SN=" + SBJCT_NO;
				});
				return this.getElement();
			}
		} 
		
		var suvGrid = new tui.Grid({
		      el: document.getElementById('suvListGrid'),
		      scrollX: true,
		      scrollY: true,
		      columns: [
		    	{
			          header: '년도',
			          name: 'CRCLM_YEAR',
			          align:'center',
					  sortingType: 'desc',
					  sortable: true,
			     },
		    	{
			          header: '분기',
			          name: 'CRCLM_HALF_NM',
			          align:'center',
					  sortingType: 'desc',
					  sortable: true,
			     },
		    	{
			          header: '과목코드',
			          name: 'SBJCT_NO',
			          align:'center',
					  sortingType: 'desc',
					  sortable: true,
					  hidden: true
			     },
		    	{
			          header: '과목코드',
			          name: 'SBJCT_NO',
			          align:'center',
					  sortingType: 'desc',
					  sortable: true,
					  hidden: true
			     },
		        {
		          header: '훈련과정명',
		          name: 'CRCLM_CD_NM',
		          align:'center',
				  sortingType: 'desc',
				  sortable: true
		        },
		        {
		          header: '과목명',
		          name: 'SBJCT_NM',
		          align:'center',
				  sortingType: 'desc',
				  sortable: true
		        },
		        {
		          header: '설문명',
		          name: 'DGSTFN_TITLE',
		          align:'center',
				  sortingType: 'desc',
				  sortable: true
		        },
				{
					  header : '결과조회',
					  name : 'BUTTON',
					  align:'center',
					  sortingType: 'desc',
					  sortable: true,
					  renderer: buttonRenderer
					}],
			selectionUnit: 'row'
			
			});
		suvGrid.resetData(list);
	
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
		<%@include file="../portalbar/instrtopbar.jsp"%>
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
						<h4 class="text-success fw-bolder mb-0">과목현황</h4>
					</div>
					<!-- 설문조사 현황  -->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="mt-2" id="suvListGrid"></div>
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