<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>중앙정보처리학원</title>
<link href="css/styles.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<style>
.form1 {
	height: 40px;
}
</style>
<script>
	$(function() {
		//화면로드시엔 숨기기
		$("#hide2").hide();

		//공백제거
		$("input").on("input", function() {
			var inputVal = $(this).val().trim();
			$(this).val(inputVal);
		});

		//인증번호발송 버튼
		$("#tmpBtn").click(function() {
			var uname = $("#userName").val();
			var phNo = $("#phNo").val();
			var hiddenId = $("#hiddenId").val();

			$.post({
				url : "/sendSms",
				cache : false,
				data : {
					"uname" : uname,
					"phNo" : phNo,
					"hiddenId" : hiddenId,

				},
				dataType : "json"
			}).done(function(data) {
				if (data.result == 0) {
					alert("성함과 전화번호가 일치하지않습니다.")

				} else if (data.result == '202') {
					//일치데이터 인증번호칸에 하이라이트 주기

					alert("인증번호가 전송되었습니다.");

					$("#tmpNo").prop("disabled", false);
					$("#tmpNo").focus();

				}

			}).fail(function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			});

		});//인증번호

		//인증번호 6자리 이상이면 버튼 활성화
		$("#tmpNo").change(function() {
			var tmpVal = $("#tmpNo").val();
			var tmpLeg = tmpVal.length;
			if (tmpLeg == 6) {
				$("#next").prop("disabled", false);
			} else {
				$("#next").prop("disabled", true);
			}
		});

		//다음 버튼
		$("#next").click(function() {
			var tmpNo = $("#tmpNo").val();
			var ckid = $("#ckid").val();

			$.post({
				url : "/ckTemp",
				cache : false,
				data : {
					"tmpNo" : tmpNo,
					"ckid" : ckid,
				},
				dataType : "json"
			}).done(function(data) {
				if (data.result != 1) {
					alert("인증번호가 올바르지않습니다. 다시 입력해주세요.");
					$("#tmpNo").val("");
					$("#tmpNo").focus();

				} else if (data.result == 1) {
					alert("인증이 완료되었습니다.");
					$("#hide1").hide();
					$("#hide2").show();

				}

			}).fail(function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");

			});

		});//다음버튼

		//변경 버튼
		$("#changepw").click(function() {
			var newPW = $("#newPW").val();
			var ckPW = $("#ckPW").val();

			if (newPW != ckPW) {
				alert("입력하신 비밀번호가 일치하지 않습니다.");
				$("#newPW").val("");
				$("#ckPW").val("");
				$("#newPW").focus();

				return false;
			} else if (newPW == "" || ckPW == "") {
				alert("비밀번호를 입력해주세요.");
				$("#newPW").focus();
				return false;
			}
		});

	});//func
</script>
</head>
<body class="bg-light">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5 mt-5">
							<div class="text-center my-4 mt-5"
								style="font-family: 'Noto Sans KR', sans-serif; font-weight: 700; font-size: 48px;">중앙정보처리학원</div>
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-body" style="height: 400px;">
									<div id="hide1">
										<div class="form-floating mb-3 mt-3">
											<h4>휴대전화번호 인증</h4>
										</div>
										<div class="form-floating mb-4 mt-3 ">
											<h6>회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수
												있습니다.</h6>
										</div>
										<div class="form-floating mb-2 ">
											<input class="form-control " id="userName" name="userName"
												type="text" placeholder="이름" /> <label for="inputPassword">이름</label>
										</div>
										<div class="form-floating mb-2 row g-2 ">
											<input type="hidden" id=hiddenId name=hiddenId value=${ckid }>
											<input class="form-control" id="phNo" name="phNo" type="text"
												placeholder="휴대전화번호" style="width: 330px; margin-left: 4px;" />
											<label for="inputPassword">휴대전화번호</label>
											<button class="btn btn-success btn-sm mt-3 " id="tmpBtn"
												type="submit"
												style="width: 150px; height: 38px; margin-left: 12px;">인증번호
												발송</button>
										</div>
										<!-- <form action="/ckTemp" method="post"> -->
										<input type="hidden" value=${ckid } name="ckid" id="ckid" />
										<div class="form-floating mb-3 ">
											<input class="form-control " id="tmpNo" name="tmpNo"
												type="text" placeholder="인증번호" disabled="disabled" /> <label
												for="inputPassword">인증번호 6자리 숫자입력</label>
										</div>
										<div class=" mb-0 ">
											<button class="btn btn-success col-12" type="submit"
												id="next" disabled="disabled">다음</button>
										</div>
									</div>
									<!--비밀번호 변경  -->
									<div id="hide2">
										<form action="/updatePW" method="post">
											<div class="form-floating mb-3 mt-3">
												<h4>비밀번호 변경</h4>
											</div>
											<div class="form-floating mb-4 mt-3 ">
												<h6>
													변경할 아이디 : <b>${ckid }</b>
												</h6>
											</div>
											<div class="form-floating mb-3 ">
												<input class="form-control " id="newPW" name="newPW"
													type="password" placeholder="새로운 비밀번호" /> <label
													for="newPW">새로운 비밀번호</label>
											</div>
											<div class="form-floating mb-4 ">
												<input class="form-control " id="ckPW" name="ckPW"
													type="password" placeholder="비밀번호 확인" /> <label for="ckPW">비밀번호
													확인</label>
											</div>
											<!-- <form action="/ckTemp" method="post"> -->
											<input type="hidden" id=hiddenId name=hiddenId value=${ckid }>
											<div class=" mb-0 ">
												<button class="btn btn-success col-12" type="submit"
													id="changepw">변경</button>
											</div>
										</form>
									</div>
									<!--hide2  -->
									<c:choose>
										<c:when test="${result eq 1 }">
											<script>
												alert("비밀번호가 변경되었습니다.");
												location.href = "/login";
											</script>
										</c:when>
										<c:otherwise>
											<script>
												alert("오류가 발생했습니다. \n 다시 시도해주세요");
												return false;
											</script>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<div id="layoutAuthentication_footer">
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
</body>
</html>