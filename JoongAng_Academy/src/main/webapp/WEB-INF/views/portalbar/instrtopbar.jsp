<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Navigation-->
		<nav class="navbar navbar-expand-lg navbar-light bg-white py-3">
			<div class="container px-5">
				<a class="navbar-brand" href="/instrIndex"><span
					class="fw-bolder text-success">중앙정보처리학원</span></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0 small fw-bolder">
						<li class="nav-item"><a class="nav-link" href="/atndInstr">출결관리</a></li>
						<li class="nav-item"><a class="nav-link" href="/surveyResult">설문조사</a></li>
							<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">강의관리</a>
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="/instrSearchStu">학생정보조회</a></li>
								<li><a class="dropdown-item" href="/instrSbjPlan">강의계획서관리</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="/instrTime">시간표</a></li>
					</ul>
					
					<c:if test="${not empty sessionScope.username}">
					<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false"> 
							<i class="fas fa-user fa-fw"></i>
							${sessionScope.username}님</a>
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="/instrinfoMod">개인정보수정</a></li>
								<li><a class="dropdown-item" href="/instrpwCheckMod">비밀번호 수정</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><a class="dropdown-item logout" href="/logout">로그아웃</a></li>
							</ul></li>
					</ul>
					</c:if>
				</div>
			</div>
		</nav>