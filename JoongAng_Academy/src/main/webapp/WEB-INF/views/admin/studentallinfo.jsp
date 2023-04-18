<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>학적부 조회</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="js/student/studentallinfo.js"></script>
<script src="js/student/studentpost.js"></script>	
	
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
.tui-grid-cell {
  font-size: 14px;
}
</style>	
<script type="text/javascript">
// -- 엔터 처리
$(function(){
	$("#nameNumInput").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#infoSearch").click();
        }
    });
	
	$("#courseInput").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#courseSearch").click();
        }
    });
	
	$("#numName").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#stuInfoShow").click();
        }
    });
	
	$("#dep_Search_text").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#depShow").click();
        }
    });
	
});

//-- 교육과정 / 학번이름 Input 변화시 코드 지우기
$(function(){
	$("#courseInput").change(function(){
		$("#courseNum").empty();
	});
	
	$("#nameNumInput").change(function(){
		$("#nameNumInfo").empty();
	});

});

//-- 저장 버튼 숨기기
$(function(){
	$("#infoSave").hide();
	$("#infoSaveNo").hide();
});
</script>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>


		<!-- 메인 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-4 position-relative row">
						<div style="width:30px;">
						<img src="./image/joongang_logo.png" style="width:25px;">
						</div>
						<div style="width:200px; height:30px;  "> 
							<h5 style="font-weight: bold; color:#565757; line-height:30px;">학적부관리</h5>
						</div>
					</div>
					
					<div class="mt-2 mb-2" style="width:100%; height:1px; background-color:#c1c2c2;"></div>
					
					<!-- 버튼 -->
					<div class="mb-2 position-relative" style="height: 32px;">
						<button type="button" class="btn btn-sm btn-secondary float-end" id="infoUpdate">수정</button>
						<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="infoSaveNo">취소</button>
						<button type="button" class="btn btn-sm btn-secondary float-end" id="infoSave">저장</button>
					</div>
					
				<!-- 학생 검색 -->
					<div class="p-1 mb-4 border position-relative container-fluid" style="background-color: #F3FAFE">
						<div class="row">
						<div class="col-4">
						  <div class="row">
							<span class="col-3 text-center ta font-set">학번(이름)</span>
								<div class="col-9 div-padding">
									<div class="input-group input-group-sm">
										<span class="input-group-text department-code col-3" id="nameNumInfo" name="nameNumInfo" style="color:gray;"></span>
										<input type="text" class="form-control form-control-sm col-8" id="nameNumInput" name="nameNumInput"
											aria-describedby="basic-addon3">
										<button class="btn btn-secondary btn-sm col-1" id="infoSearch" type="button"><i class="fas fa-search"></i></button>
									</div>
								</div>
							  </div>	
							</div>	
						</div>
					</div>




					<!-- 학생 기본 정보 -->
						<div class="p-1 mt-2 mb-4 border container-fluid" style="background-color: #F3FAFE">
						<div class="row">
						<!-- 첫번째 줄 -->
						  <div class="col-4">
						  <div class="row">
								<span class="col-3 text-center ta font-set">학번</span>
								<div class="col-9 div-padding">
									<input class="form-control form-control-sm" id="StudentID" name="StudentID" type="text" aria-label="Disabled input example" disabled>
						  		</div>
						  </div>
						  </div>
						  <!-- 연락처 -->
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">연락처</span>
								<div class="col-8 div-padding">
									<input class="form-control form-control-sm" id="telInfo" name="telInfo" type="text" maxlength="11" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
						 <!-- 비상연락처 -->
						  <div class="col-3">
						  	<div class="row">
						  		<span class="col-4 text-center ta font-set">비상연락처</span>
						  		<div class="col-8 div-padding">
						  			<input type="text" id="emerTel" name="emerTel" class="form-control form-control-sm" maxlength="11" aria-describedby="passwordHelpInline" disabled>
  								</div>
  							</div>
						  	</div>
						  <!-- 관계 -->
						   <div class="col-2">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">관계</span>
								<div class="col-5 div-padding">
									<select class="form-select form-select-sm" id="relation" name="relation" aria-label=".form-select-sm example" disabled>
											<option selected value="">선택</option>
											<c:forEach items="${relationship }" var="r" varStatus="status">
											<option value="${r.CD }">${r.CD_NM }</option>
											</c:forEach>
									</select>
								</div>
							</div>
						 </div>
						  
						  </div> <!-- 첫째줄 끝 -->
						  
						  
						  <!-- 두번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
							  	<div class="row">
							  		<span class="col-3 text-center ta font-set">이름</span>
									<div class="col-9 div-padding">
										<input class="form-control form-control-sm" type="text" id="nameInfo" name="nameInfo" aria-label="Disabled input example" disabled>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">이메일</span>
								<div class="col-8 div-padding">
									<input class="form-control form-control-sm" type="text" id="emailInfo" name="emailInfo" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
					</div>
					
					
					 <!-- 세번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
							  	<div class="row">
							  		<span class="col-3 text-center ta font-set">생년월일</span>
									<div class="col-9 div-padding">
										<input class="form-control form-control-sm" type="text" id="birthInfo" name="birthInfo" aria-label="Disabled input example" disabled>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">우편번호</span>
								<div class="col-8 div-padding">
								  <div class="input-group input-group-sm">
									<input class="form-control form-control-sm col-10" type="text" id="postNum" name="postNum" aria-label=".form-control-sm example" disabled readonly="readonly">
									<button class="btn btn-secondary btn-sm col-2" id="postSearch" type="button" onclick="stuent_post()" disabled><i class="fas fa-search"></i></button>
								  </div>
								</div>
							</div>
						 </div>
					</div>
					
				<!-- 네번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
							  	<div class="row">
							  		<span class="col-3 text-center ta font-set">성별</span>
									<div class="col-9 div-padding">
										<input class="form-control form-control-sm" type="text" id="genderInfo" name="genderInfo" aria-label="Disabled input example" disabled>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-4">
						  	<div class="row">
								<span class="col-3 text-center ta font-set">주소</span>
								<div class="col-9 div-padding">
									<input class="form-control form-control-sm" type="text" id="addrInfo" name="addrInfo" aria-label=".form-control-sm example" disabled readonly="readonly">
								</div>
							</div>
						 </div>
					</div>	
					
				<!-- 다섯번째 줄 -->
						  <div class="row">
						  	<div class="col-4">
							  	<div class="row">
							  		<span class="col-3 text-center ta font-set">나이</span>
									<div class="col-9 div-padding">
										<input class="form-control form-control-sm" type="text" id="ageInfo" name="ageInfo" aria-label="Disabled input example" disabled>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-4">
						  	<div class="row">
								<span class="col-3 text-center ta font-set">상세주소</span>
								<div class="col-9 div-padding">
									<input class="form-control form-control-sm" type="text" id="addrDetail" name="addrDetail" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
					</div>
		</div>
					
				<!--  학과 정보 -->
					<div class="p-1 mb-4 border position-relative container-fluid" style="background-color: #F3FAFE">
						<div class="row">
						  	<div class="col-6">
							  	<div class="row">
							  		<span class="col-2 text-center ta font-set">교육과정</span>
									<div class="col-9 div-padding">
										<input class="form-control form-control-sm" type="text" id="curriculumName" name="curriculumName" aria-label="Disabled input example" disabled>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">학적상태</span>
								<div class="col-6 div-padding">
									<input class="form-control form-control-sm" type="text" id="statusInfo" name="statusInfo" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
						 <div class="col-2">
						  	<div class="row">
								<span class="col-4 text-center ta font-set">교육분기</span>
								<div class="col-8 div-padding">
									<input class="form-control form-control-sm" type="text" id="quarter" name="quarter" aria-label=".form-control-sm example" disabled>
								</div>
							</div>
						 </div>
					</div>
					</div>	
					
					<!-- 학생 검색모달  -->
					<div class="modal fade" id="StuInfoModal" tabindex="-1"
						role="dialog" data-bs-backdrop="static"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">
										<b>학생검색</b>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="mb-4 w-100" style="height: 18px;">
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="stuInfoClose" data-bs-dismiss="modal" aria-label="Close">닫기</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="stuInfoChoose"  disabled="disabled">선택</button>
										<button type="button" class="btn btn-sm btn-secondary float-end" style="margin-left: 5px;" id="stuInfoShow">조회</button>
									</div>
									
									<div class="p-2 mb-4 border container-fluid" style="background-color: #F3FAFE">
									 <div class="row">
									   <div class="col-8">
							  				<div class="row">
											<span class="col-2 text-center ta font-set">교육과정</span>
										 	 <div class="col-10" style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
													<div class="input-group input-group-sm">
														<span class="input-group-text department-code col-3" id="courseNum" name="courseNum" style="color: gray;"></span>
														<input type="text" class="form-control form-control-sm col-8" id="courseInput" name="courseInput"
														aria-describedby="basic-addon3">
														<button class="btn btn-secondary btn-sm col-1" id="courseSearch" type="button">
															<i class="fas fa-search"></i>
														</button>
													</div>
											 </div>	
											</div>
										</div>
										<div class="col-4">
										  <div class="row">
											<span class="col-4 text-center ta font-set">학적상태</span>
											<div class="col-8" style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
												<select class="form-select form-select-sm" id="statusA" name="statusA" aria-label=".form-select-sm example">
													<option selected value="">선택</option>
													<c:forEach items="${studentstatus }" var="s" varStatus="status">
													<option value="${s.CD }">${s.CD_NM }</option>
													</c:forEach>
												</select>
											</div>
										  </div>	
										</div>	
									</div>	
									<div class="row">
										<div class="col-8">
										  <div class="row">
											<span class="col-2 text-center ta font-set">학번(이름)</span>
											<div class="col-10" style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
												<input class="form-control form-control-sm" type="text" id="numName" name="numName" aria-label=".form-control-sm example">
											</div>
										  </div>	
										</div>
									</div>
									
									</div>
									<div class="head">
										<div class="float-start" style="width: 10px; height: 27px; background-color: #498c5f;"></div>
										<div class="fw-border" style="font-size: 17px; margin-left: 15px; padding-top: 2px;">학생 정보</div>
									</div>
									

									<div class="table-responsive" style="margin-top: 5px;">
										<div id="stuSearchGrid"></div>
									</div>





								</div>
								<!-- <div class="modal-footer"></div> -->
							</div>
						</div>
					</div>
					
					<!-- 교육과정 검색모달  -->
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
	
	<!-- 우편번호 조회 API -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</body>
</html>