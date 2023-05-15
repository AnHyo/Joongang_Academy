<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0030")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
}
%> --%>
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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="js/survey/survey.js"></script>
<style type="text/css">
ml-10 {
	margin-left: 10px;
}
</style>
</head>
<body class="sb-nav-fixed">
	<%-- 	<%@include file="../bar/topbar.jsp"%> --%>
	<!-- 	<div id="layoutSidenav"> -->
	<%-- 		<%@include file="../bar/sidebar.jsp"%> --%>

	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<div class="mt-3">
					<h5 class="fw-bolder">설문조사관리</h5>
				</div>
				<hr style="height: 4px;" class="m-0 mb-1">
				<div class="d-flex justify-content-end pb-1 mb-2 mt-2">
					<div>
						<button type="button" class="btn btn-secondary btn-sm"
							id="search_btn">조회</button>
						<!-- 							<button type="button" class="btn btn-secondary btn-sm" id="add_btn">신규</button> -->
						<!-- 							<button type="button" class="btn btn-secondary btn-sm" id="del_btn">삭제</button> -->
						<!-- <button type="button" class="btn btn-secondary btn-sm" id="save_btn" disabled="disabled">저장</button> -->
					</div>
				</div>
				<div
					style="width: 100%; background-color: #F3FAFE; height: 60px; border: 1px solid #c0c0c0; position: relative;">
					<div
						style="position: absolute; width: 100%; top: 50%; transform: translateY(-50%) translateX(10%);">
						<div class="input-group " style="width: calc(20%); float: left;">
							학년도 <input type="number" class="form-control form-control-sm"
								style="margin-left: 10px;" value="2023" maxlength="4"
								id="s_CRCLM_YEAR" numberOnly> <select
								class="form-select form-select-sm s_CRCLM_HALF"
								name="s_CRCLM_HALF">
								<option value="">상/하반기</option>
								<option value="0010">상반기</option>
								<option value="0020">하반기</option>
							</select>
						</div>
						<!-- 검색 -->
						<div class="input-group "
							style="width: calc(15%); margin-left: 10px; float: left;">
							<input class="form-control form-control-sm s_SBJCT_NM"
								type="text" placeholder="과목명" aria-describedby="btnNavbarSearch"
								style="margin-left: 10px;" />
						</div>

						<div class="input-group "
							style="width: calc(40%); margin-left: 10px; float: left;">
							훈련과정명 <select class="form-select form-select-sm s_CRCLM_CD_NM"
								name="s_CRCLM_CD_NM" style="margin-left: 10px;">
								<option value="">선택</option>
								<c:forEach items="${crclmName}" var="cn">
									<option value="${cn.CD }">${cn.CD_NM}</option>
								</c:forEach>
							</select>
							<script>
							  $(document).ready(function() {
							    $('select[name=s_CRCLM_CD_NM]').change(function() {
							      var s_CRCLM_CD_NM = $(this).val();
							      console.log(s_CRCLM_CD_NM); // 선택한 값 출력 또는 원하는 동작 수행
							    });
							  });
							</script>

							
						</div>
					</div>
				</div>
				<!-- 상단 끝 -->

				<!-- 설문정보 -->
				<h6 class="mt-3 fw-bolder">설문정보</h6>
				<div class="grid">
					<div id="grid"></div>
				</div>

				<!-- tab -->
				<div class="mt-3">
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<button class="nav-link active" id="tab1_btn"
								data-bs-toggle="tab" data-bs-target="#tab1" type="button"
								role="tab" aria-controls="nav-home" aria-selected="true">기본정보</button>
							<button class="nav-link" id="tab2_btn" data-bs-toggle="tab"
								data-bs-target="#tab2" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false">문항정보</button>
							<button class="nav-link" id="tab3_btn" data-bs-toggle="tab"
								data-bs-target="#tab3" type="button" role="tab"
								aria-controls="nav-contact" aria-selected="false">참석자정보</button>
						</div>
					</nav>

					<div class="mb-5 inputTotal">
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade show active" id="tab1" role="tabpanel"
								aria-labelledby="nav-home-tab"
								style="width: 100%; background-color: #F3FAFE; height: 420px; position: relative;">
								<!--기본정보 -->
								<div
									style="width: 100%; background-color: #F3FAFE; height: 420px; border: 1px solid #e9ecef;">
									<table
										style="width: 90%; position: absolute; top: 50%; transform: translateY(-50%) translateX(5%);">
										<tr style="height: 50px">
											<td class="col-1" style="text-align: right;">과목명</td>
											<td class="col-2"><input type="text"
												class="form-control form-control-sm SBJCT_NM"
												disabled="disabled"></td>


											<td class="col-1" style="text-align: right;">훈련과정명</td>
											<td class="col-4" colspan='3'><select
												class="form-select form-select-sm crclmNameList"
												disabled="disabled">
													<option value="">선택</option>
													<c:forEach items="${crclmName}" var="cn">
														<option value="${cn.CD }">${cn.CD_NM}</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr style="height: 50px">
											<td class="col-1" style="text-align: right;">학년도</td>
											<td class="col-2">
												<div class="input-group">
													<input type="text"
														class="form-control form-control-sm CRCLM_YEAR"
														disabled="disabled"> <select
														class="form-select form-select-sm CRCLM_HALF"
														disabled="disabled">
														<option value="">선택</option>
														<option value="0010">상반기</option>
														<option value="0020">하반기</option>
													</select>
												</div>
											</td>


											<!-- 												<td style="text-align: right;">등록일자</td> -->
											<!-- 												<td><input type="date" min="year+'-01-01'" -->
											<!-- 													class="form-control form-control-sm DGSTFN_RGDATE" -->
											<!-- 													disabled="disabled"></td> -->
											<td style="text-align: right;">설문시작일시</td>
											<td><input type="text"
												class="form-control form-control-sm SCHDL_BGNG_DT"
												disabled="disabled"></td>
											<td style="text-align: right;">설문종료일시</td>
											<td><input type="text"
												class="form-control form-control-sm SCHDL_END_DT"
												disabled="disabled"></td>

										</tr>
										<tr style="height: 50px">
											<td style="text-align: right;">설문명</td>
											<td><input type="text"
												class="form-control form-control-sm DGSTFN_TITLE"
												disabled="disabled"></td>

											<td style="text-align: right;">설문개설여부</td>
											<td><select
												class="form-select form-select-sm DGSTFN_OP_YN"
												disabled="disabled">
													<option value="">선택</option>
													<option value="N">N</option>
													<option value="Y">Y</option>
											</select></td>
											<!-- 												<td style="text-align: right;">설문시작일시</td>
												<td><input type="date"
													class="form-control form-control-sm SCHDL_BGNG_DT"
													disabled="disabled"></td>
												<td style="text-align: right;">설문종료일시</td>
												<td><input type="date"
													class="form-control form-control-sm SCHDL_END_DT"
													disabled="disabled"></td> -->
										</tr>
										<tr>
											<td style="text-align: right;">안내문구</td>
										</tr>
										<tr>
											<td></td>
											<td colspan="7"><textarea
													class="form-control DGSTFN_INTRO"
													style="height: 200px; resize: none;" disabled="disabled"></textarea></td>
										</tr>
									</table>
								</div>
							</div>
							<!-- 기본정보 버튼 -->
							<div style="right: 25px; position: absolute;" id="btn"
								class="mt-2">
								<button type="button" class="btn btn-secondary btn-sm"
									id="save_btn" disabled="disabled">저장</button>
							</div>

							<!-- 문항정보 -->
							<div class="tab-pane fade" id="tab2" role="tabpanel"
								aria-labelledby="nav-profile-tab">
								<div>
									<div id="grid2"></div>
								</div>
								<!-- 문한정보 버튼 -->
								<div style="width: 240px; float: right;">
									<div id="help"
										style="display: none; text-align: right; font-size: 11px; margin-right: 3px; color: gray; float: left; margin-top: 8px;">
										<span>문항은 최대 23개까지</span> <br> <span>생성가능합니다.</span>
									</div>
									<div style="display: none; position: relative; float: right;"
										id="btn2" class="mt-2">
										<i class="xi-help-o xi-x" title="최대 23개까지 생성 가능합니다."
											style="color: #adb5bd; margin-top: 8px; margin-right: 7px;"
											id="help-o"></i>
										<button type="button" class="btn btn-secondary btn-sm"
											title="최대 23개까지 생성 가능합니다." id="add_btn2" disabled="disabled">신규</button>
										<button type="button" class="btn btn-secondary btn-sm"
											id="del_btn2" disabled="disabled">삭제</button>
										<button type="button" class="btn btn-secondary btn-sm"
											id="save_btn2" disabled="disabled">저장</button>
									</div>
								</div>

								<div class="mt-3 mb-1">
									<h6 class="mt-2 fw-bolder" style="display: inline-block;">답변정보</h6>
								</div>
								<div>
									<div id="grid2_2"></div>
								</div>
								<!-- 답변정보 버튼 -->
								<!-- 									<div style="width: 300px;"> -->
								<!-- 										<div style="float: right;" class="mt-2" id="btn2_2"> -->
								<!-- 											<button type="button" class="btn btn-secondary btn-sm" -->
								<!-- 												id="add_btn2_2" disabled="disabled">신규</button> -->
								<!-- 											<button type="button" class="btn btn-secondary btn-sm" -->
								<!-- 												id="del_btn2_2" disabled="disabled">삭제</button> -->
								<!-- 											<button type="button" class="btn btn-secondary btn-sm" -->
								<!-- 												id="save_btn2_2" disabled="disabled">저장</button> -->
								<!-- 										</div> -->
								<!-- 									</div> -->
							</div>

							<!-- 참석자정보 -->
							<div class="tab-pane fade" id="tab3" role="tabpanel"
								aria-labelledby="nav-contact-tab">
								<div>
									<div id="grid3"></div>
								</div>
							</div>

						</div>
					</div>

				</div>
			</div>
		</main>
		<%@include file="../bar/footer.jsp"%>
	</div>
	<!-- 	</div> -->
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