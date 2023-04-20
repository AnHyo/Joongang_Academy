<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 검색모달  -->
					<div class="modal fade" id="instrModal" tabindex="-1"
						role="dialog" data-bs-backdrop="static"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">
										<b>대표강사검색</b>
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
										<span class="col-2 text-center ta font-set mt-2">강사명</span>
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
										<div class="fw-border" style="font-size: 17px; margin-left: 15px; padding-top: 2px;">강사 정보</div>
									</div>
									

									<div class="table-responsive" style="margin-top: 5px;">
										<div id="searchGrid"></div>
									</div>