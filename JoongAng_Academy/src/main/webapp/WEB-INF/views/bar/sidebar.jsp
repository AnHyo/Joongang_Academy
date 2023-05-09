<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="layoutSidenav_nav">
	<nav class="sb-sidenav accordion sb-sidenav-light"
		id="sidenavAccordion">
		<div class="sb-sidenav-menu">
			<div class="nav">
				<div class="sb-sidenav-menu-heading">admin</div>
				
				<div class="collapsed" id="collapseLayouts1" style="margin-left: 8px;">
					<a class="nav-link" href="code">공통코드관리</a>
					<a class="nav-link" href="instrmg">강사관리</a> 
				</div>
				
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts2" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
<!-- 						<i class="fas fa-columns"></i> -->
					</div> 학생관리
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>
				<div class="collapse" id="collapseLayouts2"
					aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
						<a class="nav-link" href="stdntNo">학번부여관리</a> 
						<a class="nav-link" href="studentallinfo">학적부관리</a>
						<a class="nav-link" href="studentRecord">학생명단조회</a>
					</nav>
				</div>
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts3" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
<!-- 						<i class="fas fa-columns"></i> -->
					</div> 교육과정관리
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>
				<div class="collapse" id="collapseLayouts3"
					aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
						<a class="nav-link" href="crclmInfo">교육훈련과정 정보관리</a> 
						<a class="nav-link" href="estmg">개설교과목관리</a>
						<a class="nav-link" href="sbjctMG">과목관리</a>
					</nav>
				</div>
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts4" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
					</div> 수강신청관리
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>
				<div class="collapse" id="collapseLayouts4"
					aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
						<a class="nav-link" href="adminApply">수강신청</a> 
						<a class="nav-link" href="adminApplyList">수강신청내역</a>
					</nav>
				</div>
				
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts5" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
					</div> 수업관리
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>
				<div class="collapse" id="collapseLayouts5"
					aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
						<a class="nav-link" href="planmg">강의계획서관리</a>
						<a class="nav-link" href="atnd">출결관리</a>
						<a class="nav-link" href="survey">설문관리</a>
					</nav>
				</div>


			</div>
		</div>
	</nav>
</div>