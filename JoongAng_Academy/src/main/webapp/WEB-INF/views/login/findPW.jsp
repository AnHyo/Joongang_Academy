<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
								<div class="card-body" style="height:300px;">
									<form action="/ckid" method="post">
										<div class="form-floating mb-3 mt-3">
											<h4>아이디확인</h4>
										</div>
										<div class="form-floating mb-4 mt-3">
											<h6>비밀번호를 찾고자하는 아이디를 입력해주세요.</h6>
										</div>
										<div class="form-floating mb-5 ">
											<input class="form-control" id="ckid" name="ckid"
												type="text" placeholder="아이디" /> <label
												for="inputPassword">아이디</label>
										</div>
										
										<div class=" mb-0">
											<button class="btn btn-success col-12" type="submit"
												id="idCKBtn">다음</button>
										</div>
									</form>
									<c:if test="${param.error eq 1223}">
										<script>
											alert("입력하신 아이디를 찾을 수 없습니다.");
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