<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="layoutSidenav_nav">
	<nav class="sb-sidenav accordion sb-sidenav-dark bg-success"
		id="sidenavAccordion">
		<div class="sb-sidenav-menu">
			<div class="nav">
				<div class="sb-sidenav-menu-heading">admin</div>
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts1" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
<!-- 						<i class="fas fa-columns"></i> -->
					</div> 공통관리
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>
				<div class="collapse" id="collapseLayouts1"
					aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
						<div class="nav-link add_tab">공통코드관리</div> 
						<div class="nav-link add_tab">교직원 관리</div>
					</nav>
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
						<a class="nav-link" href="layout-static.html">학적부여관리</a> 
						<a class="nav-link" href="layout-sidenav-light.html">학적부관리</a>
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
						<a class="nav-link" href="layout-static.html">교육훈련과정 정보관리</a> 
						<a class="nav-link" href="layout-sidenav-light.html">개설교과목관리</a>
						<a class="nav-link" href="">과목관리</a>
					</nav>
				</div>



			</div>
		</div>
	</nav>
</div>