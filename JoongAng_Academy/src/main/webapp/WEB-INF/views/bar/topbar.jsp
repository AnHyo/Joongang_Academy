<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="js/pwChange.js"></script>
<script src="js/admininfoMod.js"></script>
<script>
$(function(){
	
	$("#logout").click(function(){
		location.href="/logout";
	});
});

</script>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-team2">
	<!-- Navbar Brand-->
	<a class="navbar-brand ps-3"
		style="font-family: 'Noto Sans KR', sans-serif; font-weight: 500; font-size: 24px;"
		href="/index">중앙정보처리학원</a>
	<!-- Sidebar Toggle-->
	<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
		id="sidebarToggle" href="#!">
		<i class="fas fa-bars"></i>
	</button>
	<!-- Navbar Search-->
	<div
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
	
					<c:if test="${not empty sessionScope.username}">
					<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false"> 
							<i class="fas fa-user fa-fw"></i>
							${sessionScope.username}님</a>
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" id="infoModal">개인정보수정</a></li>
								<li><a class="dropdown-item" id="pwModal">비밀번호 수정</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><a class="dropdown-item logout" id="logout">로그아웃</a></li>
							</ul></li>
					</ul>
					</c:if>
	</div>
</nav>

	<%@include file="../admin/pwChangeModal.jsp"%>
	<%@include file="../admin/infoModModal.jsp"%>