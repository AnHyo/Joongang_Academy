<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 검색모달  -->
<div class="modal fade" id="pwChangeModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">
					<b>비밀번호 수정</b>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="d-flex justify-content-center mb-2">
					<table class="table table-borderless m-0 ">
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">이름</td>
							<td style="line-height: 40px;" id="userNM">${sessionScope.username}</td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">아이디</td>
							<td style="line-height: 40px;" id="userID">${sessionScope.id}</td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">현재
								비밀번호</td>
							<td><input type="password" class="form-control" id="nowPw"></td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">새
								비밀번호</td>
							<td><input type="password" class="form-control" id="newPw"></td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">새
								비밀번호 확인</td>
							<td><input type="password" class="form-control"
								id="newPwCheck"></td>
						</tr>


					</table>

				</div>
				
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-success btn-sm" id="changebtn">변경</button>
			</div>
		</div>
	</div>
</div>
</html>