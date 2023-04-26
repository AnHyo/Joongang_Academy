<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 검색모달  -->
<div class="modal fade" id="sbjPlanModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">
					<b>강의계획서 조회</b>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
			</div>
			<div class="modal-body p-4">
				<table class="table table-bordered table-sm mt-2 " style="border">
					<tr>
						
						<td class="col-2 table-secondary text-center">과목명</td>
						<td class="col-2" colspan="2" id="sbjnm"></td>
						<td class="col-2 table-secondary text-center" >과목번호</td>
						<td class="col-2" colspan="2" id="sbjno"></td>
					
					</tr>
					<tr>
						<td class="col-2 table-secondary text-center">교육연도</td>
						<td class="col-2 crclmYear" id="crclmYear"></td>
						<td class="col-2 table-secondary text-center">교육반기</td>
						<td class="col-2 crclmHalf"  id="crclmHalf"></td>
						<td class="col-2 table-secondary text-center">강사명</td>
						<td class="col-2" id="instrNm"></td>
					</tr>
					<tr>
						<td class="col-2 table-secondary text-center">훈련과정</td>
						<td colspan="5" id="crclmNm"></td>
					</tr>
					<tr>
						<td class="col-2 table-secondary text-center">사용교재</td>
						<td colspan="5" id="sbjBook"></td>
					</tr>
				</table>
				<table class="table table-sm table-bordered mt-2 ">
					<tr>
						<td class="col-2 table-secondary text-center" style="line-height: 80px;"  >강의목표</td>
						<td class="col-10" id="sbjtrgt">
							<br>
							 <br>
						</td>
					</tr>
				</table>
				<table class="table table-sm table-bordered  mt-2 ">
					<tr>
						<td class="col-2 table-secondary text-center" style="line-height: 80px;"  >강의 방법</td>
						<td class="col-10" id="sbjMthd" >
							<br>
							 <br>
						</td>
					</tr>
				</table>
				<table class="table table-sm table-bordered mt-2 ">
					<tr>
						<td class="col-2 table-secondary text-center" style="line-height: 180px;"  >강의 내용</td>
						<td class="col-10" id="sbjCN">
							
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</html>