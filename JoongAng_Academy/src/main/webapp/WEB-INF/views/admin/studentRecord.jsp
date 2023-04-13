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
<title>학생명단조회</title>
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

// -- 년도 글자수 제한
function maxLengthCheck(object){
    if (object.value.length > 4){
        object.value = object.value.slice(0, 4);
    }    
}

// -- 엔터 처리
$(function(){
	$("#dep_Search_text").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#depShow").click();
        }
    });
	
	$("#department").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#depSearch").click();
        }
    });
	
	$("#year").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#stuSearch").click();
        }
    });
	
	$("#nameAndNum").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#stuSearch").click();
        }
    });
	
});

//-- 공백 바로 제거
 function test(obj){
	var a = $('#year').val().replace(/ /gi, '');
	$('#year').val(a);
	
	var b = $('#nameAndNum').val().replace(/ /gi, '');
	$('#nameAndNum').val(b);

}
</script>
<script src="js/student/student_list.js"></script>
<script src="js/student/dep_search_modal.js"></script>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>


		<!-- 메인 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h5 class="mt-3"><img src="../image/joongang_logo.png" style="width: 25px; height: 25px; margin-right: 5px;">학생명단조회</h5>
					<hr style="height: 2px;">
					<div class="mb-3" style="height: 26px;">
						<button type="button" class="btn btn-sm btn-secondary float-end" id="stuSearch">조회</button>
					</div>
						<!-- 명단 검색 그룹 -->
						<div class="p-4 mt-2 mb-5 border container-fluid" style="background-color: #F3FAFE">
						<div class="row mb-3">
						<!-- 교육과정 -->
						  <div class="col-6">
						  <div class="row">
								<span class="col-2 text-center ta font-set">교육과정</span>
								<div class="col-10 div-padding">
								<div class="input-group input-group-sm">
									<span class="input-group-text department-code col-3" id="inputGroup-sizing-sm" style="color:gray;"></span>
									<input type="text" class="form-control form-control-sm col-8" id="department" name="department"
										aria-describedby="basic-addon3">
									<button class="btn btn-secondary btn-sm col-1" id="depSearch" type="button"><i class="fas fa-search"></i></button>
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
										<option selected value="">선택</option>
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
						  		<input type="number" id="year" name="year" class="form-control form-control-sm" aria-describedby="passwordHelpInline" onkeyup="test(this);" oninput="maxLengthCheck(this)">
  								</div>
  							</div>
						  	</div>
						  <!-- 교육회차 -->
						   <div class="col-2">
						  	<div class="row">
								<span class="col-5 text-center ta font-set">교육회차</span>
								<div class="col-7 div-padding">
								<select class="form-select form-select-sm" name="turn" aria-label=".form-select-sm example">
										<option selected value="">선택</option>
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
							  		<input type="text" id="nameAndNum" name="nameAndNum" class="form-control form-control-sm" aria-describedby="passwordHelpInline" onkeyup="test(this);">
	  								</div>
	  							</div>
						  	</div>
						  <!-- 성별구분 -->
						  <div class="col-2">
						  	<div class="row">
						  	<span class="col-5 text-center ta font-set">성별구분</span>
								<div class="col-7 div-padding">
								<select class="form-select form-select-sm" name="gender" aria-label=".form-select-sm example">
										<option selected value="">선택</option>
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




					<!-- 검색모달  -->
					<div class="modal fade" id="SearchModal" tabindex="-1"
						role="dialog" data-bs-backdrop="static"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">
										<b>교육과정검색</b>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="mb-4 w-100" style="height: 18px;">
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="depClose" data-bs-dismiss="modal" aria-label="Close">닫기</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="depChoose"  disabled="disabled">선택</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="depShow">조회</button>
									</div>
									
									<div class="p-1 mb-4 border container-fluid" style="background-color: #F3FAFE">
									 <div class="row">	
										<span class="col-2 text-center ta font-set">교육과정</span>
										  <div class="col-10" style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
											<div class="input-group input-group-sm">
												<input type="text" class="form-control form-control-sm dep_Search_text" placeholder="검색어을 입력하세요"
													name="dep_Search_text" id="dep_Search_text" aria-describedby="basic-addon3">
											</div>
										   </div>	
										</div>	
									
									</div>
									<div class="head">
										<div class="float-start" style="width: 10px; height: 27px; background-color: #498c5f;"></div>
										<div class="fw-border" style="font-size: 17px; margin-left: 15px; padding-top: 2px;">교육과정 정보</div>
									</div>
									

									<div class="table-responsive" style="margin-top: 5px;">
										<div id="searchGrid"></div>
									</div>





								</div>
								<!-- <div class="modal-footer"></div> -->
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