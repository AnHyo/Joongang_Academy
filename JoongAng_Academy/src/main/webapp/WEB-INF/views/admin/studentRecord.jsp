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
<title>학적부 관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<style type="text/css">
span{
display: block;
}
.ta{
 line-height: 38px;
}

.font-set{
	font-size: 14px;
}
.div-padding{
	padding: 3.5px;
}
.head{
	margin: 0 auto;
	padding: 0;
	width: auto;
	height: auto;
}
</style>
<script type="text/javascript">
// 년도 글자수 제한
function maxLengthCheck(object){
    if (object.value.length > 4){
        object.value = object.value.slice(0, 4);
    }    
}

</script>
<script src="js/student/student_list.js"></script>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>


		<!-- 메인 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h5 class="mt-3">학생명단조회</h5>
					<hr style="height: 2px;">
					<div class="mb-3" style="height: 26px;">
						<button type="button" class="btn btn-sm btn-secondary float-end stuSearch">조회</button>
					</div>
						<!-- 명단 검색 그룹 -->
						<div class="p-4 mt-2 mb-5 border container-fluid" style="background-color: #F3FAFE">
						<div class="row mb-3">
						<!-- 소속학과 -->
						  <div class="col-6">
						  <div class="row">
								<span class="col-2 text-center ta font-set">소속학과</span>
								<div class="col-10 div-padding">
								<div class="input-group input-group-sm">
									<span class="input-group-text" id="inputGroup-sizing-sm" style="color:gray;">0011</span>
									<input type="text" class="form-control form-control-sm" id="department" name="department"
										aria-describedby="basic-addon3">
									<button class="btn btn-secondary btn-sm" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
								</div>
								</div>
						  </div>
						  </div>
						  <!-- 학적상태 -->
						  <div class="col-2">
						  	<div class="row">
								<span class="col-5 text-center ta font-set">학적상태</span>
								<div class="col-7 div-padding">
								<select class="form-select form-select-sm" name="status" aria-label=".form-select-sm example">
										<option selected>선택</option>
										<option value="0010">훈련신청</option>
										<option value="0020">훈련중</option>
										<option value="0030">수료</option>
										<option value="0040">중도탈락</option>
								</select>
								</div>
							</div>
						 </div>
						 <!-- 년도 -->
						  <div class="col-2">
						  	<div class="row">
						  		<span class="col-4 text-center ta font-set">년도</span>
						  		<div class="col-8 div-padding">
						  		<input type="number" id="year" name="year" class="form-control form-control-sm" aria-describedby="passwordHelpInline" oninput="maxLengthCheck(this)">
  								</div>
  							</div>
						  	</div>
						  <!-- 교육회차 -->
						   <div class="col-2">
						  	<div class="row">
								<span class="col-5 text-center ta font-set">교육회차</span>
								<div class="col-7 div-padding">
								<select class="form-select form-select-sm" name="turn" aria-label=".form-select-sm example">
										<option selected>선택</option>
										<option value="0010">상반기</option>
										<option value="0020">하반기</option>
								</select>
								</div>
							</div>
						 </div>
						  
						  </div>
						  <div class="row">
						  <!-- 학번(이름) -->
						  	<div class="col-6">
							  	<div class="row">
							  		<span class="col-2 text-center ta font-set">학번(이름)</span>
							  		<div class="col-10 div-padding">
							  		<input type="text" id="nameAndNum" name="nameAndNum" class="form-control form-control-sm" aria-describedby="passwordHelpInline">
	  								</div>
	  							</div>
						  	</div>
						  <!-- 성별구분 -->
						  <div class="col-2">
						  	<div class="row">
						  	<span class="col-5 text-center ta font-set">성별구분</span>
								<div class="col-7 div-padding">
								<select class="form-select form-select-sm" name="gender" aria-label=".form-select-sm example">
										<option selected>선택</option>
										<option value="0010">남자</option>
										<option value="0020">여자</option>
								</select>
						  	</div>
						  </div>
						 </div>	
					</div>
					</div>
					
					<!-- 학생 정보 -->
					<div class="head">
						<div class="float-start" style="width:10px; height:27px; background-color:#498c5f;"></div>
						<div class="fw-border" style="font-size: 17px; margin-left: 15px;">학생정보</div>
					</div>
					<hr style="height: 2px;">
					<div id="grid"></div>
					
					
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