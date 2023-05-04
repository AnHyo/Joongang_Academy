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
<title>학생설문조사</title>
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
<script type="text/javascript">
$(function(){
$("#mainSuv").hide();
	var Grid = tui.Grid;

	
	Grid.applyTheme('clean', { 
		  row: { 
			    hover: { 
			      background: '#e9ecef' 
			    }
			  }
			});
	
	var loginID = $("#loginID").val(); //학번(로그인된 ID)
	var CRCLM_YEAR = "";
	var CRCLM_CD = "";
	var CRCLM_HALF = "";
	/* 학생정보 Ajax */
	$.post({
		url: "/studentDeInfo",
		data: {
			"student_ID": loginID
		},
		cache: false,
		dataType: "json"
	}).done(function(data) {
		var list2 = data.list2[0];
		var eduname = list2.CRCLM_CD_NAME;
		var quarter = list2.CRCLM_HALF_NAME;
		CRCLM_YEAR = list2.CRCLM_YEAR;
		CRCLM_CD = list2.CRCLM_CD;
		CRCLM_HALF = list2.CRCLM_HALF;
		
		$("#curNM").text(eduname);
		$("#curYear").text(CRCLM_YEAR);
		$("#curQuarter").text(quarter);
	
	}).fail(function() {
		alert("문제가 발생 했습니다.");
	});
	
	/* 설문과목정보 ajax */
			$.post({
				url: "/surveySjList",
				data: {
					"student_ID": loginID
				},
				cache: false,
				dataType: "json"
			}).done(function(data) {
				var slist = data.ssList;
				suvGrid.resetData(slist);
				
			
			}).fail(function() {
				alert("문제가 발생 했습니다.");
			});

	
	class buttonRenderer{
		constructor(props) {
			const el = document.createElement('input');
			el.type='button';
			const sl = document.createElement('input');
			sl.type='button';
			const Nn = document.createElement('span');
			Nn.textContent = '';
			this.value = props.value; // 1 (해당 컬럼 값)
			this.el = el;
			this.n = Nn;
			this.sl = sl;
			this.rowKey = props.rowKey;
			this.render(props);
			this.sl.addEventListener('click', (event) => {
				$("#mainSuv").show();
				$("#readySuv").hide();
				const rowKey = this.rowKey;
				const row = suvGrid.getRow(rowKey);
				var keys = Object.values(row);
				var sbjctNo = keys[0];
			    //alert(loginID + " " + sbjctNo+ " " + CRCLM_YEAR + " " + CRCLM_CD + " " +CRCLM_HALF);
			    	$.post({
						url: "/suvTIs",
						data: {
						"student_ID": loginID,
						"sbjctNo" : sbjctNo,
						"cYear" : CRCLM_YEAR,
						"cCd" : CRCLM_CD,
						"cHalf" : CRCLM_HALF
						},
						cache: false,
						dataType: "json"
					}).done(function(data) {
						var suvTI = data.suvlist[0];
						var suvIn = data.surveyIn; //객관식
						var suvIn2 = data.surveyIn2; //주관식
						var codelist = data.codelist; // 코드(객관식)
						//alert(suvIn.length); // 21
						var table = "";
						var DGSTFN_TITLE = suvTI.DGSTFN_TITLE;
						var DGSTFN_INTRO = suvTI.DGSTFN_INTRO.replace(/(<br>|<br\/>|<br \/>)/g,'\r\n');
						//alert(DGSTFN_INTRO);
						$("#suvNM").text(DGSTFN_TITLE);
						$("#suvInfo").css("white-space", "pre-wrap").html(DGSTFN_INTRO);
						
						// -- 객관식
						for (let i = 0; suvIn.length > i; i++) {
							var DGSTFN_CN = suvIn[i].DGSTFN_CN; // 질문
							var DGSTFN_NM = suvIn[i].DGSTFN_NM; // 설문1
							var DGSTFN_NO = suvIn[i].DGSTFN_NO; // 설문 번호
							
							
							table += "<tr>";
							table += "<td class='tbc col-2' id='"+DGSTFN_NO+"'><b>" + DGSTFN_NM + "<b></td>";
							table += "<td class='col-10'>";
							table += "<div style='margin-bottom: 20px;'>" + DGSTFN_CN + "</div>";
							table += "<div style='width: auto; height: auto;'>";
							for (let i = 0; codelist.length > i; i++) {
								var CD = codelist[i].CD;
								var CD_NM = codelist[i].CD_NM;
								table += "<label for='radio"+ DGSTFN_NO + CD +"' style='display: block;'>";
								table += "<input type='radio' id='radio"+ DGSTFN_NO + CD +"' name='answer"+DGSTFN_NO+"' value='"+CD+"'>&nbsp"+CD_NM+"";
								table += "</label>"
							}
							table += "</div>";
							table += "</td>";
							table += "</tr>";
							
						}
						

						// -- 주관식
						for (let i = 0; suvIn2.length > i; i++) {
							var DGSTFN_CN = suvIn2[i].DGSTFN_CN; // 질문
							var DGSTFN_NM = suvIn2[i].DGSTFN_NM; // 설문1
							var DGSTFN_NO = suvIn2[i].DGSTFN_NO; // 설문 번호
							
							table += "<tr>";
							table += "<td class='tbc col-2'><b>"+DGSTFN_NM+"</b></td>";
							table += "<td class='col-10'>";
							table += "<div style='margin-bottom: 20px;'>"+ DGSTFN_CN +"</div>";
							table += "<div class='textarea-wrapper'>";
							table += "<textarea class='form-control' data-suv='"+DGSTFN_NO+"' id='subShort"+ DGSTFN_NO +"' style='height: 150px; resize: none;' maxlength='4000'></textarea>";
							table += "<span id='char-count'>0/4000</span>";
							table += "</div>";
							table += "</td>";
							table += "</tr>";
							
							
							
						}
						
						$("#suv-table").append(table);
						// -- 글자수 체크
						$('.textarea-wrapper').each(function() {
							  var $textarea = $(this).find('textarea');
							  
							  $textarea.on('input', function() {
							    var textLength = $(this).val().length;
							    $(this).next('span').text(textLength + '/4000');
							  });
						});
						
						// -- 저장
						$("#saveBtn").click(function(){
							var dataArr = []; // 저장할 데이터를 담을 배열
							//alert(loginID + " " + sbjctNo+ " " + CRCLM_YEAR + " " + CRCLM_CD + " " +CRCLM_HALF);
							 //var unanswered = $("input[name^='answer']:checked").length;
							 var innm = "";
							 var txnm = "";
							 for (let i = 0; suvIn.length > i; i++) {
								 var DGSTFN_NO = suvIn[i].DGSTFN_NO; // 설문 번호
								 innm = $("input[name='answer"+DGSTFN_NO+"']:checked").val();
								  if(innm == undefined){
									  $("input[name='answer"+DGSTFN_NO+"']:first").focus();
									  alert("설문"+DGSTFN_NO+"번 문항이 선택되지 않았습니다.");
									  return false;
								 } else {
									 //alert(loginID + " " + sbjctNo+ " " + CRCLM_YEAR + " " + CRCLM_CD + " " +CRCLM_HALF+ " " + DGSTFN_NO + " " +innm);
									// 데이터를 배열에 추가
							            dataArr.push({
							                "student_ID": loginID,
							                "sbjctNo" : sbjctNo,
							                "cYear" : CRCLM_YEAR,
							                "cCd" : CRCLM_CD,
							                "cHalf" : CRCLM_HALF,
							                "DGSTFN_NO" : DGSTFN_NO,
							                "innm" : innm,
							                "txnm" : ""
							            });
									 
									 
								 }
							 }
							 
							 for (let i = 0; suvIn2.length > i; i++) {
								var DGSTFN_NO = suvIn2[i].DGSTFN_NO;
								txnm = $.trim($("#subShort"+DGSTFN_NO).val());
								//alert(loginID + " " + sbjctNo+ " " + CRCLM_YEAR + " " + CRCLM_CD + " " +CRCLM_HALF+ " " + DGSTFN_NO + " " +txnm);
								dataArr.push({
						            "student_ID": loginID,
						            "sbjctNo" : sbjctNo,
						            "cYear" : CRCLM_YEAR,
						            "cCd" : CRCLM_CD,
						            "cHalf" : CRCLM_HALF,
						            "DGSTFN_NO" : DGSTFN_NO,
						            "innm" : "",
						            "txnm" : txnm
						        });
								
							 }
							 
							 if(confirm("설문을 제출하시겠습니까?")){
							 // ajax 호출
							    $.post({
							        url: "/svSave",
							        cache: false,
							        contentType: "application/json",
							        data: JSON.stringify(dataArr)
							    }).done(function(data) {
							        var result = data.result;
							        if(result != '0'){
							        	alert("설문제출이 완료되었습니다.");
							        	location.href="/stuSuv";
							        }
							    }).fail(function() {
							        alert("문제가 발생 했습니다.");
							    });
							 }
							
							
						});
	
						
					}).fail(function() {
						alert("문제가 발생 했습니다.");
					});

			    
				
			});
			
		}
		
		
		getElement(){    	
			if(this.value =='0'){
				return this.el;
			} else if(this.value=='1'){
				return this.sl;
			} else {
				return this.n;
			}

		}
		
		render(props){
			this.el.value="참여완료"; //value 값
			this.el.id="secbtn"; // id 값
			//this.el.setAttribute("data-value", this.sbjctNo); //data-value값
			this.el.setAttribute("disabled",'true');
			this.el.setAttribute("class", "secbtn btn rounded-1 fw-bold"); // class값
			this.el.setAttribute("style","width:60px; background-color:#6c757d; color:white;"); //style값
			
			this.sl.value="설문참여";
			this.sl.id="suvgo";
			this.sl.setAttribute("class", "secbtn btn btn-success rounded-2 fw-bold suvgo");
			this.sl.setAttribute("style","width:60px; color:white;");
 			
		}
	}
	
	// -- 취소
	$("#canBtn").click(function(){
		if(confirm("페이지를 나가시겠습니까?\n작성한 내용은 저장되지 않습니다.")){
			location.href="/stuSuv";
		}
	});
	
	
	
	var suvGrid = new tui.Grid({
	      el: document.getElementById('suvListGrid'),
	      scrollX: true,
	      scrollY: true,
	      columns: [
	    	{
		          header: '과목코드',
		          name: 'SBJCT_NO',
		          align:'center',
				  sortingType: 'asc',
				  sortable: true,
				  hidden: true
		     },
	        {
	          header: '과목명',
	          name: 'SBJCT_NM',
	          align:'center',
			  sortingType: 'asc',
			  sortable: true
	        },
	        {
	          header: '강사명',
	          name: 'KORN_FLNM',
	          align:'center',
			  sortingType: 'asc',
			  sortable: true
	        },
	        {
	          header: '교과구분',
	          name: 'ESNTL_YN',
	          align:'center',
			  sortingType: 'asc',
			  sortable: true
	        },
	        {
	          header: '설문명',
	          name: 'DGSTFN_TITLE',
	          align:'center',
			  sortingType: 'asc',
			  sortable: true
	        },
	       
			{
				header : '설문기간',
				name : 'DGSTFN_SFDATE',
		        align:'center',
			    sortingType: 'asc',
			    sortable: true
			},
			{
				  header : '비고',
				  name : 'BUTTON',
				  align:'center',
				  sortingType: 'asc',
				  sortable: true,
				  renderer: { type: buttonRenderer },
				}		
			],
		selectionUnit: 'row'
		
		});
	
	
	
});

</script>
<style type="text/css">
.tui-grid-cell {
  font-size: 14px;
}

.tbc{
	text-align: center;
	vertical-align: middle;
}
tbody tr{
 height: 220px;
}

.textarea-wrapper {
  position: relative;
}

#char-count {
  position: absolute;
  right: 6px;
  bottom: 5px;
  color: gray;
}
</style>
</head>
<body class="d-flex flex-column h-100 bg-light">
	<main class="flex-shrink-0">
		<%@include file="../portalbar/topbar.jsp"%>
		<!-- Page Content-->
		<!-- 설문조사 현황 -->
		<div id ="readySuv">
		<div class="my-5">
			<div class="text-center mb-5">
				<h1 class="display-5 fw-bold mb-0">
					<span class="text-gradient d-inline">설문조사</span>
				</h1>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">
					<!-- Experience Section-->

					<div
						class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">수강정보</h4>
					</div>
					
					<!-- 정보 내용 -->
					<div class="card shadow border-0 rounded-2 mb-1 ">
						<div class="card-body p-4">
							<div class="row align-items-center">
								<div class="col-6">
							  	<div class="row">
							  		<span class="col-2 d-flex justify-content-end fw-bolder">교육과정</span>
							  		<input type="hidden" id="loginID" value="${sessionScope.id}">
									<div class="col-9 div-padding">
										<div id="curNM"></div>
						  			</div>
	  							</div>
						  	</div>
						  <div class="col-3">
						  	<div class="row">
								<span class="col-4 d-flex justify-content-end fw-bolder">교육년도</span>
								<div class="col-6 div-padding">
									<div id="curYear"></div>
								</div>
							</div>
						 </div>
						 <div class="col-2">
						  	<div class="row">
								<span class="col-5 d-flex justify-content-end fw-bolder">교육분기</span>
								<div class="col-7 div-padding">
									<div id="curQuarter"></div>
								</div>
							</div>
						 </div>
							</div>
						</div>
					</div>



					<!-- Divider-->
					<div class="pb-5"></div>
					
					<div class="d-flex align-items-center justify-content-between mb-4 px-3">
						<h4 class="text-success fw-bolder mb-0">설문조사 현황</h4>
					</div>
					<!-- 설문조사 현황  -->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="mt-2" id="suvListGrid"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
		</div>
		
		<!-- 설문조사 페이지 -->
		<div id="mainSuv">
			<div class="my-5">
			<div class="text-center mb-5" style="display: flex; justify-content: center;">
				<div style="width: 900px; height: 100px; background-color: rgb(22, 160, 133); border-radius: 20px;">
					<h5 class="display-6 fw-bold mb-0" style="line-height: 100px; color: white; font-size: 35px">
						<span id="suvNM">설문조사(이름)</span>
					</h5>
				</div>
			</div>
			<div class="row gx-1 justify-content-center">
				<div class="col-lg-11 col-xl-9 col-xxl-8">

					<!-- Divider-->
					<div class="pb-5"></div>

					<!-- 설문조사 설명  -->
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="mt-2" id="suvInfo" style="font-size: 20px;">
							설문조사 인트로
							</div>
						</div>
					</div>
					
					<div class="card shadow border-0 rounded-2 mb-5">
						<div class="card-body p-4">
							<div class="mt-2" id="suvQuestion" style="font-size: 20px;">
									<table class="table table-center table-sm table-bordered"
										id="dataTable" width="100%" cellspacing="0">
										<thead>
											<tr class="tbc" style="height: 75px; background-color: #f9f9f9">
												<th colspan="2" class="col-md-1">설문지 문항</th>
											</tr>
										</thead>

										<tbody id="suv-table" data-spy="scroll"
											data-target="#list-example" data-offset="0"
											class="scrollspy-example">

										</tbody>
									</table>
								</div>
						</div>
					</div>

						<div class="d-flex justify-content-center mt-2">
							<button type="button" class="btn btn-secondary btn-lg" id="canBtn" style="margin-right: 15px;">취소</button>
							<button type="button" class="btn btn-warning btn-lg" id="saveBtn">저장</button>
						</div>

					</div>
			</div>
		</div>
		</div>
	</main>
	
	<%@include file="../portalbar/footer.jsp"%>
	<%@include file="./planModal.jsp"%>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts2.js"></script>
</body>
</html>
