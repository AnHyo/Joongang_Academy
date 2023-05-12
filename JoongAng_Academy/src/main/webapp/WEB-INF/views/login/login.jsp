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

<script>
	$(function() {

		//공백제거
		$("input").on("input", function() {
			var inputVal = $(this).val().trim();
			$(this).val(inputVal);
		});

		let userID = getCookie("userID");
		let setCookieYN = getCookie("setCookie");

		// 사용자가 Y를 눌렀다면, 화면에 ID출력하기
		if (setCookieYN == 'Y') {
			$("#rememberId").prop("checked", true);
			$("#userid").val(userID);
		}

		$("#loginBtn").click(function() {
			let id = $("#userid").val();
			let pw = $("#userpw").val();
			//alert("@");
			if ($("#userid").val() == "") {
				alert("아이디를 입력하세요.");
				$("#userid").focus();
				return false;
			} else if ($("#userpw").val() == "") {
				alert("비밀번호를 입력하세요.");
				$("#userpw").focus();
				return false;
			}

			if ($(".rememberId").is(":checked")) {
				//alert("!!");
				setCookie("userID", id, 7); // 메소드 부르기
				setCookie("setCookie", 'Y', 7);
			} else {
				//저장된 쿠키 삭제
				deleteCookie("userID");
				deleteCookie("setCookie");

			}

		});

	});//func

	//쿠기 저장
	function setCookie(cookieName, value, exdays) {

		let date = new Date();
		date.setDate(date.getDate() + exdays);

		let cookieValue = escape(value)
				+ (exdays == null ? "" : "; expires=" + date.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;

	}

	function getCookie(cookieName) {

		let val = document.cookie.split(";");
		for (let i = 0; i < val.length; i++) {
			let name = val[i].substr(0, val[i].indexOf("="));
			let value = val[i].substr(val[i].indexOf("=") + 1);
			name = name.replace(/^\s+|\s+$/g, '');
			if (cookieName == name) {
				return value;
			}
		}
	}
	// 쿠키삭제 : 쿠키유지시간을 과거로 바꾸면 됨.
	function deleteCookie(cookieName) {
		var date = new Date();
		date.setDate(date.getDate() - 1);
		document.cookie = cookieName + "=" + "; expires=" + date.toGMTString();
	}
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
								<div class="card-body" style="height: 300px;">
									<form id="myForm" method="post">
										<div class="form-floating mb-3 mt-3">
											<input class="form-control" id="userid" name="userid"
												type="userid" placeholder="아이디" /> <label for="inputEmail">아이디</label>
										</div>
										<div class="form-floating mb-1">
											<input class="form-control" id="userpw" name="userpw"
												type="password" placeholder="비밀번호" /> <label
												for="inputPassword">비밀번호</label>
										</div>
										<div
											class="d-flex align-items-center justify-content-between mt-2 mb-0">
											<div class="form-check mb-1 mt-2">
												<input class="form-check-input rememberId" id="rememberId"
													type="checkbox" name="rememberId" value="" /> <label
													class="form-check-label" for="rememberId">아이디 저장</label>
											</div>
											<div class="mb-1 mt-2">
												<a class="small" id="btnFindPW" href="/findPW">비밀번호 찾기</a>
											</div>
										</div>
										<div class="mt-4 mb-0">
											<button class="btn btn-success col-12" type="submit"
												id="loginBtn">로그인</button>
										</div>
									</form>
									<c:if test="${param.error eq 1222}">
										<script>
											alert("입력한 아이디 또는 비밀번호가 올바르지 않습니다. \n다시 확인해주세요.");
										</script>
									</c:if>
									<c:if test="${param.error eq 1234}">
										<script>
											alert("접근 권한이 없습니다.");
										</script>
									</c:if>
									<c:if test="${param.error eq 4321}">
										<script>
											alert("로그인 후 접근 가능합니다.");
										</script>
									</c:if>
									<c:if test="${param.group eq 0010}">
										<script>
											$("#loginBtn").click(function(){
												$("#myForm").attr("action", "/loginStu");
											});
										</script>
									</c:if>
									<c:if test="${param.group eq 0020}">
										<script>
											$("#loginBtn").click(function(){
												$("#myForm").attr("action", "/loginInstr");
											});
										</script>
									</c:if>
									<c:if test="${param.group eq 0030}">
										<script>
											$("#loginBtn").click(function(){
												$("#myForm").attr("action", "/loginAdmin");
											});
										</script>
									</c:if>
									
									
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