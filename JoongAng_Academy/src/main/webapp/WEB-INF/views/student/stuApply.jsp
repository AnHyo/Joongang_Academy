<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>중앙정보처리학원</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Custom Google font-->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@100;200;300;400;500;600;700;800;900&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="css/styles2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>


<script>
        $(function(){
        	
        	
        	
        	
        	
         	const Grid = tui.Grid;
        	
        	Grid.applyTheme('clean', { 
        		  row: { 
        			    hover: { 
        			      background: '#e9ecef' 
        			    }
        			  }
        	});

        		var CRCLM_HALF = "";
        		var CRCLM_CD = "";
        		var CRCLM_YEAR ="";
        		var stdnt_no =$("#loginID").val();
        		console.log(stdnt_no);
        		 $.post({
        				url : "/stuinfoAjax",
        				data : {
        					"stdnt_no" : stdnt_no
        				},
        				dataType : "json"

        			}).done(function(data) {
        				var info = data.info;
        				$("#stdntNo").text(info[0].STDNT_NO);
        				$("#searchNM").text(info[0].KORN_FLNM_S);
        				$("#regNM").text(info[0].REG_CD_NAME);
        				$("#crclmYear").text(info[0].CRCLM_YEAR);
        				$("#crclmHalf").text(info[0].CRCLM_HALF_NAME);
        				$("#crclmNM").text(info[0].CRCLM_CD_NAME);
        				$("#userBrdT").text(info[0].USER_BRDT);
        				$("#genderNM").text(info[0].GENDER_CD_NAME);
        				$("#relTel").text(info[0].TELNO);
        				$("#emailAddr").text(info[0].EML_ADDR);
        				$("#rprsNM").text(info[0].KORN_FLNM_L);
        				
        				 CRCLM_HALF = info[0].CRCLM_HALF;
        				 CRCLM_CD = info[0].CRCLM_CD;
        				 CRCLM_YEAR = info[0].CRCLM_YEAR;
        				 $.post({
        						url : "/estblSBJAjax",
        						data : {
        							
        							"CRCLM_HALF" : CRCLM_HALF,
        							"CRCLM_CD" : CRCLM_CD,
        							"CRCLM_YEAR" : CRCLM_YEAR,
        							"STDNT_NO" : stdnt_no
        						},
        						dataType : "json"

        					}).done(function(data) {
        						var estbl = data.estblSBJ;
        						estblSBJ.resetData(estbl);
        						var apply = data.applySBJ;
        						applySBJ.resetData(apply);
        						estblSBJ.refreshLayout();
        						$("#search_value").attr("disabled",false);
        						$("#search_name").attr("disabled",false);
        						$(".esntlchk").attr("disabled",false);
        						$("#sbjSearchbtn").attr("disabled",false);
        					}).fail(function() {
        						alert("문제가 발생했습니다.");
        					}); //estblSBJAjax 
        			}).fail(function() {
        				alert("문제가 발생했습니다.");
        			});
        		 
        		 
        	
        	
        	
        	class buttonRenderer{
        		constructor(props) {
        			const el = document.createElement('input');
        			
        			el.type='button';
        			
        			this.el = el;
        			this.render(props);
        			this.el.addEventListener('click', (event) => {
        				
        				var STDNT_NO=$("#stdntNo").text();
        				var SBJCT_NO= el.getAttribute("data-value");

        	 			$.post({
        					url : "/addApplyAjax",
        					data : {
        						"STDNT_NO" : STDNT_NO,
        						"SBJCT_NO" : SBJCT_NO,
        						"CRCLM_HALF" : CRCLM_HALF,
        						"CRCLM_CD" : CRCLM_CD,
        						"CRCLM_YEAR" : CRCLM_YEAR
        					},
        					dataType : "json"

        				}).done(function(data) {
        					let check = data.check;
        					let result = data.result;
        					let classTMChk = data.classTMChk;
        					if(check == 0){
        						if(classTMChk == 0){
        							if(result == 1){
        							alert("신청을 완료했습니다.");
        							var apply = data.applySBJ;
        							applySBJ.resetData(apply);
        							} else{
        								alert("문제가 발생했습니다. 다시 시도 해주세요.");
        							}
        						} else{
        							alert("시간이 중복됩니다.");
        						}
        					} else{
        						alert("이미 신청한 과목입니다.");
        					}
        				}).fail(function() {
        					alert("문제가 발생했습니다.");
        				});
        				
        				
        			});
        			
        		}
        		
        		
        		getElement(){
        			return this.el;
        		}
        		
        		render(props){
        			this.el.value="신청";
        			this.el.id="applybtn";
        			this.el.setAttribute("data-value", props.value);
        			this.el.setAttribute("class", "applybtn btn btn-success rounded-1 fw-bold");
        			this.el.setAttribute("style","width:50px;")
        		}
        	}
        	
        	class buttonRenderer2{
        		constructor(props) {
        			const el = document.createElement('input');
        			
        			el.type='button';
        			
        			this.el = el;
        			this.render(props);
        			this.el.addEventListener('click', (event) => {
        				
        				var STDNT_NO=$("#stdntNo").text();
        				var SBJCT_NO= el.getAttribute("data-value");
        				 $.post({
        						url : "/delApplyAjax",
        						data : {
        							"STDNT_NO" : STDNT_NO,
        							"SBJCT_NO" : SBJCT_NO,
        							"CRCLM_HALF" : CRCLM_HALF,
        							"CRCLM_CD" : CRCLM_CD,
        							"CRCLM_YEAR" : CRCLM_YEAR
        						},
        						dataType : "json"

        					}).done(function(data) {
        						let result = data.result;
        						let esntl = data.esntl;
        						if(esntl == 0){
        							if(result == 1){
        								alert("신청을 취소했습니다.");
        								var apply = data.applySBJ;
        								applySBJ.resetData(apply);
        							}
        						} else{
        							alert("필수과목입니다.");
        						}
        					}).fail(function() {
        						alert("문제가 발생했습니다.");
        					});  
        				
        				
        				
        			});
        			
        		}
        		
        		
        		getElement(){
        			return this.el;
        		}
        		
        		render(props){
        			this.el.value="삭제";
        			this.el.id="delbtn";
        			this.el.setAttribute("data-value", props.value);
        			this.el.setAttribute("class", " delbtn btn btn-danger rounded-1 fw-bold");
        			this.el.setAttribute("style","width:50px;")
        		}
        	}
        	class buttonRenderer3{
        		constructor(props) {
        			const el = document.createElement('input');
        			el.type='button';
        			const Nn = document.createElement('span');
        			Nn.textContent = 'N';
        			this.value=props.value;
        			this.el = el;
        			this.n = Nn;
        			this.render(props);
        			this.el.addEventListener('click', (event) => {
						$("#sbjPlanModal").modal("show");
        			});
        			
        		}
        		
        		
        		getElement(){    	
        			if(this.value =='Y'){
        				return this.el;
        			} else if(this.value=='N'){
        				return this.n;
        			}

        		}
        		
        		render(props){
        			this.el.value="보기";
        			this.el.id="planbtn";
//         			this.el.setAttribute("data-value", $(".applybtn").attr("data-value"));
        			this.el.setAttribute("class", "planbtn btn rounded-1 fw-bold");
        			this.el.setAttribute("style","width:50px; background-color:#6c757d; color:white;");
        		}
        	}

        
        
        	
        	var estblSBJ = new tui.Grid({
          		el : document.getElementById('estblSBJ'),
        		scrollX : false,
        		scrollY : true,
        		bodyHeight : 250,
        		columns : [ 
        		 {
        			header : '필수구분',
        			name : 'ESNTL_YN',
        			width : 120,
        			align:'center',
        			formatter: function(e) {
        			    if (e.value == 'Y') {
        			      return '필수';
        			    } else if(e.value == 'N') {
        			      return '선택';
        			    }
        			 },
        			 sortable: true,
        			 sortingType: 'desc'
        		}, {
        			header : '개설과목명',
        			name : 'SBJCT_NM',
        			width : 350,
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		}, {
        			header : '강사명',
        			name : 'KORN_FLNM',
        			width : 150,
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		}, {
        			header : '강의시간',
        			name : 'CLASSTM',
        			width : 200,
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		},{
        			header : '강의실',
        			name : 'ROOM_NM',
        			width : 160,
        			align:'center',
        		 	sortable: true,
        		    sortingType: 'desc'
        		}, {
        			header : '강의계획서',
        			name : 'SBJCT_PLAN_YN',
        			width : 120,
        			minwidth:'auto',
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc',
	        		renderer:{
	        			type: buttonRenderer3
	        		 }
        		},{ 	
        			header : '신청',
        			name: 'SBJCT_NO', 
        			renderer: { type: buttonRenderer },
        			width: 100,
        			align:'center'
        		} ] 
        	}); //estblSBJ grid
        	
        	
        	
        	var applySBJ = new tui.Grid({
          		el : document.getElementById('applySBJ'),
        		scrollX : false,
        		scrollY : true,
        		bodyHeight : 250,
        		columns : [ 
        		 {
        			header : '필수구분',
        			name : 'ESNTL_YN',
        			width : 120,
        			align:'center',
        			formatter: function(e) {
        			    if (e.value == 'Y') {
        			      return '필수';
        			    } else if(e.value == 'N') {
        			      return '선택';
        			    }
        			 },
        			 sortable: true,
        			 sortingType: 'desc'
        		}, {
        			header : '개설과목명',
        			name : 'SBJCT_NM',
        			width : 350,
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		}, {
        			header : '강사명',
        			name : 'KORN_FLNM',
        			width : 150,
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		}, {
        			header : '강의시간',
        			name : 'CLASSTM',
        			width : 200,
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		},{
        			header : '강의실',
        			name : 'ROOM_NM',
        			width : 160,
        			align:'center',
        		 	sortable: true,
        		    sortingType: 'desc'
        		}, {
        			header : '강의계획서',
        			name : 'SBJCT_PLAN_YN',
        			width : 120,
        			minwidth:'auto',
        			align:'center',
        			sortable: true,
        		    sortingType: 'desc'
        		},{ 	
        			header : '삭제',
        			name: 'SBJCT_NO', 
        			renderer: { type: buttonRenderer2 },
        			width: 100,
        			align:'center'
        		} ] 
        	});// applySBJ grid

        	$("#search_value,input[name=esntlchk]").on("keydown", function(key) {
        		 if(key.keyCode == 13){
        				$("#sbjSearchbtn").click();
        		}
        	});
        	$("#sbjSearchbtn").click(function(){
        		var search_value = $.trim($("#search_value").val());
        		var search_name = $("#search_name").val();
        		var esntlchk = $("input[name=esntlchk]:checked").val();
        		 $.post({
        				url : "/estblSBJAjax",
        				data : {
        					
        					"CRCLM_HALF" : CRCLM_HALF,
        					"CRCLM_CD" : CRCLM_CD,
        					"CRCLM_YEAR" : CRCLM_YEAR,
        					"STDNT_NO" : stdnt_no,
        					"search_value" : search_value,
        					"search_name" : search_name,
        					"esntlchk" : esntlchk
        				},
        				dataType : "json"

        			}).done(function(data) {
        				var estbl = data.estblSBJ;
        				estblSBJ.resetData(estbl);
        			}).fail(function() {
        				alert("문제가 발생했습니다.");
        			}); //estblSBJAjax Search 
        		
        		
        	});
        	
        	
        });
        
        </script>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<!-- Navigation-->
		<nav class="navbar navbar-expand-lg navbar-light bg-white py-3">
			<div class="container px-5">
				<a class="navbar-brand" href="index.html"><span
					class="fw-bolder text-primary">Start Bootstrap</span></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0 small fw-bolder">
						<li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="resume.html">Resume</a></li>
						<li class="nav-item"><a class="nav-link" href="projects.html">Projects</a></li>
						<li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- Page Content-->
		<div class="my-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">수강신청</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<!-- Experience Section-->

					<div
						class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">내 정보</h4>
					</div>
					<!-- Experience Card 1-->

					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<div class="row align-items-center">
								<div class="row col-4">
									<div class="col-4 d-flex justify-content-end fw-bolder">학번(이름)</div>
									<input type="hidden" id="loginID" value="${sessionScope.id}">
									<div class="col-8">
										<span id="stdntNo" class="col-6">dsf</span> (<span
											id="searchNM" class="col-6">sfds</span>)
									</div>
								</div>
								<div class="col-2">
									<div class="row">
										<div class="col-5 d-flex justify-content-end fw-bolder">학적상태</div>
										<div class="col-4" id="regNM"></div>
									</div>
								</div>
								<div class="col-6">
									<div class="row">
										<div class="col-2 d-flex justify-content-end fw-bolder">과정구분</div>
										<div class="col-10">
											<span id="crclmYear"></span>&nbsp;/&nbsp; <span
												id="crclmHalf"></span>&nbsp;/&nbsp;&nbsp; <span id="crclmNM"></span>
										</div>
									</div>

								</div>
							</div>
							<div class="row d-flex justify-content-end mt-3">
								<div class="row col-3">
									<div class="col-4 d-flex fw-bolder">생년월일</div>
									<div class="col-8 ">
										<span id="userBrdT" class="col-8">dsf</span> (<span
											id="genderNM" class="col-4">sfds</span>)
									</div>
								</div>
								<div class="row col-3">
									<div class="col-3 d-flex justify-content-end fw-bolder">연락처</div>
									<div class="col-8" id="relTel"></div>
								</div>
								<div class="row col-3">
									<div class="col-3 d-flex justify-content-end fw-bolder">이메일</div>
									<div class="col-9" id="emailAddr"></div>
								</div>
								<div class="row col-3">
									<div class="col-4 d-flex justify-content-end fw-bolder">대표강사</div>
									<div class="col-8" id="rprsNM"></div>
								</div>
							</div>
						</div>
					</div>



					<!-- Divider-->
					<div class="pb-5"></div>
					<!-- Skills Section-->
					<!-- Skillset Card-->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="row">

								<div class="d-flex align-items-center col-3">
									<h6 class="fw-bolder mb-2 px-2">
										<span class=" d-inline">개설과목</span>
									</h6>
								</div>
								<div class="col-4">
									<div class="row d-flex justify-content-end"
										style="margin-left: 40px; margin-right: -50px;">
										<div class="col-3" style="margin-left: 20px;">
											<input type="radio" style="cursor: pointer;"
												checked="checked" class="form-check-input esntlchk"
												name="esntlchk" id="allchk" value=""> <label
												for="allchk"
												style="cursor: pointer; font-size: 14px; vertical-align: 1px;"
												class="text-center form-check-label">&nbsp;전체</label>
										</div>
										<div class="col-3" style="margin-left: -20px;">
											<input type="radio" style="cursor: pointer;"
												class="form-check-input esntlchk" name="esntlchk" id="Ychk"
												value="Y"> <label for="Ychk"
												style="cursor: pointer; font-size: 14px; vertical-align: 1px;"
												class="text-center form-check-label">&nbsp;필수</label>
										</div>
										<div class="col-3" style="margin-left: -20px;">
											<input type="radio" style="cursor: pointer;"
												class="form-check-input esntlchk" name="esntlchk" id="Nchk"
												value="N"> <label for="Nchk"
												style="cursor: pointer; font-size: 14px; vertical-align: 1px;"
												class="text-center form-check-label">&nbsp;선택</label>
										</div>
									</div>
								</div>
								<div class="col-5">
									<div class="input-group" style="margin-top: -5px;">
										<div class="col-3">
											<select class="form-control form-control-sm"
												disabled="disabled" name="search_name" id="search_name"
												style="border-radius: 5px 0 0 5px;">
												<option value="all" selected>전체</option>
												<option value="sbjNM">과목명</option>
												<option value="instrNM">강사명</option>
											</select>
										</div>
										<input type="text" name="search_value" id="search_value"
											disabled="disabled"
											class="form-control form-control-sm border-gray col-md-8"
											placeholder="검색어를 입력하세요">
										<button class="btn btn-dark btn-sm" type="button"
											disabled="disabled" id="sbjSearchbtn">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
							<div class="mb-1">
								<div class="d-flex align-items-center mb-4">

									<div id="estblSBJ" class="mb-2 mt-1"
										style="width: 100%; height: 270px;"></div>
								</div>

							</div>
							<div class="d-flex align-items-center">

								<h6 class="fw-bolder mb-2 mt-3 px-2">
									<span class=" d-inline">신청과목</span>
								</h6>
							</div>
							<div class="mb-5">
								<div class="d-flex align-items-center">
									<div id="applySBJ" class="mb-3 mt-1"
										style="width: 100%; height: 270px;"></div>
								</div>

							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<footer class="bg-white py-4 mt-auto">
		<div class="container px-5">
			<div
				class="row align-items-center justify-content-between flex-column flex-sm-row">
				<div class="col-auto">
					<div class="small m-0 text-muted">
						서울 강남구 테헤란로 7길 7(역삼동 에스코빌딩 6층) / 대표자:정현경 / 사업자등록번호:220-90-07535 /
						통신판매번호:제 강남-8062호 / TEL:02-561-1911 / FAX:02-538-2613<br>

						학원설립/운영 등록번호: 제02197000003호 중앙정보처리학원 / 중앙정보기술인재개발원<br>

						개인정보관리책임자:유창현, infoprotect@choongang.co.kr Copyright ⓒ 1969 by
						CHOONGANG INSTITUTE, All Rights Reserved.
					</div>
				</div>
			</div>
		</div>
	</footer>
	<%@include file="./planModal.jsp"%>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts2.js"></script>
</body>
</html>