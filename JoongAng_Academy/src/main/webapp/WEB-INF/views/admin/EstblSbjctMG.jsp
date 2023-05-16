<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(document).ready(function() {
		
		$.fn.changetag = function(str){
			var result = "";
			result = str.replace('<',"&lt");
			result = result.replace(">","&gt");
			return result;
		}
		
		//수강신청이 시작했는지 체크하는 함수
		var clsBgngChecker = 0;
		$.fn.clsBgngCheck = function(crc,year,hlf){
			
			$.post({
				url : "/estClsBgngCheck",
				data : {
					crc : crc,
					year : year,
					hlf : hlf					
				},
				dataType : "json"
			}).done(function(data) {
				if(data.result==1){
					
					clsBgngChecker = 1;
				}else{
					clsBgngChecker = 0;
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
				clsBgngChecker = -1;
			});
		}		
		
// 		main grid
		var Grid = tui.Grid;
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				});
		var grid = new tui.Grid({
			el : document.getElementById("grid"),
			scrollX : true,
			scrollY : true,
			bodyHeight : 200,
			options : {
				autoWidth: true
			},
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "연도",
				name : 'CRCLM_YEAR',
				sortable : true,
				width : 50,
				align : 'center'
			}, 
			{
				header : "반기코드",
				name : 'CRCLM_HALF',
				hidden : true
			}, 
			{
				header : "반기",
				name : 'HALF',
				width : 50,
				align : 'center'
			}, 
			{
				header : "교육과정코드",
				name : 'CRCLM_CD',
				hidden : true
			},
			{
				header : "교육과정",
				name : 'CRCLM_NM',
				width : 400,
				align : 'center'
			}, {
				header : "과목번호",
				name : 'SBJCT_NO',
				align : 'center',
				width : 50,
				sortable : true
			},{
				header : "과목명",
				name : 'REAL_SBJCT_NO',
				hidden : true
			}, {
				header : "개설과목명",
				name : 'SBJCT_NM',
				width : 150
			}, {
				header : "과목설명",
				name : 'SBJCT_EXPLN',
				width : 150
			}, {
				header : "총강의시간",
				name : 'EDU_HR',
				align : 'center',
				width : 70
			}, {
				header : "강의계획서",
				name : 'SBJCT_PLAN_YN',
				align : 'center',
				width : 70
			},
			{
				header : "강의실",
				name : 'ROOM_NO',
				sortable : true,
				align : 'center',
				width : 50
			}, 
			{
				header : "강의시수",
				name : 'EDU_WEEK_HR',
				sortable : true,
				align : 'center',
				width : 50
			}, 
			{
				header : "필수",
				name : 'ESNTL_YN',
				align : 'center',
				width : 50
			} ],
			selectionUnit: 'row'
			,
		    columnOptions: {
		        minWidth: 100
		    },
		    autoWidth : true
		});
		
// 		교육과정목록생성
		$.post({
			url : "/estCrclmList",
			dataType : "json"
		}).done(function(data) {
			var code, name, optionHTML;
			$.each(data.estCrcList, function(index, element) {
				code = element.CD;
				name = element.CD_NM;
				optionHTML = "<option value="+code+">" + name + "</option>";
				$("#crclmSelect").append(optionHTML);
				$("#c").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
// 		강의실목록생성
		$.post({
			url : "/estRoomList",
			dataType : "json"
		}).done(function(data) {
			$.each(data.estRoomList, function(index, element) {
				room = element.ROOM_NO;
				optionHTML = "<option value="+room+">" + room + "</option>";
				$("#i").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
// 		훈련과정을 선택하면 그 훈련 과정이 개설되어있는 연도를 모두 불러와서 select박스에 option으로 붙임
		$("#crclmSelect").change(function() {
			var crc = $("#crclmSelect").val();
			$.post({
				url : "/estYearList",
				data : {
					crc : crc
				},
				dataType : "json"
			}).done(function(data) {
				var year, optionHTML;
				if(data.estYearList.length==0){
					optionHTML = "<option value=''>" + "연도선택" + "</option>";
				}else{
					optionHTML = "<option value=''>" + "연도선택" + "</option>";
					$.each(data.estYearList, function(index, element) {
					year = element.CRCLM_YEAR;
					optionHTML += "<option value="+year+">" + year + "</option>";
					});
				}
				$("#yearSelect").html(optionHTML);
				$("#a").html(optionHTML);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		상동
		$("#c").change(function() {
			var crc = $("#c").val();
			$.post({
				url : "/estYearList",
				data : {
					crc : crc
				},
				dataType : "json"
			}).done(function(data) {
				var year, optionHTML;
				if(data.estYearList.length==0){
					optionHTML = "<option value=''>" + "연도선택" + "</option>";
				}else{
					optionHTML = "<option value=''>" + "연도선택" + "</option>";
					$.each(data.estYearList, function(index, element) {
					year = element.CRCLM_YEAR;
					optionHTML += "<option value="+year+">" + year + "</option>";
					});
				}
				$("#a").html(optionHTML);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});

// 		상동
		$("#a").change(function() {
			var crc = $("#c").val();
			var year = $("#a").val();
			$.post({
				url : "/estHalfList",
				data : {
					crc : crc,
					year : year
				},
				dataType : "json"
			}).done(function(data) {
				var year, optionHTML;
				if(data.estHalfList.length==0){
					optionHTML = "<option value=''>" + "반기선택" + "</option>";
				}else{
					optionHTML = "<option value=''>" + "반기선택" + "</option>";
					$.each(data.estHalfList, function(index, element) {
					halfcd = element.CRCLM_HALF;
					half = element.HALF;
					optionHTML += "<option value="+halfcd+">" + half + "</option>";
					});
				}
				$("#b").html(optionHTML);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		반기선택
		$("#halfSelect").append("<option value='0010'>상반기</option>");
		$("#halfSelect").append("<option value='0020'>하반기</option>");
		$("#b").append("<option value='0010'>상반기</option>");
		$("#b").append("<option value='0020'>하반기</option>");
		
// 		조회버튼을 클릭
		$("#searchBtn").click(function() {
			$.fn.Search();
		});

//		조회함수
		$.fn.Search = function(){
			var crc = $("#crclmSelect").val();
			var year = $("#yearSelect").val();
			var hlf = $("#halfSelect").val();
			if (crc == "") {
				alert("교육과정을 선택해주세요");
				return false;
			} else {
				$.post({
					url : "/estListAjax",
					data : {
						crc : crc,
						year : year,
						hlf : hlf
					},
					dataType : "json"
				}).done(function(data) {
					grid.resetData(data.estList);
					grid.on('focusChange', (ev) => {
						  grid.setSelectionRange({
						    start: [ev.rowKey, 0],
						    end: [ev.rowKey, grid.getColumns().length]
						  });
						  $.fn.gridClicker(ev);
					});
					$("#a").attr("disabled",true);
					$("#b").attr("disabled",true);
					$("#c").attr("disabled",true);
					$("#d").attr("disabled",true);
					$("#g").attr("disabled",true);
					$("#h").attr("disabled",true);
					$("#insertBtn").attr("disabled",false);
					grid.on('click', function(ev){
						$.fn.gridClicker(ev);
					});
					$("#a").val("");
					
					$("#b").html("<option value=''>반기선택</option>");
					$("#b").append("<option value='0010'>상반기</option>");
					$("#b").append("<option value='0020'>하반기</option>");
					$("#b").val("");
					$("#c").val("");
					$("#d").val("");
					$("#d").text("과목번호");
					$("#e").val("");
					$("#f").val("");
					$("#g").val("");
					$("#h").val("");
					$("#i").val("");
					$("#m").val("");
					$("#z").val("");
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
		};
		
// 		메인 그리드 내의 데이터를 클릭하면 작동하는 함수 
		$.fn.gridClicker = function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				var crc = grid.getValue(ev.rowKey,"CRCLM_CD");
				var year = grid.getValue(ev.rowKey,"CRCLM_YEAR");
				var hlf = grid.getValue(ev.rowKey,"CRCLM_HALF");
				$("#a").val(grid.getValue(ev.rowKey,"CRCLM_YEAR"));
				$("#b").val(grid.getValue(ev.rowKey,"CRCLM_HALF"));
				$("#c").val(grid.getValue(ev.rowKey,"CRCLM_CD"));
				$("#d").val(grid.getValue(ev.rowKey,"SBJCT_NO"));
				$("#d").text(grid.getValue(ev.rowKey,"SBJCT_NO"));
				$("#e").val(grid.getValue(ev.rowKey,"SBJCT_NM"));
				$("#z").val(grid.getValue(ev.rowKey,"REAL_SBJCT_NM"));
				$("#f").val(grid.getValue(ev.rowKey,"SBJCT_EXPLN"));
				$("#g").val(grid.getValue(ev.rowKey,"EDU_HR"));
				var h = grid.getValue(ev.rowKey,"SBJCT_PLAN_YN");
				$("#h").val(grid.getValue(ev.rowKey,"EDU_WEEK_HR"));
				var o = grid.getValue(ev.rowKey,"ESNTL_YN");
				if(o=='Y') {
					$("#o").prop("checked",true);
				}
				if(o=='N') {
					$("#o").prop("checked",false);
				}
				
				$("#i").val(grid.getValue(ev.rowKey,"ROOM_NO"));
				$.fn.clsBgngCheck(crc,year,hlf);
				if(clsBgngChecker == 1){
					$("#o").attr("disabled",true);	
					$("#i").attr("disabled",true);
					$("#j").attr("disabled",true);
					$("#k").attr("disabled",true);
					$("#instructorSearchBtn").attr("disabled",true);
					$("#saveBtn").attr("disabled",true);		
				}else{
					$("#o").attr("disabled",false);
					$("#i").attr("disabled",false);
					$("#j").attr("disabled",false);
					$("#k").attr("disabled",false);
					$("#instructorSearchBtn").attr("disabled",false);
					$("#saveBtn").attr("disabled",false);	
				}
				
				$.post({
					url : "/estInstrAjax",
					data : {
						crc : grid.getValue(ev.rowKey,"CRCLM_CD"),
						year : grid.getValue(ev.rowKey,"CRCLM_YEAR"),
						hlf : grid.getValue(ev.rowKey,"CRCLM_HALF"),
						sbjno : grid.getValue(ev.rowKey,"SBJCT_NO")
					},
					dataType : "json"
				}).done(function(data) {
					$("#m").val(data.instr.KORN_FLNM);
					$("#n").val(data.instr.INSTR_NO);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
				
				$.post({
					url : "/estTimeTable",
					data : {
						crc : grid.getValue(ev.rowKey,"CRCLM_CD"),
						year : grid.getValue(ev.rowKey,"CRCLM_YEAR"),
						hlf : grid.getValue(ev.rowKey,"CRCLM_HALF"),
						room : grid.getValue(ev.rowKey,"ROOM_NO")
					},
					dataType : "json"
				}).done(function(data) {
					var cls = [];
					for(var i=0;i<8;i++){
						cls[i] = [0,0,0,0,0];	
					}
					var timeSaved;
					$.each(data.timeInfo,function(index,element){
						cls[parseInt(element.CLS_CD)-1][parseInt(element.LECT_DAY_CD)-1] = 1;
						if(element.SBJCT_NO==grid.getValue(ev.rowKey,"SBJCT_NO") && element.CRCLM_CD==grid.getValue(ev.rowKey,"CRCLM_CD")){
							cls[parseInt(element.CLS_CD)-1][parseInt(element.LECT_DAY_CD)-1] = 2;
							timeSaved = 1;
						}
					})
					var tableHTML = "";
					for(var j=0;j<8;j++){
						tableHTML += "<tr><td>"+ (j+1) +"교시</td>"
						for(var k=0;k<5;k++){
							if(cls[j][k]==2){
								tableHTML += "<td><input type='checkbox' checked disabled></td>";
							}
							else if(cls[j][k]!=0){								
								tableHTML += "<td><input type='checkbox' disabled></td>";
							}
							else{
								tableHTML += "<td><input type='checkbox'></td>";
							}
						}
						tableHTML += "</tr>"
					}
					$("#timeTable tbody").html(tableHTML);
					if(timeSaved==1){
						$("#timeTable tr td input[type='checkbox']").prop("disabled",true);
						$("#i").attr("disabled",true);
						$("#instructorSearchBtn").attr("disabled",true);
						$("#timeButton").hide(0);
					}else{
						$("#timeButton").show(0);
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});

			}
		};
		
// 		메인 그리드 클릭시 함수 실행
		grid.on('click', function(ev){
			$.fn.gridClicker(ev);
		});
		
// 		신규 버튼 클릭 시 입력창이 모두 입력가능하게 바뀐다
		$("#insertBtn").click(function(){
			$("#insertBtn").attr("disabled",true);
			grid.off('click');
			grid.off('focusChange');
			$("#a").attr("disabled",false);
			$("#b").attr("disabled",false);
			$("#c").attr("disabled",false);
			$("#d").attr("disabled",false);				
			$("#subjectSearchBtn").attr("disabled",false);
			$("#saveBtn").attr("disabled",false);
			$("#instructorSearchBtn").attr("disabled",false);
			$("#g").attr("disabled",false);
			$("#i").attr("disabled",false);
			$("#o").attr("disabled",false);
			$("#a").val("");
			$("#b").val("");
			$("#c").val("");
			$("#d").val("");
			$("#d").text("과목번호");
			$("#e").val("");
			$("#f").val("");
			$("#g").val("");
			$("#h").val("");
			
			$("#o").attr("checked",false);
			$("#m").val("");
			$("#n").val("");
			$("#i").val("");
			$("#z").val("");
			
			$("#timeButton").hide(0);
		});
		
// 		저장 버튼 클릭 시 입력된 데이터를 DB에 저장하고 입력창을 다시 비활성화
		$("#saveBtn").click(function(){
			year = $("#a").val();
			hlf = $("#b").val();
			crc = $("#c").val();
			sbjcd = $("#d").val();
			sbjnm = $("#e").val();
			sbjnm = $.fn.changetag(sbjnm);
			sbjxp = $("#f").val();
			sbjxp = $.fn.changetag(sbjxp);
			hrs = $("#g").val();
			weekhrs = $("#h").val();
			room = $("#i").val();
			kornm = $("#m").val();
			insno = $("#n").val();
			if(year==''||hlf==''||crc==''||sbjcd==''||sbjnm.trim()==''||insno==''||weekhrs==''){
				alert("!");
				return false;
			}
			$.fn.clsBgngCheck(crc,year,hlf);
			if(clsBgngChecker==1){
				alert("교과목을 생성 또는 수정할 수 없는 과정입니다");
				return false;
			}
			if($("#o").prop("checked") == true){
				esntl = "Y";
			}else{
				esntl = "N" 	;
			}
			$.post({
				url : "/estSaveAjax",
				data : {
					crc : crc,
					year : year,
					hlf : hlf,
					sbjcd : sbjcd,
					sbjnm : sbjnm,
					sbjxp : sbjxp,
					hrs : hrs,
					room : room,
					kornm : kornm,
					insno : insno,
					esntl : esntl,
					weekhrs : weekhrs
				},
				dataType : "json"
			}).done(function(data) {
				alert("저장되었습니다.");
				$("#a").attr("disabled",true);
				$("#b").attr("disabled",true);
				$("#c").attr("disabled",true);
				$("#d").attr("disabled",true);
				$("#subjectSearchBtn").attr("disabled",true);
				$("#g").attr("disabled",true);
				$("#h").attr("disabled",true);
				grid.on('click', function(ev){
					$.fn.gridClicker(ev);
				});
				$("#insertBtn").attr("disabled",false);
				$("#b").html("<option value=''>반기선택</option>");
				$("#b").append("<option value='0010'>상반기</option>");
				$("#b").append("<option value='0020'>하반기</option>");
				$.fn.Search();
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		삭제 버튼 클릭 시 체크박스가 체크된 모든 데이터를 삭제할 예정, 현재는 값만 넘기고 구현되지 않음
		$("#deleteBtn").click(function(){
			var checkedRows = grid.getCheckedRows();
			var ck = true;
			if(checkedRows.length==0){
				alert("체크박스를 선택해주세요");
				return false;
			}
			$.each(checkedRows, function(index,row){
				$.fn.clsBgngCheck(row.CRCLM_CD,row.CRCLM_YEAR,row.CRCLM_HALF);
				if(clsBgngChecker==1){
					ck = false;
				}
			})
			
			if(ck==false){				
				alert("교과목을 삭제할 수 없는 교육과정이 포함되어 있습니다");
				return false;
			}
			
			if(confirm("정말 삭제할겁니까?")!=true){
				return false;
			}else{
				$.each(checkedRows, function(index, row){
					$.post({
						url : "/estDelete",
						data : {
							crc : row.CRCLM_CD,
							year : row.CRCLM_YEAR,
							hlf : row.CRCLM_HALF,
							sbjno : row.SBJCT_NO,
							RSLT : null,
							RSLT_STR : null
						},
						dataType : "json"
					}).done(function(data) {
						if(data.result.RSLT!=0){
							alert(data.result.RSLT_STR);						
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});
				})
				alert("완료되었습니다");
				$.fn.search();
			}
						
		});
		
// 		과목선택 그리드
		var subgrid = new tui.Grid({
			el : document.getElementById("subjectGrid"),
			scrollX : true,
			scrollY : true,
			bodyHeight : 300,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "과목번호",
				name : 'SBJCT_NO',
				align:'center'
			}, {
				header : "과목명",
				name : 'SBJCT_NM',
				align:'center'
			}, {
				header : "과목설명",
				name : 'SBJCT_EXPLN',
		        align:'center'
			}, {
				header : "총강의시간",
				name : 'EDU_HR',
		        align:'center'
			} ]
		});
// 		강사선택 그리드
		var insgrid = new tui.Grid({
			el : document.getElementById("instructorGrid"),
			scrollX : true,
			scrollY : true,
			bodyHeight : 300,
			rowHeaders : [ 'checkbox' ],
			columns : [ {
				header : "강사번호",
				name : 'INSTR_NO',
				align:'center'
			}, {
				header : "강사명",
				name : 'KORN_FLNM',
				align:'center'
			} ]
		});
		
// 		과목검색모달
		$("#subjectSearchBtn").click(function(){
			$("#estSubjectModal").modal("show");
		});
// 		강사검색모달
		$("#instructorSearchBtn").click(function(){
			$("#estInstructorModal").modal("show");
		});
		
// 		모달띄울때새로고침
		$("#estSubjectModal").on('shown.bs.modal', function(e) {
			subgrid.refreshLayout();
		});
// 		모달띄울때새로고침
		$("#estInstructorModal").on('shown.bs.modal', function(e) {
			insgrid.refreshLayout();
		});
		
// 		과목검색모달 내 조회버튼
		$("#estSubShow").click(function(){
			var searchWord = $("#sub_Search_text").val();
			$.post({
				url : "/estSubjectListAjax",
				data : {
					searchWord : searchWord
				},
				dataType : "json"
			}).done(function(data) {
				subgrid.refreshLayout();
				subgrid.resetData(data.estSubjectList);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
// 		강사검색모달 내 조회버튼
		$("#estInsShow").click(function(){
			var searchWord = $("#ins_Search_text").val();
			$.post({
				url : "/estInstructorListAjax",
				data : {
					searchWord : searchWord
				},
				dataType : "json"
			}).done(function(data) {
				insgrid.refreshLayout();
				insgrid.resetData(data.estInstructorList);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
// 		모달내에서 선택된 값을 임시저장
		var sbjno,sbjnm,sbjxp,hrs;
		subgrid.on('click', function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				$("#estSubChoose").attr("disabled",false);
				sbjno = subgrid.getValue(ev.rowKey,'SBJCT_NO');
				sbjnm = subgrid.getValue(ev.rowKey,'SBJCT_NM');
				sbjxp = subgrid.getValue(ev.rowKey,'SBJCT_EXPLN');
				hrs = subgrid.getValue(ev.rowKey,'EDU_HR');
			}
		});

		// 		모달내에서 선택된 값을 임시저장
		var insno,kornm;
		insgrid.on('click', function(ev){
			if(ev.rowKey == null){
				return false;
			}else{
				$("#estInsChoose").attr("disabled",false);
				insno = insgrid.getValue(ev.rowKey,'INSTR_NO');
				kornm = insgrid.getValue(ev.rowKey,'KORN_FLNM');
			}
		});
		
		
// 		모달 내에서 선택된 값을 메인 입력창에 입력한다
		$("#estSubChoose").click(function(ev){
			$("#d").val(sbjno);
			$("#d").text(sbjno);
			$("#e").val(sbjnm);
			$("#z").val(sbjnm);
			$("#f").val(sbjxp);
			$("#g").val(hrs);
			$("#h").val(Math.floor(hrs/26));
			$("#estSubChoose").attr("disabled",true);
			$("#estSubjectModal").modal("hide");
			sbjno="";
			sbjnm="";
			sbjxp="";
			hrs="";
		});
// 		모달 내에서 선택된 값을 메인 입력창에 입력한다
		$("#estInsChoose").click(function(ev){
			$("#m").val(kornm);
			$("#n").val(insno);
			$("#estInsChoose").attr("disabled",true);
			$("#estInstructorModal").modal("hide");
			insno="";
			kornm="";
		});
		
// 		강의시간코드에 기반하여 목록생성
		$.post({
			url : "/estHourList",
			dataType : "json"
		}).done(function(data) {
			var code, name, optionHTML;
			$.each(data.estHourList, function(index, element) {
				code = element.CD;
				name = element.CD_NM;
				optionHTML = "<option value="+code+">" + name + "</option>";
				$("#j").append(optionHTML);
				$("#k").append(optionHTML);
			})
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
// 		강의시작시간이 변경되면 강의종료시간은 그 이후의 교시만 선택할 수 있다
		$("#j").change(function(){
			var j = $("#j").val();
			$.post({
				url : "/estHourList",
				dataType : "json"
			}).done(function(data) {
				var code, name, optionHTML;
				$.each(data.estHourList, function(index, element) {
					code = element.CD;
					name = element.CD_NM;
					if(parseInt(code)<parseInt(j)){
						
					}else{						
						optionHTML += "<option value="+code+">" + name + "</option>";
					}
					$("#k").html(optionHTML);
				})
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
		//강의실을 바꾸면 강의실에 해당하는 시간표 데이터를 불러온다
		$("#i").change(function(){
			var crc = $("#c").val();
			var year = $("#a").val();
			var hlf = $("#b").val();
			var room = $("#i").val();
			var sbjno = $("#d").val();
			$.post({
				url : "/estTimeTable",
				data : {
					crc : crc,
					year : year,
					hlf : hlf,
					room : room
				},
				dataType : "json"
			}).done(function(data) {
				var cls = [];
				for(var i=0;i<8;i++){
					cls[i] = [0,0,0,0,0];	
				}
				var timeSaved;
				$.each(data.timeInfo,function(index,element){
					cls[parseInt(element.CLS_CD)-1][parseInt(element.LECT_DAY_CD)-1] = element.SBJ;
					if(element.SBJCT_NO==sbjno && element.CRCLM_CD==crc){
						timeSaved = 1;
						$("#")
					}
				})
				var tableHTML = "";
				for(var j=0;j<8;j++){
					tableHTML += "<tr><td>"+ (j+1) +"교시</td>"
					for(var k=0;k<5;k++){
						if(cls[j][k]==$("#z").val()){
							tableHTML += "<td><input type='checkbox' checked disabled></td>";
						}
						else if(cls[j][k]!=0){								
							tableHTML += "<td><input type='checkbox' disabled></td>";
						}
						else{
							tableHTML += "<td><input type='checkbox'></td>";
						}
					}
					tableHTML += "</tr>"
				}
				$("#timeTable tbody").html(tableHTML);
				if(timeSaved==1){
					$("#timeTable tr td input[type='checkbox']").prop("disabled",true);
					$("#i").attr("disabled",true);
					$("#instructorSearchBtn").attr("disabled",true);
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		});
		
		
		//시간표 확정
		$("#timeButton").hide(0);
		$("#timeButton").click(function(){
			var crc = $("#c").val();
			var year = $("#a").val();
			var hlf = $("#b").val();
			var room = $("#i").val();
			var sbj = $("#d").val();
			if(crc==''||year==''||hlf==''||room==''){
				alert("과목을 선택하세요");
				return false;
			}
			var cell = [];
			for(var i=1;i<=8;i++){
				cell[i] = [];
				for(var j=1;j<=5;j++){
					if($("#timeTable tr:eq("+i+") td:eq("+j+") input[type='checkbox']").prop("checked")==true){
						cell[i][j] = true;
					}else{
						cell[i][j] = false;
					}
				}
			}
			var weekhr = 0;
			var hrNeeded = $("#h").val();
			var dailyMap = [];
			for(var i=0;i<5;i++){
				dailyMap[i] = new Map();
				dailyMap[i].set("dayCode","000"+(i+1));
			}
			
			for(var i=1;i<=5;i++){
				var consChecker = 0;
				
				for(var j=1;j<8;j++){
					if(cell[j][i]!=cell[j+1][i]){
						consChecker++;	
					}
				}
				for(var j=1;j<=8;j++){
					if(cell[j][i]==true){
						weekhr += 1;
					}
				}
				if(consChecker>2){
					alert("강의시간은 연속되어야 한다");
					return false;
				}
			}
			if(weekhr!=hrNeeded){
				alert("강의시수를 확인해보세요");
				return false;
			}
			
			for(var i=0;i<5;i++){
				for(var j=1;j<=8;j++){
					if(cell[j][i+1]==true){
						dailyMap[i].set("startCode","000"+j);
						break;
					}
				}
				for(var j=1;j<=8;j++){
					if(cell[9-j][i+1]==true){
						dailyMap[i].set("endCode","000"+(9-j));
						break;
					}
				}
			}
			if(confirm("이대로 시간표를 확정합니까?\n이후 시간표,강사,강의실을 변경할 수 없습니다")!=false){
				$.each(dailyMap,function(index,element){
					if(element.size>2){
						
					$.post({
						url : "/estTimeConfirm",
						data : {
							crc : crc,
							year : year,
							hlf : hlf,
							sbj : sbj,
							room : room,
							dayCode : element.get("dayCode"),
							startCode : element.get("startCode"),
							endCode : element.get("endCode")
						},
						dataType : "json"
					}).done(function(data) {
						
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});
					}
					$("#timeTable tr td input[type='checkbox']").prop("disabled",true);
					$("#i").attr("disabled",true);
					$("#instructorSearchBtn").attr("disabled",true);
					$("#timeButton").hide(0);
				});
			}else{
				return false;
			}
		});
	});
</script>
<style>
.tui-grid-cell {
	font-size: 14px;
}
</style>
</head>
<body class="sb-nav-fixed">
	
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-4 mb-1 position-relative row">
						<div style="width:30px;">
						<img src="./image/joongang_logo.png" style="width:25px;">
						</div>
						<div style="width:200px; height:30px;  "> 
							<h5 style="font-weight: bold; color:#565757; line-height:30px;">개설교과목관리</h5>
						</div>
					</div>
					<hr style="height: 4px;" class="m-0 mb-1">
					<div class="row d-flex align-items-center" style="height:55px; background-color: #F3FAFE; border: 1px solid #c0c0c0;">
						<div class="col-md-4">
							<select class="form-select" id="crclmSelect">
								<option selected value=''>교육과정선택</option>
							</select>
						</div>
						<div class="col-md-2">
							<input type="number" class="form-control" placeholder="연도" id="yearSelect">
						</div>
						<div class="col-md-2">
							<select class="form-select" id="halfSelect">
								<option selected value=''>반기선택</option>
							</select>
						</div>
						
						<div class="col-md-4 d-flex justify-content-center">
						<div><button class="btn btn-primary" id="searchBtn">조회</button></div>
						<div><button class="btn btn-info" id="insertBtn">신규</button></div>
						<div><button class="btn btn-secondary" id="saveBtn">저장</button></div>
						<div><button class="btn btn-danger" id="deleteBtn">삭제</button></div>
						</div>
					</div>
						<div>
							<div class="float-start"
								style="width: 10px; height: 27px; background-color: #498c5f; margin-right: 10px;"></div>
							<h6 class="mt-3 fw-bolder">개설교과목</h6>
						</div>
							<div id="grid" class="mb-3" style="width: 100%;"></div>
							<hr style="height: 4px;" class="mb-2">
							<div>
							<div class="float-start"
								style="width: 10px; height: 27px; background-color: #498c5f; margin-right: 10px;"></div>
							<h6 class="mt-3 fw-bolder">상세정보</h6>
						</div>
					<div>
						<div class="d-flex justify-content-center"
							style="background-color: #F3FAFE; width: 100%; min-height: 300px; border: 1px solid #c0c0c0;">
							<form style="width:95%;">

								<div class="row">
									<div class="form-group col-md-6">
										<label for="c" class="col-form-label">교육과정</label> <select
											id="c" class="form-control" disabled>
											<option></option>
										</select>
									</div>
									<div class="form-group col-md-3">
										<label for="a" class="col-form-label">연도</label> 
										<input type="number" id="a" class="form-control" disabled>
									</div>
									<div class="form-group col-md-3">
										<label for="b" class="col-form-label">반기</label> <select
											id="b" class="form-control" disabled>
											<option>반기선택</option>
										</select>
									</div>
								</div>

								
								<div class="row">
									<div class="form-group col-md-4">
										<label for="z" class="col-form-label">과목명</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span id="d" class="form-control">과목번호</span>
											</div>
											<input id="z" type="text" class="form-control" disabled>
											<div class="input-group-append">
												<button type="button" class="btn btn-outline-dark"
													id="subjectSearchBtn" disabled>검색</button>
											</div>
										</div>
									</div>
									<div class="form-group col-md-4">
										<label for="e" class="col-form-label">개설과목명</label> <input
											id="e" class="form-control" type="text" disabled>
									</div>
									<div class="form-group col-md-4">
										<label for="m" class="col-form-label">담당강사</label>
										<div class="input-group">
											<input id="n" type="hidden"> <input id="m"
												class="form-control" type="text" disabled>
											<div class="input-group-append">
												<button type="button" class="btn btn-info"
													id="instructorSearchBtn">검색</button>
											</div>
										</div>
									</div>

								</div>
								<div class="row">
									<div class="col">
										<div class="row">
											<div class="form-group col-md-6">
												<label for="g" class="col-form-label">총강의시간</label> <input
													id="g" class="form-control" type="text" disabled>
											</div>
											<div class="form-group col-md-6">
												<label for="i" class="col-form-label">강의실</label> <select
													id="i" class="form-control" disabled>
													<option></option>
												</select>
											</div>
										</div>

										<div class="row">
											<div class="form-group col-md-12">
												<label for="f" class="col-form-label">과목설명</label>
												<textarea id="f" class="form-control" rows="5" disabled></textarea>
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">

												<label for="h" class="form-check-label">강의시수</label> <input
													id="h" class="form-control" type="text" disabled>

											</div>
											<div class="form-group col-md-6 d-flex align-items-center">
												<div class="form-check">
													<label for="o" class="form-check-label">필수과목여부</label> <input
														id="o" class="form-check-input" type="checkbox" disabled>
												</div>
											</div>
										</div>
									</div>
									<div class="col">
										<label for="timeTableDiv" class="col-form-label">강의시간</label>
										<div id="timeTableDiv">
											<table id="timeTable" class="table" style="width: 100%;"
												border="1">
												<thead>
													<tr class="table-primary">
														<th>시간/요일</th>
														<th>월</th>
														<th>화</th>
														<th>수</th>
														<th>목</th>
														<th>금</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>1교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>2교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>3교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>4교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>5교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>6교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>7교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
													<tr>
														<td>8교시</td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
														<td><input type='checkbox' disabled></td>
													</tr>
												</tbody>
											</table>
										</div>
										<button type="button" class="btn btn-outline-primary"
											id="timeButton">시간표 저장</button>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				<div class="container-fluid"></div>
				<!-- 과목 검색모달  -->
				<div class="modal fade" id="estSubjectModal" tabindex="-1"
					role="dialog" data-bs-backdrop="static"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">
									<b>과목검색</b>
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="mb-4 w-100" style="height: 18px;">
									<button type="button"
										class="btn btn-sm btn-secondary float-end"
										style="margin-left: 5px;" id="estSubClose"
										data-bs-dismiss="modal" aria-label="Close">닫기</button>
									<button type="button"
										class="btn btn-sm btn-secondary float-end"
										style="margin-left: 5px;" id="estSubChoose"
										disabled="disabled">선택</button>
									<button type="button"
										class="btn btn-sm btn-secondary float-end"
										style="margin-left: 5px;" id="estSubShow">조회</button>
								</div>

								<div class="p-1 mb-4 border container-fluid"
									style="background-color: #F3FAFE">
									<div class="row">
										<span class="col-2 text-center ta font-set">과목</span>
										<div class="col-10"
											style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
											<div class="input-group input-group-sm">
												<input type="text"
													class="form-control form-control-sm dep_Search_text"
													placeholder="검색어을 입력하세요" name="dep_Search_text"
													id="sub_Search_text" aria-describedby="basic-addon3">
											</div>
										</div>
									</div>

								</div>
								<div class="head">
									<div class="float-start"
										style="width: 10px; height: 27px; background-color: #498c5f;"></div>
									<div class="fw-border"
										style="font-size: 17px; margin-left: 15px; padding-top: 2px;">과목
										정보</div>
								</div>
								<div class="table-responsive" style="margin-top: 5px;">
									<div id="subjectGrid"></div>
								</div>

							</div>
							<!-- <div class="modal-footer"></div> -->
						</div>
					</div>
				</div>
				<!-- 강사 검색모달  -->
				<div class="modal fade" id="estInstructorModal" tabindex="-1"
					role="dialog" data-bs-backdrop="static"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">
									<b>과목검색</b>
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="mb-4 w-100" style="height: 18px;">
									<button type="button"
										class="btn btn-sm btn-secondary float-end"
										style="margin-left: 5px;" id="estInsClose"
										data-bs-dismiss="modal" aria-label="Close">닫기</button>
									<button type="button"
										class="btn btn-sm btn-secondary float-end"
										style="margin-left: 5px;" id="estInsChoose"
										disabled="disabled">선택</button>
									<button type="button"
										class="btn btn-sm btn-secondary float-end"
										style="margin-left: 5px;" id="estInsShow">조회</button>
								</div>

								<div class="p-1 mb-4 border container-fluid"
									style="background-color: #F3FAFE">
									<div class="row">
										<span class="col-2 text-center ta font-set">강사</span>
										<div class="col-10"
											style="padding-bottom: 3.5px; padding-top: 3.5px; margin-left: -13px;">
											<div class="input-group input-group-sm">
												<input type="text"
													class="form-control form-control-sm dep_Search_text"
													placeholder="검색어을 입력하세요" name="dep_Search_text"
													id="ins_Search_text" aria-describedby="basic-addon3">
											</div>
										</div>
									</div>

								</div>
								<div class="head">
									<div class="float-start"
										style="width: 10px; height: 27px; background-color: #498c5f;"></div>
									<div class="fw-border"
										style="font-size: 17px; margin-left: 15px; padding-top: 2px;">강사
										정보</div>
								</div>
								<div class="table-responsive" style="margin-top: 5px;">
									<div id="instructorGrid"></div>
								</div>

							</div>
							<!-- <div class="modal-footer"></div> -->
						</div>
					</div>
				</div>
			</main>
			<%-- 			<%@include file="../bar/footer.jsp"%> --%>
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
