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
		function fn_control_mouse(){
			$(document).bind("contextmenu", function(e){
				return false;
			});
			$(document).bind("selectstart", function(e){
				return false;
			});
			$(document).bind("dragstart", function(e){
				return false;
			});
		}
		fn_control_mouse();
		
		$("#searchbtn").click(function() {
			$.post({
				url : "/listAjax",
				dataType : "json"

			}).done(function(data) {
				grid.resetData(data.list);
				let selectedRowKey = null;
				grid.on('focusChange', (ev) => {
					  grid.setSelectionRange({
					    start: [ev.rowKey, 0],
					    end: [ev.rowKey, grid.getColumns().length]
					  });
				});
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
					$(".sbjnm").attr("disabled",false);
					$(".sbjhr").attr("disabled",false);
					$(".sbjex").attr("disabled",false);
					$(".delU").attr("disabled",false);
					$(".useU").attr("disabled",false);
					
					$(".sbjno").val(sbjno);
					$(".sbjnm").val(sbjnm);
					$(".sbjhr").val(eduhr);
					$(".sbjex").val(sbjex);
					if(useyn == 'Y'){
						$("input:radio[name ='useU']:input[value='Y']").attr("checked", true);
					} else if(useyn == 'N'){
						$("input:radio[name ='useU']:input[value='N']").attr("checked", true);
					}
					if(delyn == 'Y'){
						$("input:radio[name ='delU']:input[value='Y']").attr("checked", true);
					} else if(delyn == 'N'){
						$("input:radio[name ='delU']:input[value='N']").attr("checked", true);
					}
					
					$("#updatebtn").click(function(){
						
						var sbjnmv = $(".sbjnm").val();
						var sbjhrv = $(".sbjhr").val();
						var sbjexv = $(".sbjex").val();
						var useUv = $("input[name=useU]:checked").val();
						var delUv = $("input[name=delU]:checked").val();
						var rowcnt = grid.getRowCount();
						if(confirm("저장하시겠습니까?")){
						if(sbjno == null){
							$.post({
								url : "/addsbjAjax",
								data: {
									"rowcnt" : rowcnt,
									"SBJCT_NM" :sbjnmv,
									"SBJCT_EXPLN":sbjexv,
									"EDU_HR":sbjhrv,
									"USE_YN":useUv
								},
								dataType : "json"

							}).done(function(data) {
								if(data.result == 1){
									alert("저장되었습니다.");
									grid.resetData(data.list);
									var sbjnm = $(".sbjnm").val("");
									var sbjhr = $(".sbjhr").val("");
									var sbjex = $(".sbjex").val("");
									var useU = $("input[name=useU]").prop("checked", false);
									$(".sbjnm").attr("disabled",true);
									$(".sbjhr").attr("disabled",true);
									$(".sbjex").attr("disabled",true);
									$(".useU").attr("disabled",true);
									$(".delU").attr("disabled",true);
								}
							}).fail(function() {
								alert("문제가 발생했습니다.");
							});		
							}else if(sbjno != null){
								$.post({
									url : "/updatesbjAjax",
									data: {
										"SBJCT_NO" : sbjno,
										"SBJCT_NM" :sbjnmv,
										"SBJCT_EXPLN":sbjexv,
										"EDU_HR":sbjhrv,
										"USE_YN":useUv,
										"DEL_YN":delUv,
									},
									dataType : "json"

								}).done(function(data) {
									if(data.result == 1){
										alert("저장되었습니다.2");
										grid.resetData(data.list);
										$(".sbjnm").val("");
										$(".sbjhr").val("");
										$(".sbjex").val("");
										$("input[name=useU]").prop("checked", false);
										$("input[name=delU]").prop("checked", false);
										$(".sbjnm").attr("disabled",true);
										$(".sbjhr").attr("disabled",true);
										$(".sbjex").attr("disabled",true);
										$(".useU").attr("disabled",true);
										$(".delU").attr("disabled",true);
									}
								}).fail(function() {
									alert("문제가 발생했습니다.");
								});	
							}
						}
				});
					
					
					
				});
				$("#addbtn").removeClass("disabled");
				$("#updatebtn").removeClass("disabled");
				$("#delbtn").removeClass("disabled");
				$("#addbtn").click(function(){
					$("#addbtn").addClass("disabled");
					$(".sbjnm").attr("disabled",false);
					$(".sbjhr").attr("disabled",false);
					$(".sbjex").attr("disabled",false);
					$(".useU").attr("disabled",false);
					
					grid.appendRow(data.list,{
						focus : true
					});
					
				});
				
			
		
			$("#delbtn").click(function(){
				const rowKey = grid.getFocusedCell().rowKey
				var obj = grid.getRow(rowKey);
				var keys = Object.values(obj);
				var sbjno= keys[0];
				alert(keys[0]);
				if(confirm("삭제하시겠습니까?")){
					$.post({
						url : "/delsbjAjax",
						data: {
							"rowcnt" : sbjno
						},
						dataType : "json"

					}).done(function(data) {
						if(data.result == 1){
							alert("삭제되었습니다.");
							grid.resetData(data.list);
							var sbjnm = $(".sbjnm").val("");
							var sbjhr = $(".sbjhr").val("");
							var sbjex = $(".sbjex").val("");
							var useU = $("input[name=useU]").prop("checked", false);
							$(".sbjnm").attr("disabled",true);
							$(".sbjhr").attr("disabled",true);
							$(".sbjex").attr("disabled",true);
							$(".useU").attr("disabled",true);
							$(".delU").attr("disabled",true);
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});		
				}
			});
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

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
			contextMenu: null,
			bodyHeight : 250,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : '과목코드',
				name : 'SBJCT_NO',
				align : 'center',
				width:200
			
			}, {
				header : '과목명',
				name : 'SBJCT_NM',
				align : 'center',
				width:280
			}, {
				header : '과목설명',
				name : 'SBJCT_EXPLN',
				width:800
			}, {
				header : '총 강의시간',
				name : 'EDU_HR',
				align : 'center',
				width:100,
				formatter({value}) {
					var hr = value;
				    if(value != null){
					return hr+'분' ;
				    }
				}
			}, {
				header : '사용여부',
				name : 'USE_YN',
				align : 'center',
				width:100
			}, {
				header : '삭제여부',
				name : 'DEL_YN',
				width:100,
				align : 'center'
				
			} ],
			selectionUnit: 'row'
			
		});

	});
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
							<button type="button" class="btn btn-secondary btn-sm disabled"
								id="addbtn">신규</button>
							<button type="button" class="btn btn-secondary btn-sm disabled"
								id="delbtn">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm disabled"
								id="updatebtn">저장</button>
						</div>
					</div>
					<!-- 검색 -->
					<div class="mb-2 d-flex justify-content-center">
						<div class="row"
							style="width: 100%; height: 60px; background-color: #F3FAFE;">
							<div class="col-2"></div>
							<div class="col-4" style="height: 100%;">
								<div class="row">
									<div class="col-6 fw-bolder d-flex justify-content-end"
										style="line-height: 60px;">과목명</div>
									<div class="col-6 mt-2 py-1 ">
										<input type="text" class="form-control">
									</div>
								</div>
							</div>
							<div class="col-4" style="height: 100%;">
								<div class="row">
									<div class="col-3 fw-bolder d-flex justify-content-end"
										style="line-height: 60px;">사용여부</div>
									<div class="col-3 mt-3 py-1">
										<div class="row">
											<div class="col-6">
												<input type="radio" class="form-check-input" name="use"
													id="use1" style="cursor: pointer;"> <label
													for="use1" class="ml-1 text-center form-check-label"
													style="cursor: pointer;">&nbsp;Y</label>
											</div>
											<div class="col-6">
												<input type="radio" class="form-check-input" name="use"
													id="use2" style="cursor: pointer;"> <label
													for="use2" class="form-check-label"
													style="cursor: pointer;">&nbsp;N</label>
											</div>
										</div>
									</div>
									<div class="col-3 fw-bolder d-flex justify-content-end"
										style="line-height: 60px;">삭제여부</div>
									<div class="col-3 mt-3 py-1">
										<div class="row">
											<div class="col-6">
												<input type="radio" style="cursor: pointer;"
													class="form-check-input" name="del" id="del1"> <label
													for="del1" style="cursor: pointer;"
													class="ml-1 text-center">&nbsp;Y</label>
											</div>
											<div class="col-6">
												<input type="radio" style="cursor: pointer;"
													class="form-check-input" name="del" id="del2"> <label
													for="del2" style="cursor: pointer;">&nbsp;N</label>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

					<div id="grid" class="mb-3" style="width: 100%;"></div>


					<hr style="height: 4px;" class="mb-2">


					<div class="mb-3"
						style="width: 100%; height: 350px; background-color: #F3FAFE;">
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">과목코드</div>
							<div class="col-2 mt-2 py-1">
								<input type="text" class="form-control col-6 sbjno"
									disabled="disabled">
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">과목명</div>
							<div class="col-2 mt-2 py-1">
								<input type="text" class="form-control col-6 sbjnm"
									disabled="disabled" id="sbjnm">
							</div>
							<div class="col-2 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">사용여부</div>
							<div class="col-2 mt-3 py-1">
								<div class="row">
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-check-input useU" disabled="disabled" name="useU"
											id="useU1" value="Y"> <label for="useU1"
											style="cursor: pointer;"
											class="ml-1 text-center form-check-label">&nbsp;Y</label>
									</div>
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-check-input useU" name="useU" id="useU2"
											disabled="disabled" value="N"> <label for="useU2"
											style="cursor: pointer;"
											class="ml-1 text-center form-check-label">&nbsp;N</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">총 강의시간</div>
							<div class="col-2 mt-2 py-1">
								<input type="number" class="form-control sbjhr"
									disabled="disabled" step="30">
							</div>
							<div class="col-2 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">삭제여부</div>
							<div class="col-2 mt-3 py-1">
								<div class="row">
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-check-input delU" name="delU" id="delU1"
											disabled="disabled" value="Y"> <label for="delU1"
											style="cursor: pointer;"
											class="ml-1 text-center form-check-label">&nbsp;Y</label>
									</div>
									<div class="col-3">
										<input type="radio" style="cursor: pointer;"
											class="form-check-input delU" name="delU" id="delU2"
											disabled="disabled" value="N"> <label for="delU2"
											style="cursor: pointer;" class="form-check-label">&nbsp;N</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="width: 100%;">
							<div class="col-1"></div>
							<div class="col-3 fw-bolder d-flex justify-content-end"
								style="line-height: 60px;">과목 설명</div>
							<div class="col-6 mt-2 py-1">
								<textarea rows="5" class="form-control col-6 sbjex"
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
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>