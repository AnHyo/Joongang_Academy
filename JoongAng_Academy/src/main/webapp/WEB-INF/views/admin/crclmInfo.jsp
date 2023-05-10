<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0030")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
}
%>
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
<link href="css/styles.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script type="text/javascript"
	src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<style>
.tui-grid-cell {
	font-size: 14px;
}

.selected1 {
	background-color: pink;
}
</style>
<script>
	$(function() {
		//과정일정설정 버튼그룹 숨기기
		$("#buttonGroup").hide();
		
		
		$('#inputYear, .cyear').attr('maxlength', '4');
		$('#inputYear, .cyear').attr('minlength', '4');

		//엔터키
		$("#inputYear").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#listBtn").click();
        }
   		 });
		$("#inputCrclmSearch").keydown(function(key) {
        if (key.keyCode == 13) {
            $("#listBtn").click();
        }
   		 });
		
		
		//공백제거
		$("input").on("input", function() {
			var inputVal = $(this).val().trim();
			$(this).val(inputVal);
		});
		//숫자만 입력
		$("input[numberOnly]").on("input", function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));

			/*    if($(this).val().length < minlength){
				   alert("잘못된");
			   } */
		});

		//훈련비용 , 추가
		$('.ecost').on('input', function() {
			var num = $(this).val().replace(/[^0-9]/g, '');

			if (num.length > 3) {
				num = num.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			$(this).val(function() {
				return num;
			});
		});

		var listCrclm = "";
		// 조회 버튼
		$("#listBtn").click(function() {
			//버튼 활성화
			$("#newBtn").prop('disabled', false);
			$("#deleteBtn").prop('disabled', false);
			$("#saveBtn").prop('disabled', false);

			var yearNum = $("#inputYear").val(); //입력한년도
			var year = yearNum.toString();
			var selectval = $('select[name=crclm_half]').val(); //상/하반기 선택
			var radioval = $('input:radio[name=radioStatus]:checked').val(); //과정현황 선택
			var crclmname = $("#inputCrclmSearch").val();

			if (year == "") {
				alert("학년도 입력은 필수항목입니다.");
				return false;
			}

			$.post({
				url : "/listCrclmAjax",
				cache : false,
				data: JSON.stringify({
					"year" : year,
					"half" : selectval,
					"radioVal" : radioval,
					"crclmName" : crclmname,

				}),
				dataType : "json",
				contentType: 'application/json'
			}).done(function(data) {
				listCrclm = data.listCrclm;
				grid.resetData(listCrclm);
				
				//건수 표시
				let sCount = listCrclm.length;
				$("#searchCount").html(sCount);
	
			}).fail(function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			});
			const Grid = tui.Grid;
			Grid.applyTheme('clean', {
				row : {
					hover : {
						background : '#e9ecef'
					}
				}
			});
			
			grid.on('focusChange', (ev) => {
				  grid.setSelectionRange({
				    start: [ev.rowKey, 0],
				    end: [ev.rowKey, grid.getColumns().length ]
				  });
			});

			// 그리드 클릭후 조회 버튼 다시 누를경우 
			// 정보 지우고 비활성화
			$('.cyear').val(year);
			$(".chalf").val('');
			$(".ccd").val('');
			$(".crclmNameList").val('');
			$(".crclmNameSet").val('');
			$(".bgYMD").val('');
			$(".endYMD").val('');
			$(".ecost").val('');
			$(".econtent").val('');
			$(".instrname").val('');
			$(".schedule").val('');
			$(".efnYN").val('');
			$(".epeople").val('');
			$("#instrNo").val('');
			$(".chalf").prop('disabled', true);
			$(".ccd").prop('disabled', true);
			$(".crclmNameList").prop('disabled', true);
			$(".crclmNameSet").prop('disabled', true);
			$(".bgYMD").prop('disabled', true);
			$(".endYMD").prop('disabled', true);
			$(".ecost").prop('disabled', true);
			$(".econtent").prop('disabled', true);
			$(".instrname").prop('disabled', true);
			$(".schedule").prop('disabled', true);
			$(".efnYN").prop('disabled', true);
			$(".epeople").prop('disabled', true);

		});//조회 버튼
	
       // 조회 클릭후 리스트 출력	
		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			scrollX : false,
			scrollY : true,
			bodyHeight : 250,
			columns : [ {
				header : '훈련과정코드',
				name : 'CRCLM_CD',
				width : 150,
				align : 'center',
				sortable: true
			}, {
				header : '훈련과정명',
				name : 'CRCLM_NM',
				width : 400,
				align : 'center',
				
			}, {
				header : '상/하반기',
				name : 'CRCLM_HALF',
				width : 150,
				align : 'center',
				sortable: true,
				copyOptions : {
					useListItemText : true
				},
				formatter : 'listItemText',
				editor : {
					type : 'radio',
					options : {
						listItems : [ {
							text : '상반기',
							value : '0010'
						}, {
							text : '하반기',
							value : '0020'
						} ]
					}
				}
			}, {
				header : '시작일',
				name : 'EDU_BGNG_YMD',
				width : 150,
				align : 'center',
				sortable: true
				
			}, {
				header : '종료일',
				name : 'EDU_END_YMD',
				width : 150,
				align : 'center',
				sortable: true
				
				
			}, {
				header : '대표강사',
				name : 'KORN_FLNM',
				align : 'center',
			}, {
				header : '모집인원',
				name : 'EDU_NOPE',
				align : 'center',
				formatter({value}) {
				    if(value != null){
					return value+'명' ;
				    }
				}
			}, {
				header : '과정현황',
				name : 'CRCLM_SCHDL_CD',
				align : 'center',
				sortable: true,
				copyOptions : {
					useListItemText : true
				},
				formatter : 'listItemText',
				editor : {
					type : 'radio',
					options : {
						listItems : [ {
							text : '모집',
							value : '0010'
						}, {
							text : '훈련',
							value : '0020'
						}, {
							text : '수료',
							value : '0030'
						} ]
					}
				}

			}, {
				header : '종료여부',
				name : 'EDU_FNSH_YN',
				align : 'center',
				sortable: true

			} ]

		});//grid
	
	
		
		//신규 버튼
		$("#newBtn").click(function() {
			//$(".cyear").prop('readonly', false); //입력가능
			$(this).prop('disabled', true);

			grid.appendRow(listCrclm, {
				focus : true,
				
			}); // appendRow end

			//사용자 입력칸 입력가능
			const inputTags = $("tbody input");
			inputTags.each(function() {
				$(this).val("");
				$(this).prop('disabled', false);
			});
			const inputTags1 = $("tbody select");
			inputTags1.each(function() {
				$(this).val("");
				$(this).prop('disabled', false);
			});
			$(".cyear").prop('disabled', true);
			var yearNum = $("#inputYear").val(); //입력한년도
			var year = yearNum.toString();
			
			$(".cyear").val(year); //입력가능

			$(".econtent").prop('disabled', false);
			$(".ccd").prop('disabled', true);
			$("#instrNo").prop('disabled', true);
			$(".econtent").val("");
			$(".econtent").prop('placeholder', '내용을 입력해주세요.');

			//과정명선택시 - 훈련코드 가져오기 + 훈련과정명 이름 넣기
			$(".crclmNameList").on("change", function() {
				var ccd1 = $(this).val();
				var name1 = $(".crclmNameList option:selected").text();
				$(".ccd").val(ccd1);
				$(".crclmNameSet").val(name1);
			});
				
			
			//시작일 종료일 (date)
			$(".bgYMD").attr('min',year+'-01-01');	
			//$(".bgYMD").attr('max',year+'-12-31');	
			$(".bgYMD").on("blur", function() {
				var  begin = $(".bgYMD").val();
				$(".endYMD").attr('min',begin);	
				if(begin.length > 10){
					alert("잘못된 날짜 형식입니다.");
			    	$(".bgYMD").val("");
				}
			});
				
			$(".endYMD").on("blur", function() {
				var  begin = $(".bgYMD").val();
				var  end = $(".endYMD").val();
			
			  	if (end < begin) {
			    	alert("종료일이 시작일보다 이전입니다.");
			    	$(".endYMD").val("");
			    
				  }
			  	if(end.length > 10){
					alert("잘못된 날짜 형식입니다.");
			    	$(".endYMD").val("");
				}
			 });
			
			
			
			//대표강사 선택
				// -- 교육과정 모달창 검색값 가져가기
				 $("#btnInstrSearch").off().click(function(){
					var iname = $(".instrname").val();
					if(iname != ""){
						$("#dep_Search_text").val(iname);
						$('#depShow').click();
						$("#instrModal").modal("show");
						
					} else {
						$("#instrModal").modal("show");
					}
						
					
				});
				
				//모달 띄울때 그리드 새로고침
				$('#instrModal').on('shown.bs.modal', function(e) {
					grid2.refreshLayout();
				})
				
				//교육과정 검색
					$(document).on("click",'#depShow', function(){
						$("#depChoose").attr("disabled", false);
						var instrSearchName = $("#dep_Search_text").val();
						//alert(instrSearchName);
						
						$.post({
							url : "/instrSearchM",
							data:{
								"iname" : instrSearchName
							},
							cache : false,
							dataType : "json"
						}).done(function(data){
							grid2.refreshLayout();
							var result2 = data.list2;
							grid2.resetData(result2);
							let selectedRowKey = null;
							grid2.on('focusChange', (ev) => {
								  grid2.setSelectionRange({
								    start: [ev.rowKey, 0],
								    end: [ev.rowKey, grid2.getColumns().length]
								  });						
							});
							grid2.on('click', () => {
								const rowKey = grid2.getFocusedCell().rowKey;
								var obj = grid2.getRow(rowKey);
								var keys = Object.values(obj);
								var inNo = keys[0];
								var inName = keys[1];
								
								$("#depChoose").off().on("click",function(){
									//alert(keys);
									//여기
									$("#instrNo").val(inNo);
									$(".instrname").val(inName);
									$("#instrModal").modal("hide");

								});
							});
							
						}).fail(function() {
							alert("문제가 발생했습니다.");
						});
			
					});// 모달 
					
					
					
				//화면 끌 경우 초기화
				$('#instrModal').on('hidden.bs.modal', function(e) {
				    	$("#dep_Search_text").val('');
						$("#depChoose").attr("disabled", true);
						$("#searchGrid").find('td').empty();
						grid2.off('click');
				});

			var Grid = tui.Grid;
				
				Grid.applyTheme('clean', { 
					  row: { 
						    hover: { 
						      background: '#e9ecef' 
						    }
						  }
						});
				
			
				
				var grid2 = new tui.Grid({
				      el: document.getElementById('searchGrid'),
				      bodyHeight: 350,
				      scrollX: true,
				      scrollY: true,
				      contextMenu: null,
				      rowHeaders: ['checkbox'],
				      columns: [
				        {
				          header: '강사코드',
				          name: 'INSTR_NO',
				          width:200,
				          align:'center'
				        },
				        {
				          header: '강사명',
				          name: 'KORN_FLNM',
				          width:350,
				          align:'center'
				        },
				        
						],
					selectionUnit: 'row'
					
					});
					
			//});
			

		});//신규버튼

	//--- 그리드 클릭시
		grid.on("click",function(ev){
			//사용자 입력칸 입력가능
			const inputTags = $("tbody input");
			inputTags.each(function() {
				$(this).prop('disabled', false);
			});
			const inputTags1 = $("tbody select");
			inputTags1.each(function() {
				$(this).prop('disabled', false);
			});

			$(".econtent").prop('disabled', false);
			$(".ccd").prop('disabled', true);
			$(".cyear").prop('disabled', true);
			$("#instrNo").prop('disabled', true);

			
			
			const rowKey = grid.getFocusedCell().rowKey
			var obj = grid.getRow(rowKey);
			var ccd = obj.CRCLM_CD;
			var cyear = obj.CRCLM_YEAR;
			var chalf = obj.CRCLM_HALF;
			var crclmname = obj.CRCLM_NM;
			var bgYMD1 = obj.EDU_BGNG_YMD;
			var endYMD1 = obj.EDU_END_YMD;
			var instrname = obj.KORN_FLNM;
			var epeople = obj.EDU_NOPE;
			var schedule = obj.CRCLM_SCHDL_CD;
			var efnYN = obj.EDU_FNSH_YN;
			var instrno = obj.RPRS_INSTR_NO;
			var ecost = obj.EDU_COST;
			var econtent = obj.EDU_CN;
			var crclmNo = obj.CRCLM_NO;
			
			 if(crclmNo != null){
				//날짜 포맷 (YYYY-MM-DD 형태)
				var bgYMD = bgYMD1.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");
				var endYMD = endYMD1.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");

			$(".cno").val(crclmNo);
			$(".cyear").val(cyear);
			$(".chalf").val(chalf);
			$(".ccd").val(ccd);
			$(".crclmNameList").val(ccd);
			$(".crclmNameSet").val(crclmname);
			$(".bgYMD").val(bgYMD);
			$(".endYMD").val(endYMD);
			$(".ecost").val(ecost+"원");
			$(".econtent").val(econtent);
			$(".instrname").val(instrname);
			$(".schedule").val(schedule);
			$(".efnYN").val(efnYN);
			$(".epeople").val(epeople+"명");
			$("#instrNo").val(instrno);
			} else{
				var cyear = $("#inputYear").val();
				$(".cno").val('');
				$(".cyear").val(cyear);
				$(".chalf").val('');
				$(".ccd").val('');
				$(".crclmNameList").val('');
				$(".crclmNameSet").val('');
				$(".bgYMD").val('');
				$(".endYMD").val('');
				$(".ecost").val('');
				$(".econtent").val('');
				$(".instrname").val('');
				$(".schedule").val('');
				$(".efnYN").val('');
				$(".epeople").val('');
				$("#instrNo").val('');
				
			}
			
			 
			 
			 
		//---훈련과정정보 인풋---
			$(".bgYMD").on("blur", function() {
				var  begin = $(".bgYMD").val();
				$(".endYMD").attr('min',begin);	
				if(begin.length > 10){
					alert("잘못된 날짜 형식입니다.");
			    	$(".bgYMD").val("");
				}
			}); 
				
			$(".endYMD").on("blur", function() {
				var  begin = $(".bgYMD").val();
				var  end = $(".endYMD").val();
			
			  	if (end < begin) {
			    	alert("종료일이 시작일보다 이전입니다.");
			    	$(".endYMD").val("");
			    
				  }
			  	if(end.length > 10){
					alert("잘못된 날짜 형식입니다.");
			    	$(".endYMD").val("");
				}
			 }); 
			

			 //대표강사 선택
				// -- 교육과정 모달창 검색값 가져가기
				 $("#btnInstrSearch").off().click(function(){
					var iname = $(".instrname").val();
					if(iname != ""){
						$("#dep_Search_text").val(iname);
						$('#depShow').click();
						$("#instrModal").modal("show");
						
					} else {
						$("#instrModal").modal("show");
					}
						
					
				});
				
				//모달 띄울때 그리드 새로고침
				$('#instrModal').on('shown.bs.modal', function(e) {
					grid3.refreshLayout();
					
				})
				
				//대표강사 검색
					$(document).on("click",'#depShow', function(){
						$("#depChoose").attr("disabled", false);
						var instrSearchName = $("#dep_Search_text").val();
						//alert(instrSearchName);
						
						$.post({
							url : "/instrSearchM",
							data:{
								"iname" : instrSearchName
							},
							cache : false,
							dataType : "json"
						}).done(function(data){
							grid3.refreshLayout();
							var result3 = data.list2;
							grid3.resetData(result3);
							let selectedRowKey = null;
							grid3.on('focusChange', (ev) => {
								  grid3.setSelectionRange({
								    start: [ev.rowKey, 0],
								    end: [ev.rowKey, grid3.getColumns().length]
								  });						
							});
							grid3.on('click', () => {
								const rowKey = grid3.getFocusedCell().rowKey;
								var obj = grid3.getRow(rowKey);
								
								var inNo = obj.INSTR_NO;
								var inName = obj.KORN_FLNM;
								
								$("#depChoose").off().on("click",function(){
									//alert(keys);
									//여기
									$("#instrNo").val(inNo);
									$(".instrname").val(inName);
									$("#instrModal").modal("hide");

								});
							});
							
						}).fail(function() {
							alert("문제가 발생했습니다.");
						});
			
					});// 모달 
					
					
					
				//화면 끌 경우 초기화
				$('#instrModal').on('hidden.bs.modal', function(e) {
				    	$("#dep_Search_text").val('');
						$("#depChoose").attr("disabled", true);
						$("#searchGrid").empty();
						grid3.off('click');
				});

				
				
				
				var Grid = tui.Grid;
				Grid.applyTheme('clean', { 
					  row: { 
						    hover: { 
						      background: '#e9ecef' 
						    }
						  }
						});
				
				var grid3 = new tui.Grid({
				      el: document.getElementById('searchGrid'),
				      bodyHeight: 350,
				      scrollX: true,
				      scrollY: true,
				      contextMenu: null,
				      rowHeaders: ['checkbox'],
				      columns: [
				        {
				          header: '강사코드',
				          name: 'INSTR_NO',
				          width:200,
				          align:'center'
				        },
				        {
				          header: '강사명',
				          name: 'KORN_FLNM',
				          width:350,
				          align:'center'
				        },
				        
						],
					selectionUnit: 'row'
					
					});
		
			
				//과정일정설정 클릭시
				$("#nav-schedule-tab").click(function() {
					//$("#SsveBtn").hide(); 저장 버튼 비활성화
					grid5.refreshLayout();
				});
					$("#scheduleGrid").empty();
				
		
		//과정일정 설정 
		const datePicker = tui.DatePicker; 
		
		var Grid = tui.Grid;
				Grid.applyTheme('clean', { 
					  row: { 
						    hover: { 
						      background: '#e9ecef' 
						    }
						  }
						});
			var grid5 = new Grid({
			      el: document.getElementById('scheduleGrid'),
			      bodyHeight: 250,
			      scrollX: true,
			      scrollY: true,
			      contextMenu: null,
			      columns: [
				        {
				          header: '일정명',
				          name: 'CRCLM_SCHDL_CD',
				          width:300,
				          align:'center'
				        },
				        {
				          header: '시작일',
				          name: 'SCHDL_BGNG_DT',
				          width:400,
				          align:'center',
				          editor: {
				              type: 'datePicker',
				              options: {
				            	  format: 'yyyy-MM-dd HH:mm',
				                  timepicker: true
				              }
				            }
				        },
				        {
				          header: '종료일',
				          name: 'SCHDL_END_DT',
				          width:400,
				          align:'center',
				          editor: {
				              type: 'datePicker',
				              options: {
				            	  format: 'yyyy-MM-dd HH:mm',
				                  timepicker: true
				              }
				            }
				        },
				        
				        {
				          header: '일정설명',
				          name: 'SCHDL_EXPLN',
				          width:300,
				          align:'center',
				          editor:'text'
				         
				        },
				        
				        {
				          header: '종료여부',
				          name: 'SCHDL_FIN',
				          width:150,
				          align:'center',
				          editor: {
				              type: 'radio',
				              options: {
				                listItems: [
				                  { text: 'Y', value: 'Y' },
				                  { text: 'N', value: 'N' },
				                ]
								}
				       		 }
				        }
					],
				
				});
		
	 	$.post({
			url :"/crclmSchdl",
			cache : false,
			data: JSON.stringify({
				"ccd" : ccd,
				"chalf" : chalf,
				"cyear" : cyear

			}),
			dataType : "json",
			contentType: 'application/json'
		 }).done(function(data) {
			 grid5.resetData(data.sList);
			//$("#buttonGroup").show();
			//alert(data.sList);
			
			
		}).fail(function(xhr, status, errorThrown) {
			alert("문제가 발생했습니다.");
		}); 
		
		
			
		//과정일정설정 - 저장버튼
		$("#SsaveBtn").off("click").on("click",function () {
			//var ccd = obj.CRCLM_CD;
			//var cyear = obj.CRCLM_YEAR;
			//var chalf = obj.CRCLM_HALF;
			
			
			var modifiedRows = grid5.getModifiedRows(); //추가/수정/삭제된 값 

			// 배열로 변환
			if (!Array.isArray(modifiedRows)) {
			  modifiedRows = [modifiedRows];
			}
			
			  // __modified__ 속성 제거 후 반환
			  var data = modifiedRows.map(function(row) {
			    delete row['__modified__'];
			    return row;
			  }); 
			
			 // console.log(JSON.stringify(data)); //ok
			var updatedRows = modifiedRows[0].updatedRows;
			
			//console.log(updatedRows.length);
			//console.log(updatedRows[0].CRCLM_SCHDL_CD);
			//var updatedRows = modifiedRows[].updatedRows;
			  var updateRow1 = [];
			for (let i = 0; i < updatedRows.length; i++) {
				//const UR = updatedRows[i];
				 updateRow1.push({
						 "schdlCode": updatedRows[i].CRCLM_SCHDL_CD,
						    "schdlBegin": updatedRows[i].SCHDL_BGNG_DT,
						    "schdlEnd": updatedRows[i].SCHDL_END_DT,
						    "schdlEx": updatedRows[i].SCHDL_EXPLN,
						    "schdlFin": updatedRows[i].SCHDL_FIN,	
						    "ccd": ccd,
						    "cyear": cyear,
						    "chalf": chalf
				});
			}//for 끝
			console.log(updatedRows[0].SCHDL_BGNG_DT);
				// updateRow1.push({"ccd":ccd, "cyear":cyear,"chalf":chalf});
			
			$.post({
				url :"/updateSchedule",
				cache : false,
				data: JSON.stringify(updateRow1 ),
				dataType : "json",
				contentType: 'application/json'
			 }).done(function(data) {
				alert("저장성공");
				 // grid5.resetData(data.sList);
				//$("#buttonGroup").show();
				//alert(data.sList);
			}).fail(function() {
				alert("문제가 발생했습니다.");
				
			});  
			  
		});//저장버튼 끝
		
		
		//상단 - 삭제버튼
		$("#deleteBtn").click(function(){
			
		if (confirm("해당 과정을 삭제하시겠습니까?")) {
			var yearNum = $("#inputYear").val(); //입력한년도
			var year = yearNum.toString();
			
			$.post({
				url :"/deleteCrclmAjax",
				cache : false,
				data: JSON.stringify({
					"crclmNo":crclmNo,
					"cyear":cyear,
					"chalf":chalf,
					"ccd":ccd,
					"year":year
				}),
				dataType : "json",
				contentType: 'application/json'
			 }).done(function(data) {
				if(data.delOK == 0){
				 alert("삭제되었습니다.");
				 grid.resetData(data.delAfter);
				
				 // grid5.resetData(data.sList);
				//$("#buttonGroup").show();
				//alert(data.sList);
				} else{
					alert("삭제할 수 없는 과정입니다.");
				}
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
				
		});
			}
		});//삭제버튼
			
	}); //grid click
		
	
	
		//상단 - 저장버튼 
		$("#saveBtn").click(
				function() {
					const rowKey = grid.getFocusedCell().rowKey
					var cno = $(".cno").val();
					var cyear = $(".cyear").val();
					var chalf = $(".chalf").val();
					var ecost1 = $(".ecost").val();
					var ecost = ecost1.replace("원", "");
					var econtent = $(".econtent").val();
					var instrname = $(".instrname").val();
					var schedule = $(".schedule").val();
					var efnYN = $(".efnYN").val();
					var epeople= $(".epeople").val();
					var epeople1 = epeople.split("명");
					var epeopleUpdate = epeople1[0]; //명 제거
					var ccd = $(".ccd").val();
					var crname = $(".crclmNameList option:selected").text();
					var crnameset = $(".crclmNameSet").val()
					//상단
					var yearNum = $("#inputYear").val(); //입력한년도
					var year = yearNum.toString();
					var selectval = $('select[name=crclm_half]').val(); //상/하반기 선택
					var radioval = $('input:radio[name=radioStatus]:checked').val(); //과정현황 선택
					var crclmname = $("#inputCrclmSearch").val();
					var insname = $("#inputInstrSearch").val();

					//날짜 포맷
					const bgval = $(".bgYMD").val(); // (YYYY-MM-DD 형태)
					const endval = $(".endYMD").val(); 

					const dateArray1 = bgval.split("-"); // "-"를 기준으로 분리
					const dateArray2 = endval.split("-"); // "-"를 기준으로 분리
					const year1 = dateArray1[0]; // 년도
					const month1 = dateArray1[1]; // 월
					const day1 = dateArray1[2]; // 일
					const year2 = dateArray2[0]; // 년도
					const month2 = dateArray2[1]; // 월
					const day2 = dateArray2[2]; // 일

					// (YYYYMMDD 형태)
					const bgYMD = year1 + month1 + day1;
					const endYMD = year2 + month2 + day2;
 
					// 필수항목 미입력시 제한
					if (cyear == '' || crname == '선택' || chalf == '선택'
							|| instrname == '' || bgYMD == '' || endYMD == ''
							|| epeople == '' || ecost == '' || schedule == '선택'
							|| efnYN == '선택' || econtent == '') {

						alert("모든 항목을 입력해주세요.");
						return false;
					}
					if (cyear.length < 4) {
						alert('학년도는 4글자 입니다.');
						return false;
					}

					if (bgYMD.length < 8 || endYMD.length < 8) {
						alert('시작일과 종료일은 8글자 입니다.');
						return false;
					}
					
					var instrNo= $("#instrNo").val();
					if(instrNo==''){
						alert('강사명은 검색 후 선택하셔야합니다.');
						return false;
					}
					
				
					if (cno == "") {
						$.post({
							url : "/newCrclmAjax",
							cache : false,
							data: JSON.stringify({
								"year":year,
								"cyear" : cyear,
								"bgYMD" : bgYMD,
								"chalf" : chalf,
								"endYMD" : endYMD,
								"ecost" : ecost,
								"econtent" : econtent,
								"instrName" : instrNo,
								"schedule" : schedule,
								"efnYN" : efnYN,
								"epeople" : epeople,
								"ccd" : ccd,
								"crName" : crnameset
							}),
							contentType: 'application/json',
							dataType : "json"
						}).done(function(data) {
							//alert(data.ck);
							if (data.ck == "dup") {
								alert("이미 존재하는 교육훈련과정 입니다.")
								return false;
							} else {
								if(data.saveResult==1){
								alert("저장이 완료되었습니다.");
								grid.resetData(data.saveAfter);
								grid.focus(rowKey);
								}
							}

						}).fail(function(xhr, status, errorThrown) {
							alert("문제가 발생했습니다.");
						});

					}//if
					else {
						$.post({
							url : "/saveCrclmAjax",
							cache : false,
							data: JSON.stringify({
								"cno" : cno,
								"cyear" : cyear,
								"bgYMD" : bgYMD,
								"chalf" : chalf,
								"endYMD" : endYMD,
								"ecost" : ecost,
								"econtent" : econtent,
								"instrName" : instrNo,
								"schedule" : schedule,
								"efnYN" : efnYN,
								"epeople" : epeopleUpdate,
								"year" : year,
								"half" : selectval,
								"radioval" : radioval,
								"crclmName" : crclmname,
								"insName" : insname,
								"crName" : crnameset
							}),
							dataType : "json",
							contentType: 'application/json'
						}).done(function(data) {
							alert("수정이 완료되었습니다.");
							grid.resetData(data.updateAfter);
							grid.focus(rowKey);

						}).fail(function(xhr, status, errorThrown) {
							alert("문제가 발생했습니다.");
						});

					}//else

				});//저장버튼
				
				
	
			

	});//func
</script>
</head>
<body class="sb-nav-fixed">
	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<div class="mt-4 position-relative row">
						<div style="width:25px;">
						<img src="./image/joongang_logo.png" style="width:25px;">
						</div>
						<div style="width:300px; height:25x;  "> 
							<h5 style="font-weight: bold; color:#565757; line-height:25px;">교육훈련과정 정보관리</h5>
						</div>
					</div>
				<hr style="height: 4px;" class="m-0 mb-1">
				<div style="width: 100%; position: relative;">
					<div style="position: absolute; right: 0">
						<button class="btn btn-secondary  btn-sm" id="listBtn">조회</button>
						<button class="btn btn-secondary btn-sm" id="newBtn"
							disabled="disabled">신규</button>
						<button class="btn btn-secondary btn-sm" id="deleteBtn"
							disabled="disabled"	>삭제</button>
						<button class="btn btn-secondary btn-sm" id="saveBtn"
							disabled="disabled">저장</button>
					</div>
				</div>
				<br> <br>

				<div
					style="width: 100%;  height: 80px; border: 1px solid #c0c0c0; position: relative;">
					<div
						style="position: absolute; width: 100%; top: 50%; transform: translateY(-50%)"
						class="d-flex justify-content-center">
						<div class="input-group fw-bolder  "
							style="width: calc(20%); float: left;">
							학년도 <input type="number" class="form-control form-control-sm"
								style="margin-left: 10px;" value="2023" id="inputYear"
								numberOnly> <select class="form-select form-select-sm"
								name="crclm_half">
								<option value="">상/하반기</option>
								<option value="0010">상반기</option>
								<option value="0020">하반기</option>
							</select>
						</div>
						<div class="input-group "
							style="width: calc(25%); margin-left: 10px; float: left;">
							<input class="form-control form-control-sm" "type="text"
								placeholder="과정명" id="inputCrclmSearch" />
						</div>
						<div class="input-group fw-bolder "
							style="width: calc(40%); margin-left: 10px; float: left;">
							과정현황
							<div class="form-check form-check-inline"
								style="margin-left: 5px;">
								<input class="form-check-input fw-bolder" type="radio"
									name="radioStatus" checked="checked" value="">전체
							</div>
							<c:forEach items="${scheduleName }" var="SN">
								<div class="form-check form-check-inline"">
									<input class="form-check-input fw-bolder" type="radio"
										name="radioStatus" value="${SN.CD }">${SN.CD_NM }
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 상단 끝 -->
				<div>
				<div class="position-relative mt-2" style="display: flex;">
						<div class="float-start "
							style="width: 10px; height: 29px;  margin-right: 10px;"></div>
						<h6 class="mt-1 fw-bolder">교육훈련과정</h6>
						<div class="position-relative"
							style="display: flex; width: 150px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 30px; margin: 0 10px;">
							<div id="searchCount"
								style="width: 15px; height: 27px; font-size: 13px; color: #a3a3a7; line-height: 27px;">
								0</div>
							건이 조회되었습니다.
						</div>
					</div>
					<div id="grid"></div>
				</div>

				<div class="mt-3">
					<!--탭설정 -->
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<button class="nav-link active" id="nav-home-tab"
								data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
								role="tab" aria-controls="nav-home" aria-selected="true">훈련과정정보</button>
							<button class="nav-link" id="nav-schedule-tab"
								data-bs-toggle="tab" data-bs-target="#nav-schedule"
								type="button" role="tab" aria-controls="nav-schedule"
								aria-selected="false">과정일정설정</button>
						</div>
					</nav>
					<div class="tab-content" id="nav-tabContent">
						<!--훈련과정정보  -->
						<div class="tab-pane fade show active" id="nav-home"
							role="tabpanel" aria-labelledby="nav-home-tab">
							<div class="mb-5 inputTotal"
								style="width: 100%;  height: 430px; border: 1px solid #c0c0c0; position: relative;">

								<table
									style="width: 90%; position: absolute; top: 50%; transform: translateY(-50%) translateX(5%);">
									<tr style="height: 50px">
										<td class="col-1" style="text-align: right;">학년도</td>
										<td class="col-1" colspan="2"><input type="number"
											numberOnly class="form-control form-control-sm cyear"
											disabled="disabled"></td>
										<td class="col-1" style="text-align: right;">훈련과정코드</td>
										<td class="col-4" colspan="2"><input type="hidden"
											class="cno">
											<div class="input-group"
												style="display: flex; flex-wrap: wrap;">
												<input type="text" class="form-control form-control-sm ccd"
													style="width: calc(20%);" aria-describedby="sel" readonly
													disabled="disabled"> <select
													class="form-select form-select-sm crclmNameList"
													disabled="disabled" id="sel" style="width: calc(80%);">
													<option value="">선택</option>
													<c:forEach items="${crclmName}" var="cn">
														<option value="${cn.CD}">${cn.CD_NM}</option>
													</c:forEach>
												</select>
											</div></td>
										<td class="col-1" style="text-align: right;">훈련과정명</td>
										<td class="col-4" colspan="5"><input type="text"
											class="form-control form-control-sm  crclmNameSet "
											disabled="disabled"></td>
									</tr>
									<tr style="height: 50px">
										<td style="text-align: right;">상/하반기</td>
										<td colspan="2"><select
											class="form-select form-select-sm chalf" disabled="disabled">
												<option value="">선택</option>
												<option value="0010">상반기</option>
												<option value="0020">하반기</option>
										</select></td>

										<td style="text-align: right;">대표강사명</td>
										<td colspan="2">
											<div class="input-group "
												style="display: flex; flex-wrap: wrap;">
												<input type="text" class="form-control form-control-sm "
													style="width: calc(30%);" id="instrNo"
													aria-describedby="sel" readonly disabled="disabled">
												<input class="form-control form-control-sm instrname"
													type="text" placeholder="강사명" style="width: calc(55%)"
													disabled="disabled" />
												<button class="btn btn-secondary btn-sm" type="button"
													id="btnInstrSearch" style="width: calc(15%);">
													<i class="fas fa-search"></i>
												</button>
											</div>
										<td style="text-align: right;">시작일</td>
										<td colspan="2"><input type="date"
											class="form-control form-control-sm bgYMD"
											disabled="disabled"></td>
										<td style="text-align: right;">종료일</td>
										<td colspan="2"><input type="date"
											class="form-control form-control-sm endYMD"
											disabled="disabled"></td>

									</tr>
									<tr style="height: 50px">
										<td style="text-align: right;">모집인원</td>
										<td colspan="2"><input type="text" numberOnly
											class="form-control form-control-sm epeople"
											disabled="disabled"></td>
										<td style="text-align: right;">훈련비용</td>
										<td colspan="2"><input type="text" numberOnly
											class="form-control form-control-sm ecost"
											disabled="disabled"></td>


										<td style="text-align: right;">과정현황</td>
										<td colspan="2"><select
											class="form-select form-select-sm schedule"
											disabled="disabled">
												<option value="">선택</option>
												<option value="0010">모집</option>
												<option value="0020">훈련</option>
												<option value="0030">수료</option>
										</select></td>
										<td style="text-align: right;">종료여부</td>
										<td colspan="2"><select
											class="form-select form-select-sm efnYN" disabled="disabled">
												<option value="">선택</option>
												<option value="N">N</option>
												<option value="Y">Y</option>
										</select></td>
									</tr>

									<tr>
										<td style="text-align: right;">훈련내용</td>
									</tr>
									<tr>
										<td></td>
										<td colspan="11"><textarea class="form-control econtent"
												style="height: 200px; resize: none;" disabled="disabled"></textarea></td>
									</tr>

								</table>
							</div>
						</div>
						<!--과정일정설정  -->
						<div class="tab-pane fade" id="nav-schedule" role="tabpanel"
							aria-labelledby="nav-schedule-tab">

							<div class="d-flex justify-content-end mt-2 mb-2 "
								id="buttonGroup">
								<button class="btn btn-secondary btn-sm" id="SsaveBtn">
									저장</button>
								<!-- disabled="disabled" -->
							</div>
							<div id="scheduleGrid"></div>

						</div>


					</div>




				</div>


			</div>

			<%@ include file="./crclmInstrModal.jsp"%>
	</div>
	</main>
	</div>
	<%@include file="../bar/footer.jsp"%>
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