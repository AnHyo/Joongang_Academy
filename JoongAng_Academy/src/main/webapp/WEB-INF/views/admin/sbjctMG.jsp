<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>중앙정보처리학원</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script>
	$(function() {
		$(".sbjhr").on("change",function(){
			if ($(".sbjhr").val() == 0) {
				$(".sbjhr").val(1);
			}
		});
	
		const Grid = tui.Grid;
		
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				});

	

		
		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			scrollX : false,
			scrollY : true,
			bodyHeight : 250,
			columns : [ {
				header : '과목코드',
				name : 'SBJCT_NO',
				align : 'center',
				width:250,
				sortable: true,
			    sortingType: 'desc'
			
			}, {
				header : '과목명',
				name : 'SBJCT_NM',
				align : 'center',
				width:320,
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '과목설명',
				name : 'SBJCT_EXPLN',
				width:730
			}, {
				header : '총 강의시간',
				name : 'EDU_HR',
				align : 'center',
				width:180,
				formatter({value}) {
					var hr = value;
				    if(value != null){
					return hr+'시간' ;
				    }
				},
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '사용여부',
				name : 'USE_YN',
				align : 'center',
				width:120,
				sortable: true,
			    sortingType: 'desc'
			} ],
			selectionUnit: 'row'
			
		});
		// cell 클릭시
		grid.on('click', () => {
			const rowKey = grid.getFocusedCell().rowKey
			var obj = grid.getRow(rowKey);
			var keys = Object.values(obj);
			var sbjno = keys[0];
			var sbjnm = keys[1];
			var sbjex = keys[2];
			var eduhr = keys[3];
			var useyn = keys[4];
			var delyn = keys[5];
			if(sbjno != "[object Object]"){
			$(".sbjnm").attr("disabled",false);
			$(".sbjhr").attr("disabled",false);
			$(".sbjex").attr("disabled",false);
			$(".useU").attr("disabled",false);
			
			$("#sbjno").val(sbjno);
			$(".sbjno").val(sbjno);
			$(".sbjnm").val(sbjnm);
			$(".sbjhr").val(eduhr);
			$(".sbjex").val(sbjex);
				if(useyn == 'Y'){
					$("input:radio[name ='useU']:input[value='Y']").prop("checked", true);
				} else if(useyn == 'N'){
					$("input:radio[name ='useU']:input[value='N']").prop("checked", true);
				}
			} else {
				$("#sbjno").val("");
				$(".sbjno").val("");
				$(".sbjnm").val("");
				$(".sbjhr").val("");
				$(".sbjex").val("");
				$("input[name=useU]").prop("checked", false);
			}
		}); //grid click
		
		var list = "";
		var searchnm = "";
		var searchuse = "";
		var searchdel = "";
		
		
		//조회 버튼
		$("#searchnm").keydown(function(key){
		  if(key.keyCode == 13){
			$("#searchbtn").click();
		  }
		});
		$("#searchbtn").click(function() {
		 searchnm = $.trim($("#searchnm").val());
		 $("#searchnm").val(searchnm);
		 searchuse = $("input[name=searchuse]:checked").val();
			
			$.post({
				url : "/listAjax",
				data : {
					"searchnm" : searchnm,
					"searchuse" : searchuse,
					"searchdel" : searchdel
				},
				dataType : "json"

			}).done(function(data) {
				list = data.list;
				grid.resetData(list);
				var rowCount = grid.getRowCount();
				
				$("#crclmCount").html(String(rowCount).padStart(3, "0"));
				
				let selectedRowKey = null;
				// cell 하나 클릭시 한 줄 전체 범위 지정
				grid.on('focusChange', (ev) => {
					  grid.setSelectionRange({
					    start: [ev.rowKey, 0],
					    end: [ev.rowKey, grid.getColumns().length]
					  });
				});
				$("#addbtn").removeClass("disabled");
				$("#updatebtn").removeClass("disabled");
				$("#delbtn").removeClass("disabled");
				$("#searchNM").val(searchnm);
				$("#searchUSE").val(searchuse);
				$("#sbjno").val("");
				$(".sbjno").val("");
				$(".sbjnm").val("");
				$(".sbjhr").val("");
				$(".sbjex").val("");
				$("input[name=useU]").prop("checked", false);
				$(".sbjnm").attr("disabled",true);
				$(".sbjhr").attr("disabled",true);
				$(".sbjex").attr("disabled",true);
				$(".useU").attr("disabled",true);
				
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

		});

		// 신규 버튼
		$("#addbtn").click(function(){
			var searchNM = $.trim($("#searchNM").val());
			var searchUSE = $("#searchUSE").val();
			grid.appendRow(list,{
				focus : true
			}); // appendRow end
			$("#addbtn").addClass("disabled");
			$("#sbjno").val("");
			$(".sbjno").val("");
			$(".sbjnm").val("");
			$(".sbjhr").val("");
			$(".sbjex").val("");
			$("input[name=useU]").prop("checked", false);
			$("input[name=delU]").prop("checked", false);
			$(".sbjnm").attr("disabled",false);
			$(".sbjhr").attr("disabled",false);
			$(".sbjex").attr("disabled",false);
			$(".useU").attr("disabled",false);
		
		}); // addbtn end
		
		// 저장 버튼 (신규저장/ 수정저장)
		$("#updatebtn").click(function(){
				const rowKey = grid.getFocusedCell().rowKey
				var sbjnov = $.trim($("#sbjno").val());
				var sbjnmv = $.trim($(".sbjnm").val());
				var sbjhrv = $.trim($(".sbjhr").val());
				var sbjexv = $.trim($(".sbjex").val());
				var useUv = $("input[name=useU]:checked").val();
				var delUv = $("input[name=delU]:checked").val();
				var searchNM = $.trim($("#searchNM").val());
				var searchUSE = $("#searchUSE").val();
				
				
				if(sbjnmv == ""){
					alert("과목명을 입력하세요");
					return false;
				}
				if(sbjexv == ""){
					alert("과목설명을 입력하세요");
					return false;
				}
				if(sbjhrv == "" || isNaN(sbjhrv)){
					alert("총 강의시간을 올바르게 입력하세요");
					return false;
				}
				if(useUv == ""){
					alert("사용여부를 선택하세요");
					return false;
				}
				
				
				if(sbjnov == ""){
					if(confirm("(신규)저장하시겠습니까?")){
					$.post({
						url : "/addsbjAjax",
						data: {
							"SBJCT_NM" :sbjnmv,
							"SBJCT_EXPLN":sbjexv,
							"EDU_HR":sbjhrv,
							"USE_YN":useUv,
							"searchnm" : searchNM,
							"searchuse" : searchUSE
						},
						dataType : "json"

					}).done(function(data) {
						if(data.result == 1){
							alert("(신규)저장되었습니다.");
							grid.resetData(data.list);
							var rowCount = grid.getRowCount();
							$("#crclmCount").html(String(rowCount).padStart(3, "0"));
							$("#sbjno").val("");
							$(".sbjno").val("");
							$(".sbjnm").val("");
							$(".sbjhr").val("");
							$(".sbjex").val("");
							$("input[name=useU]").prop("checked", false);
							$(".sbjnm").attr("disabled",true);
							$(".sbjhr").attr("disabled",true);
							$(".sbjex").attr("disabled",true);
							$(".useU").attr("disabled",true);
							$("#addbtn").removeClass("disabled");
							
							// 신규 저장 후 focus
							grid.focus(rowKey);
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});	
		
					}// confirm /
					} else if(sbjnov != ""){
						if(confirm("(수정)저장하시겠습니까?2")){
							$.post({
								url : "/updatesbjAjax",
								data: {
									"SBJCT_NO" : sbjnov,
									"SBJCT_NM" :sbjnmv,
									"SBJCT_EXPLN":sbjexv,
									"EDU_HR":sbjhrv,
									"USE_YN":useUv,
									"searchnm" : searchNM,
									"searchuse" : searchUSE
								},
								dataType : "json"

							}).done(function(data) {
								if(data.result == 1){
									alert("(수정)저장되었습니다.");
									grid.resetData(data.list);
									var rowCount = grid.getRowCount();
									$("#crclmCount").html(String(rowCount).padStart(3, "0"));
									$("#sbjno").val("");
									$(".sbjno").val("");
									$(".sbjnm").val("");
									$(".sbjhr").val("");
									$(".sbjex").val("");
									$("input[name=useU]").prop("checked", false);
									$(".sbjnm").attr("disabled",true);
									$(".sbjhr").attr("disabled",true);
									$(".sbjex").attr("disabled",true);
									$(".useU").attr("disabled",true);
									$("#addbtn").removeClass("disabled");
									// 수정 저장 후 focus
									grid.focus(rowKey);
								}
							}).fail(function() {
								alert("문제가 발생했습니다.");
							});	
							
						}
					
					}
				
				}); //updatebtn click
			
				$("#searchnm").keydown(function(key){
					  if(key.keyCode == 13){
						$("#searchbtn").click();
					  }
					});
		
			
			$("#delbtn").click(function(){
				const rowKey = grid.getFocusedCell().rowKey
				var searchNM = $.trim($("#searchNM").val());
				var searchUSE = $("#searchUSE").val();
				var sbjnov = $.trim($("#sbjno").val());
				alert(sbjnov);
 				if(sbjno != "[object Object]"){
				if(confirm("삭제하시겠습니까?")){
					$.post({
						url : "/delsbjAjax",
						data: {
							"rowcnt" : sbjnov,
							"searchnm" : searchNM,
							"searchuse" : searchUSE
						},
						dataType : "json"

					}).done(function(data) {
						if(data.integrity == 1){
							if(data.result == 1){
								alert("삭제되었습니다.");
								grid.resetData(data.list);
								var rowCount = grid.getRowCount();
								$("#crclmCount").html(String(rowCount).padStart(3, "0"));
								$(".sbjno").val("");
								$(".sbjnm").val("");
								$(".sbjhr").val("");
								$(".sbjex").val("");
								$("input[name=useU]").prop("checked", false);
								$(".sbjnm").attr("disabled",true);
								$(".sbjhr").attr("disabled",true);
								$(".sbjex").attr("disabled",true);
								$(".useU").attr("disabled",true);
								$("#addbtn").removeClass("disabled");
								
							}
						} else{
							alert("사용중인 데이터가 있으므로 삭제할 수 없습니다.");
						}
						
						
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});		
					}
				} else{
					alert("정보가 없습니다.");
				}
			}); //delbtn end
	
	}); //function end
</script>
</head>

<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">

						<h5 class="fw-bolder">과목관리</h5>
					</div>
					<hr style="height: 4px;" class="m-0 mb-1">
					<div class="d-flex justify-content-end pb-1 mb-1">
						<div>
							<button type="button" class="btn btn-secondary btn-sm"
								id="searchbtn">조회</button>
						</div>
					</div>
					<!-- 검색 -->
					<div class="mb-2 d-flex justify-content-center">
						<div class="row"
							style="width: 100%; height: 55px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">

							<input type="hidden" id="searchNM"> <input type="hidden"
								id="searchUSE">
							<div class="col-2"></div>
							<div class="col-4" style="height: 100%;">
								<div class="row">
									<div class="col-6 fw-bolder d-flex justify-content-end"
										style="line-height: 55px; font-size: 14px;">과목명</div>
									<div class="col-6 mt-2 py-1 ">
										<input type="text" class="form-control form-control-sm"
											id="searchnm">
									</div>
								</div>
							</div>
							<div class="col-5" style="height: 100%;">
								<div class="row">
									<div class="col-2 fw-bolder d-flex justify-content-end"
										style="line-height: 55px; font-size: 14px;">사용여부</div>
									<div class="col-5 mt-3">
										<div class="row">
											<div class="col-4">
												<input type="radio" class="form-check-input"
													name="searchuse" id="use1" style="cursor: pointer;"
													checked="checked" value=""> <label for="use1"
													class="ml-1 text-center form-check-label"
													style="cursor: pointer; font-size: 14px;">&nbsp;전체</label>
											</div>
											<div class="col-3">
												<input type="radio" class="form-check-input"
													name="searchuse" id="use2" style="cursor: pointer;"
													value="Y"> <label for="use2"
													class="ml-1 text-center form-check-label"
													style="cursor: pointer; font-size: 14px;">&nbsp;Y</label>
											</div>
											<div class="col-3">
												<input type="radio" class="form-check-input"
													name="searchuse" id="use3" style="cursor: pointer;"
													value="N"> <label for="use3"
													class="form-check-label"
													style="font-size: 14px; cursor: pointer;">&nbsp;N</label>
											</div>
										</div>
									</div>

								</div>
							</div>

						</div>
					</div>
					<div class="position-relative" style="display: flex;">

						<div class="float-start mb-2"
							style="width: 10px; height: 29px; background-color: #498c5f; margin-right: 10px;"></div>
						<h6 class="mt-1 fw-bolder">과목</h6>
						<div class="position-relative"
							style="display: flex; width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 30px; margin: 0 10px;">
							<div id="crclmCount"
								style="width: 23px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 30px;">
								000</div>
							건이 조회되었습니다.
						</div>
					</div>
					<div id="grid" class="mb-3 mt-1" style="width: 100%;"></div>


					<hr style="height: 4px;" class="mb-2">
					<div class="d-flex justify-content-between">
						<div style="width: 20%;">
							<div class="float-start mb-3"
								style="width: 10px; height: 29px; background-color: #498c5f; margin-right: 10px;"></div>
							<h6 class="pt-1 fw-bolder">과목정보</h6>
						</div>
						<div>
							<button type="button" class="btn btn-secondary btn-sm disabled"
								id="addbtn">신규</button>
							<button type="button" class="btn btn-secondary btn-sm disabled"
								id="delbtn">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm disabled"
								id="updatebtn">저장</button>
						</div>
					</div>
					<div class="mb-3"
						style="width: 100%; height: 320px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 55px; font-size: 14px;">과목코드</div>
							<div class="col-2 mt-2 py-1">
								<input type="text"
									class="form-control form-control-sm col-6 sbjno"
									disabled="disabled"> <input type="hidden" id="sbjno"
									disabled="disabled">
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 55px; font-size: 14px;">과목명</div>
							<div class="col-2 mt-2 py-1">
								<input type="text"
									class="form-control form-control-sm col-6 sbjnm"
									disabled="disabled" id="sbjnm">
							</div>

						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 55px; font-size: 14px;">총 강의시간</div>
							<div class="col-2 mt-2 py-1">
								<input type="number" class="form-control sbjhr form-control-sm"
									disabled="disabled" step="10"
									onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" min="1"
									max="160">
							</div>

							<div class="col-2 fw-bolder d-flex justify-content-end"
								style="line-height: 55px; font-size: 14px;">사용여부</div>
							<div class="col-2 mt-3">
								<div class="row">
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-check-input useU" disabled="disabled" name="useU"
											id="useU1" value="Y"> <label for="useU1"
											style="cursor: pointer; font-size: 14px;"
											class="ml-1 text-center form-check-label">&nbsp;Y</label>
									</div>
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-check-input useU" name="useU" id="useU2"
											disabled="disabled" value="N"> <label for="useU2"
											style="cursor: pointer; font-size: 14px;"
											class="ml-1 text-center form-check-label">&nbsp;N</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 55px; font-size: 14px;">과목 설명</div>
							<div class="col-6 mt-2 py-1">
								<textarea rows="5"
									class="form-control form-control-sm col-6 sbjex"
									style="resize: none;" disabled="disabled"></textarea>
							</div>
						</div>
					</div>



				</div>
			</main>
			<%@include file="../bar/footer.jsp"%>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>