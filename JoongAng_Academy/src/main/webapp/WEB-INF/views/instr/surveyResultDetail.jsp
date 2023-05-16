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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script type="text/javascript">
	$(function() {
		var Grid = tui.Grid;
		Grid.applyTheme('clean', {
			row : {
				hover : {
					background : '#e9ecef'
				}
			}
		});

		var searchParams = new URLSearchParams(location.search);
		var CC = searchParams.get('CC');
		var CY = searchParams.get('CY');
		var CH = searchParams.get('CH');
		var SN = searchParams.get('SN');

		$.post({
			url : "/ResultDetailAjax",
			data : {
				"CRCLM_CD" : CC,
				"CRCLM_YEAR" : CY,
				"CRCLM_HALF" : CH,
				"SBJCT_NO" : SN
			},
			cache : false,
			dataType : "json"
		}).done(function(data) {
			var resultDetail = data.resultDetail;
			//해당 설문조사가 갖고있는 문항갯수 
			var dgstfnCount = resultDetail[0].DGSTFN_COUNT;
			//문항갯수만큼 컬럼생성 (최대23)
			var columns = [];
			for (var i = 1; i <= dgstfnCount; i++) {
				var column = {
					header : i + '번',
					name : i + '번',
					sortable : true,
					resizable : true, //컬럼크기 수동조정 가능
					width : 100,
					//자동줄바꿈
					/*  renderer: { 
					     styles: {
					         whiteSpace: 'pre-wrap'
					     }
					 },  */
					sortingType : 'desc'
				};
				columns.push(column);
			}

			var grid1 = new tui.Grid({
				el : document.getElementById('grid1'),
				scrollX : true,
				scrollY : true,
				rowHeaders : [ {
					type : 'rowNum',
					header : 'No.'
				} ],
				columns : columns,
				selectionUnit : 'row'
			});

			grid1.resetData(data.resultDetail);
			grid1.resetColumnWidths();
			grid2.resetData(data.resultDetail2);
		}).fail(function() {
			alert("문제가 발생 했습니다.");
		});

		var grid2 = new tui.Grid({
			el : document.getElementById('grid2'),
			scrollX : true,
			scrollY : true,
			rowHeaders : [ {
				type : 'rowNum',
				header : 'No.',
			} ],
			columns : [ {
				header : '문항명',
				name : 'DGSTFN_CN',
				sortable : true,
				resizable : true,
				sortingType : 'desc'
			}, {
				header : '응답자',
				name : 'atnd_num',
				align : 'center',
				width : 100,
				sortable : true,
				sortingType : 'desc'
			}, {
				header : '평균',
				name : 'AVG_CHC_ANS_CD',
				align : 'center',
				width : 100,
				sortable : true,
				sortingType : 'desc'
			} ],
			selectionUnit : 'row'
		});

	});
</script>
<style type="text/css">
.tui-grid-cell {
	font-size: 14px;
}

.tbc {
	text-align: center;
	vertical-align: middle;
}

tbody tr {
	height: 220px;
}

.textarea-wrapper {
	position: relative;
}

#char-count {
	position: absolute;
	right: 6px;
	bottom: 5px;
	color: gray;
}
</style>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/instrtopbar.jsp"%>
		<!-- Page Content-->
		<!-- 설문조사 현황 -->
		<div id="readySuv">
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

						<div>
							<div
								class="d-flex align-items-center justify-content-between mb-4 px-3">
								<h4 class="text-success fw-bolder mb-0">설문조사결과</h4>
								<!-- 엑셀다운 설명-->
								<div style="display: flex; align-items: center;">
									<div
										style="flex: 1; text-align: right; font-size: 11px; margin-right: 8px; color: gray;">
										<span>표를 오른쪽 클릭 하시면</span> <br> <span>엑셀 다운받기가
											가능합니다.</span>
									</div>
									<div style="line-height: 0;">
										<i class="xi-help xi-x" style="color: gray;"></i>
									</div>
								</div>
							</div>

						</div>
						<!-- 설문조사결과  -->
						<div class="card shadow border-0 rounded-2 mb-5">
							<div class="card-body p-4">
								<div class="mt-2" id="grid1"></div>
							</div>
						</div>

						<div
							class="d-flex align-items-center justify-content-between mb-4 px-3">
							<h4 class="text-success fw-bolder mb-0">총계표</h4>
							<!-- 엑셀다운 설명-->
							<div style="display: flex; align-items: center;">
								<div
									style="flex: 1; text-align: right; font-size: 11px; margin-right: 8px; color: gray;">
									<span>표를 오른쪽 클릭 하시면</span> <br> <span>엑셀 다운받기가
										가능합니다.</span>
								</div>
								<div style="line-height: 0;">
									<i class="xi-help xi-x" style="color: gray;"></i>
								</div>
							</div>
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