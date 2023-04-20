<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 검색모달  -->
<div class="modal fade" id="stuSearchModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">
					<b>학생 검색</b>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="d-flex justify-content-end pb-1 mb-1">
					<div>
						<button type="button" class="btn btn-secondary btn-sm"
							id="searchbtn2">조회</button>
						<button type="button" class="btn btn-secondary btn-sm"
							id="selectbtn">선택</button>
					</div>
				</div>
				<div class="d-flex justify-content-center mb-2">
					<div class="row"
						style="width: 100%; height: 140px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">
						<div class="col-3 mt-4 d-flex justify-content-center fw-bolder"
							style="font-size: 14px; line-height: 15px;">학번(이름)</div>
						<div class="col-9 mr-1 mt-3">
							<input type="text" class="form-control form-control-sm"
								id="searchNM2">
						</div>

						<div class="col-3 d-flex justify-content-center fw-bolder"
							style="font-size: 14px; line-height: 15px;">과정구분</div>
						<div class="col-9 ">
							<div class="input-group" style="margin-top: -5px;">

								<input type="text" class="form-control form-control-sm"
									style="border-radius: 5px 0 0 5px;" value="2023" id="crclm_year"> <select
									class="form-select form-select-sm" name="crclm_half" id="crclm_half"
									style="border-radius: 0 5px 5px 0;>
									<option value="">상/하반기</option>
									<option value="0010">상반기</option>
									<option value="0020">하반기</option>
								</select>
							</div>
						</div>
						<div class="col-3"></div>
						<div class="col-9">
							<div class="col-12" style="margin-top: -5px;">
									<select class="form-select form-select-sm crclmNameList" id="crclm_cd_name">
									</select>
							</div>
						</div>
					


					</div>
				</div>
				<div class="float-start mb-2"
					style="width: 10px; height: 29px; background-color: #498c5f; margin-right: 10px;"></div>
				<h6 class="mt-2 pt-1 fw-bolder">학생 정보</h6>
				
				<div id="stuList" class="mb-3 mt-3"></div>
			</div>
		</div>
	</div>
</div>
</html>