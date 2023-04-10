<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
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
								<div class="card-body">
									<form>
										<div class="form-floating mb-3">
											<input class="form-control" id="userid" type="userid" 
												placeholder="아이디" /> <label for="inputEmail">아이디</label>
										</div>
										<div class="form-floating mb-1">
											<input class="form-control" id="userpw" type="password" placeholder="비밀번호"
												/> <label for="inputPassword">비밀번호</label>
										</div>
										<div class="d-flex align-items-center justify-content-between mt-2 mb-0">
											<div class="form-check mb-1">
												<input class="form-check-input" id="inputRememberPassword"
													type="checkbox" value="" /> <label
													class="form-check-label" for="inputRememberPassword">아이디
													저장</label>
											</div>
											<div class="mb-1">
												<a class="small" href="password.html">비밀번호 찾기</a>
											</div>
										</div>
										<div class="mt-3 mb-0">
											<a class="btn btn-success col-12" href="index.html">로그인</a>
										</div>
									</form>
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