<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 개인정보수정모달  -->
<div class="modal fade" id="infoModModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">
					<b>개인정보 수정</b>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="d-flex justify-content-center mb-2">
					<table class="table table-borderless m-0 ">
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">이름</td>
							<td style="line-height: 40px;" id="userNM2">${sessionScope.username}</td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">아이디</td>
							<td style="line-height: 40px;" id="userID2">${sessionScope.id}</td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-4" style="line-height: 40px;">현재
								비밀번호</td>
							<td><input type="password" class="form-control" id="nowPw2"></td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-3" style="line-height: 40px;">연락처</td>
							<td><input type="text" class="form-control" id="telNo"></td>
						</tr>
						<tr>
							<td class="text-end fw-bolder col-3" style="line-height: 40px;">이메일</td>
							<td><input type="text" class="form-control" id="emailAddr"></td>
						</tr>
					</table>

				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success btn-sm" id="modbtn">수정</button>
			</div>
		</div>
	</div>
</div>
</html>