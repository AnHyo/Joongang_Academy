<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0010")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
}
%>
<head>
<meta charset="utf-8" />
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
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="js/student/studentpost.js"></script>

<script>
	$(function() {
		var CRCLM_HALF = "";
		var CRCLM_CD = "";
		var CRCLM_YEAR = "";
		var stdnt_no = $("#loginID").val();
		$.post({
			url : "/stuinfoAjax",
			data : {
				"stdnt_no" : stdnt_no
			},
			dataType : "json"

		}).done(function(data) {
			var info = data.info;
			CRCLM_HALF = info[0].CRCLM_HALF;
			CRCLM_CD = info[0].CRCLM_CD;
			CRCLM_YEAR = info[0].CRCLM_YEAR;
			$.post({
				url : "/timetableAjax",
				data : {

					"CRCLM_HALF" : CRCLM_HALF,
					"CRCLM_CD" : CRCLM_CD,
					"CRCLM_YEAR" : CRCLM_YEAR,
					"STDNT_NO" : stdnt_no
				},
				dataType : "json"

			}).done(function(data) {
				var timetable = data.timetable;
				var colors = ['#FFD1DC', '#FFF0B5', '#B2FAB4', '#BFE6FF', '#E9C6EC', '#D1FFC3', '#D5A6FF', '#A2F3C5', '#C0B6F2', '#B7F0B1', '#D7B9FF', '#D1FFA9'];
				var colorIndex = 0;
				var SBJcolors = {};
				 for (var i = 0; i < timetable.length; i++) {
					var SBJNO = timetable[i].SBJCT_NO;
					var SBJNM = timetable[i].SBJCT_NM;
					var ROOM_NM = timetable[i].ROOM_NM;
					var INSTR_NM = timetable[i].KORN_FLNM;
					var DOW = timetable[i].DOW;
					var START = timetable[i].STARTt;
					var END = timetable[i].ENDt;
					var DOWarr = ['M', 'T', 'W', 'Th','F']; 
					var DOWarr2 = ['월', '화', '수', '목','금']; 
					if (DOW != null && START != null && END != null) {
						for(var j = 1; j<= 8; j++){
							for(var x = 0; x < DOWarr.length; x++){
								if(DOW == DOWarr2[x]+"요일"){
									if(START == $("#"+j+"K").attr("data-value")){
										$("#"+DOWarr[x]+j).html('<div style="line-height: 26px; background-color: '+ SBJColor(SBJNM) +';">'
												+'<div class="fw-bolder" style="font-size:15px;">'+SBJNM+'</div>'
												+'<div class="text-muted"  style="font-size:11px;">'+INSTR_NM+'</div>'
												+'<div class="text-muted" style="font-size:11px;">'+ROOM_NM+'</div>'
												+'</div>')
									}
									if(END == $("#"+j+"K").attr("data-value")){
										$("#"+DOWarr[x]+j).html('<div style="line-height: 26px;  background-color: '+ SBJColor(SBJNM) +';">'
												+'<div class="fw-bolder" style="font-size:15px;">'+SBJNM+'</div>'
												+'<div class="text-muted" style="font-size:11px;">'+INSTR_NM+'</div>'
												+'<div class="text-muted" style="font-size:11px;">'+ROOM_NM+'</div>'
												+'</div>');
									}
								}
							}
						}

					}
				}
					function SBJColor(SBJNM) {
						if (!SBJcolors[SBJNM]) {
							SBJcolors[SBJNM] = colors[colorIndex];
							colorIndex = (colorIndex + 1) % colors.length;
						}
							return SBJcolors[SBJNM];
					}

					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); 
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});

	});
</script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<input type="hidden" id="loginID" value="${sessionScope.id}">
		<!-- Page Content-->
		<div class="container px-5  my-5" id="checkdiv">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">시간표</span>
				</h1>
			</div>

			<div class="row gx-5 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">


					<div class="card shadow border-0 rounded-2 mt-4 mb-1 ">
						<div class="card-body p-4">
							<div class="d-flex justify-content-center">
								<table class="table table-border">
									<tr>
										<td class="col-2"></td>
										<td class="col-2 text-center">월</td>
										<td class="col-2 text-center">화</td>
										<td class="col-2 text-center">수</td>
										<td class="col-2 text-center">목</td>
										<td class="col-2 text-center">금</td>
									</tr>
									<%
									for (int i = 1; i <= 8; i++) {
									%>
									<tr>
										<td class="text-center" style="line-height: 60px;"
											id="<%=i%>K" data-value="<%=i%>교시"><%=i%>교시</td>
										<td class="text-center p-0" id="M<%=i%>"></td>
										<td class="text-center p-0" id="T<%=i%>"></td>
										<td class="text-center p-0" id="W<%=i%>"></td>
										<td class="text-center p-0" id="Th<%=i%>"></td>
										<td class="text-center p-0" id="F<%=i%>"></td>
									</tr>
									<%
									}
									%>


								</table>
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

	<!-- 우편번호 조회 API -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
