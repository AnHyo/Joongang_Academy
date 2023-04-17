<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">
$(function() {
/* 	grid.use('Net', {
    perPage: 100,
    api: {
        createData: '/api/createData'
    }
	});

var net = grid.getAddOn('Net');
//...
// 그리드에서 데이터 생성 완료 후 서버 호출
net.request('createData');

grid.on('response', function(data) {
    console.log(data); // 서버 데이터
}); 
//  Step 1: URL 설정
	grid.use('Net', {
	    perPage: 100,
	    api: {
	        createData: '/api/createData'
	    }
	}); */

	//전역변수
	var dataSource = {
			  api: {
			    readData: { url: '/codeListAjax', method: 'POST' },
			    createData: { url: '/codeCreateData', method: 'POST' },
			    modifyData: { url: '/api/modifyData', method: 'PUT' },
			    deleteData: { url: '/api/deleteData', method: 'DELETE' }
			  }
			};
	
 	var grid1 = new tui.Grid({
		el : document.getElementById('grid'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 200,
		data: dataSource,
		rowHeaders : [ 'checkbox' ],
		columns : [ 
		{
			header : '코드분류',
			name : 'CD_CLSF',
			width: 100,
			align : 'center',
			editor: {
				type: 'text',
				maxLength: 4
			},
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '코드',
			name : 'CD',
			width: 100,
			align : 'center',
			editor: 'text',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '코드명',
			name : 'CD_NM',
			width: 250,
			align : 'center',
			editor: 'text',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '코드사용여부',
			name : 'CD_USE_YN',
			width: 100,
			align : 'center',
			sortable: true,
		    sortingType: 'desc',
		    copyOptions:{
			 useListItemText: true
		},formatter: 'listItemText',
         editor: {
             type: 'radio',
             options: {
               listItems: [
                 { text: 'Y'},
                 { text: 'N'}
               ], defaultValue: "'Y'"
             }
           } 
		}, 
		{
			header : '코드설명',
			name : 'CD_EXPLN',
			align : 'center',
			editor: 'text',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '코드정렬일련번호',
			name : 'CD_SORT_SN',
			width: 120,
			align : 'center',
			editor: 'text',
			sortable: true,
		    sortingType: 'desc'
		} ],
		selectionUnit: 'row' //row단위로 선택
	});
 	
	//grid 전체리스트     
	$.post({
		url : "/codeListAjax",
		dataType : "json"
	}).done(function(data) {
		  
		/* const columns = [
		    {
		      header: '코드사용여부',
		      name: 'CD_USE_YN',
		      width: 100,
		      align: 'center',
		      sortable: true,
		      sortingType: 'desc',
		      copyOptions: {
		        useListItemText: true
		      },
		      formatter: 'listItemText',
		      editor: {
		        type: 'radio',
		        options: {
		          listItems: [
		            { text: 'Y' },
		            { text: 'N' }
		          ],
		          defaultValue: data.list[0].CD_USE_YN
		        }
		      }
		    }];
		grid1.setColumns(columns); */
		    
		    
		    
  	  grid1.resetData(data.list);
  		// cell 하나 클릭시 한 줄 전체 범위 지정
		grid1.on('focusChange', (ev) => {
			  grid1.setSelectionRange({
			    start: [ev.rowKey, 0],
			    end: [ev.rowKey, grid1.getColumns().length]
			  });
		});
	}).fail(function() {
		alert("문제가 발생했습니다.");
	});
	
	
	var grid2 = new tui.Grid({
		el : document.getElementById('grid2'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 200,
		rowHeaders : [ 'checkbox' ],
		columns : [ 
			{
				header : '코드분류',
				name : 'CD_CLSF',
				width: 100,
				align : 'center',
				editor: 'text',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '코드',
				name : 'CD',
				width: 100,
				align : 'center',
				editor: 'text',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '코드명',
				name : 'CD_NM',
				width: 250,
				align : 'center',
				editor: 'text',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '코드사용여부',
				name : 'CD_USE_YN',
				width: 100,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			/* 	copyOptions:{
					 useListItemText: true
				},formatter: 'listItemText',
		          editor: {
		              type: 'radio',
		              options: {
		                listItems: [
		                  { text: 'Y', value: '0010' },
		                  { text: 'N', value: '0020' }
		                ]
		              }
		            } */
			}, {
				header : '코드설명',
				name : 'CD_EXPLN',
				align : 'center',
				editor: 'text',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '코드정렬일련번호',
				name : 'CD_SORT_SN',
				width: 120,
				align : 'center',
				editor: 'text',
				sortable: true,
			    sortingType: 'desc'
			} ],
			selectionUnit: 'row'
	});
	
	// 신규 버튼
	$("#add_btn1").click(function(){
		grid1.prependRow();
		$("#add_btn1").addClass("disabled");
	}); 
	//검색버튼
	$("#search_btn").click(function(){
	var code_search = $("#code_search").val();
		$.post({
			url : "/codeListAjax",
			dataType : "json",
			cache : false,
			data: {"code_search" : code_search}
		}).done(function(data) {
	  	  grid1.resetData(data.list);
	  	  $("#add_btn").removeClass("disabled");
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		
	});
	
	$('#add_btn3').on('click', function() {
		  grid3.appendRow();
		});
	// 신규2 버튼
	$("#add_btn2").click(function(){
		grid2.appendRow();
		$("#add_btn2").addClass("disabled");
			/* focus : true*/
	});

	// 저장 버튼(추가,수정,삭제)
	$('#save_btn1').on('click', function(){
		//필수값 입력하기
		function checkRequiredValues(){
			if(CD_CLSF == "" || CD_CLSF == null){
				alert("코드분류를 입력하세요");
				result = false;
			}
			else if(CD == "" || CD == null){
				alert("코드를 입력하세요");
				result = false;
			}
			else {
				result = true;
			}
			return result;
		};
		
		var modifiedRows = grid1.getModifiedRows(); //추가/수정/삭제된 값 

		// 배열로 변환
		if (!Array.isArray(modifiedRows)) {
		  modifiedRows = [modifiedRows];
		}
		
		  // __modified__ 속성 제거 후 반환
// 		  var data = modifiedRows.map(function(row) {
// 		    delete row['__modified__'];
// 		    return row;
// 		  }); 
		//alert("data:" + JSON.stringify(data)); //ok
		
		//신규추가한 행의 정보 
		var createdRows = modifiedRows[0].createdRows;
		var createdData = createdRows.map(function(row) {
		    return {
		        CD_CLSF: row.CD_CLSF,
		        CD: row.CD,
		        CD_NM: row.CD_NM,
		        CD_USE_YN: row.CD_USE_YN,
		        CD_EXPLN: row.CD_EXPLN,
		        CD_SORT_SN: row.CD_SORT_SN
		    };
		});
		
		//수정한 행의 정보
// 		for(var i=0; i<modifiedRows.length; i++){
			var updatedRows = modifiedRows[0].updatedRows;
			//alert("updatedRows.length :"+updatedRows.length); //수정된 행의 갯수
			var updatedData = updatedRows.map(function(row){
				return {
					CD_CLSF: row.CD_CLSF,
			        CD: row.CD,
			        CD_NM: row.CD_NM,
			        CD_USE_YN: row.CD_USE_YN,
			        CD_EXPLN: row.CD_EXPLN,
			        CD_SORT_SN: row.CD_SORT_SN
				}
			});
// 		}
		
		if(createdRows.length > 0 || updatedRows.length > 0){//(삭제 추후 넣기)
			//if(createdRows && createdRows.length > 0){	
			//신규값이 있는경우 
			if(createdRows.length > 0){	
				var CD_CLSF = createdData[0].CD_CLSF;
				var CD = createdData[0].CD;
				var CD_NM = createdData[0].CD_NM;
				var CD_USE_YN = createdData[0].CD_USE_YN;
				var CD_EXPLN = createdData[0].CD_EXPLN;
				var CD_SORT_SN = createdData[0].CD_SORT_SN;
				//alert("datas:"+JSON.stringify(datas)); //새로 추가한 정보 값 
				//alert(CD_CLSF); //ok
				//필수값 입력
				if(!checkRequiredValues()){ //boolean
		           return false;
		        } 
				//추가한정보 삽입 
				$.post({
					url : "/codeCreate",
					data: {
						"CD_CLSF" :CD_CLSF,
						"CD":CD,
						"CD_NM":CD_NM,
						"CD_USE_YN" : CD_USE_YN,
						"CD_EXPLN" : CD_EXPLN,
						"CD_SORT_SN" : CD_SORT_SN
					    },
		 			//type: dataSource.api.createData.method, ($.post이기 때문에 생략가능)
		 			//contentType: "application/json;charset=UTF-8", //이거 있으면 오류남! 왜?
					dataType : "json"
				}).done(function(data) {
					if(data.result == 2){
						alert("이미 존재하는 코드입니다.");
					}
					else if(data.result == 1){
						alert("(신규)저장되었습니다.");
						grid1.resetData(data.list);
						$("#add_btn1").removeClass("disabled");
						// 신규 저장 후 focus
						grid1.focus(createdRows[0].rowKey); //안됨. 마지막로우가 포커스됨
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			} //create 끝 
			
			if(updatedRows.length > 0){
				var CD_CLSF = updatedData[0].CD_CLSF;
				var CD = updatedData[0].CD;
				var CD_NM = updatedData[0].CD_NM;
				var CD_USE_YN = updatedData[0].CD_USE_YN;
				var CD_EXPLN = updatedData[0].CD_EXPLN;
				var CD_SORT_SN = updatedData[0].CD_SORT_SN;
				//alert(CD_CLSF);//ok
				
				//필수값 입력
				if(!checkRequiredValues()){
		           return false;
		        }
				
				//정보수정 (update) 
				$.post({
					url : "/codeUpdate",
					data: {
						"CD_CLSF" :CD_CLSF,
						"CD":CD,
						"CD_NM":CD_NM,
						"CD_USE_YN" : CD_USE_YN,
						"CD_EXPLN" : CD_EXPLN,
						"CD_SORT_SN" : CD_SORT_SN
					    },
					dataType : "json"
				}).done(function(data) {
					if(data.result == 2){
						alert("이미 존재하는 코드입니다.");
					}
					else if(data.result == 1){
						alert("수정 되었습니다.");
						grid1.resetData(data.list);
						//$("#add_btn1").removeClass("disabled");
						// 저장 후 focus
						grid1.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
				
			}
		}
	else {
		alert("저장할 데이터가 없습니다.");
	} 
}); //save_btn1 끝


	//td 클릭 (디테일리스트)
	$(document).on('mousedown', 'td', function() { //mousedown: 이벤트 클릭한순간 발생
	var gridslct = $(this).parents('#grid');
	var gridslctId = gridslct.attr('id'); //grid
	if (gridslctId == 'grid') { //grid2 td는 안눌리게 
	
     var rowKey = $(this).attr('data-row-key'); //0(번째)
     //var colName = $(this).attr('data-column-name'); //클릭한 컬럼명
     //var columnKey = $(this).attr('data-column-name'); //CD_NM
     //alert('Clicked CD_CLSF value:' + CD_CLSFValue);
     
     // 수정전 값 old_CD_CLSF객체에 담기
      var CD_CLSFValue = grid1.getValue(rowKey, 'CD_CLSF'); //td값 //0번째의 CD_CLSF값 //0000
//      old_CD_CLSF1[rowKey] = CD_CLSFValue;
//      alert(JSON.stringify(old_CD_CLSF1)); //{"0":"0000"}//ok
//      old_CD_CLSF = CD_CLSFValue; 
     
     //td를 눌러서 셀값을 바꿀때마다 old_CD_CLSF값이 달라짐..이러면안댐
     //alert(CD_CLSFValue); //0000
     //if(CD_CLSFValue){}
     //alert(CD_CLSFValue);
     
     
     
	 	$.post({
			url : "/codeListAjax2",
			dataType : "json",
	 		data: {"CD_CLSFValue" : CD_CLSFValue}
		}).done(function(data) {
	  	  grid2.resetData(data.detaillist);
		  grid2.on('focusChange', (ev) => {
				  grid2.setSelectionRange({
				    start: [ev.rowKey, 0],
				    end: [ev.rowKey, grid2.getColumns().length]
				  });
			});
		  $("#add_btn2").removeClass("disabled");
		}).fail(function() {
			alert("문제가 발생했습니다!");
		});
    };  
   });  
	
	//td 재클릭
	$("td").change(function(){
	   var rowKey = $(this).attr('data-row-key'); //0(번째)
	     //var columnKey = $(this).attr('data-column-name'); //CD_NM
	     var CD_CLSFValue = grid.getValue(rowKey, 'CD_CLSF'); //td값
	     //alert('Clicked CD_CLSF value:' + CD_CLSFValue); //0번째의 CD_CLSF값 //0000
	     
		 	$.post({
				url : "/codeListAjax2",
				dataType : "json",
		 		data: {"CD_CLSFValue" : CD_CLSFValue}
			}).done(function(data) {
		  	  grid2.resetData(data.detaillist);
		  	  
			}).fail(function() {
			alert("문제가 발생했습니다!");
		});
	});
	
	//grid hover
	/* 	const grid = tui.Grid;
		grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				}); */
		
		//우클릭, 드래그 방지(그리드 X)
	/* 	function fn_control_mouse(){
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
		fn_control_mouse();	 */	
	
	
	
	
	const grid3 = new Grid({
	      el: document.getElementById('grid3'),
	      scrollX: false,
	      scrollY: false,
	      minBodyHeight: 30,
	      rowHeaders: ['checkbox'],
	      columns : [ 
	  		{
	  			header : '코드분류',
	  			name : 'CD_CLSF',
	  			width: 100,
	  			align : 'center',
	  			editor: 'text',
	  			sortable: true,
	  		    sortingType: 'desc'
	  		}, {
	  			header : '코드',
	  			name : 'CD',
	  			width: 100,
	  			align : 'center',
	  			editor: 'text',
	  			sortable: true,
	  		    sortingType: 'desc'
	  		}]
	    });





});


</script>
</head>
<style type="text/css">
.btns {
	float: right;
}

button {
	border: 1px solid gray;
}
</style>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-3">
						<h5 class="fw-bolder">공통코드관리</h5>
					</div>
					<hr style="height: 4px;" class="m-0 mb-1">
							<div style="float:left;"><h6 class="mt-3 fw-bolder">코드구분</h6></div>
					<div class="d-flex justify-content-end pb-1 mb-2 mt-2">
						<!-- 검색 -->
							<div class="input-group"
								style="width: calc(20%); margin-right: 10px; float: left;">
								<input class="form-control form-control-sm" type="text" name="code_search" id="code_search"
									placeholder="검색어를 입력하세요" aria-describedby="btnNavbarSearch" />
							</div>
						<!-- 버튼 -->
						<div>
							<button type="button" class="btn btn-secondary btn-sm" id="search_btn">조회</button>
							<button type="button" class="btn btn-secondary btn-sm" id="add_btn1">신규</button>
							<button type="button" class="btn btn-secondary btn-sm" id="del_btn1">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm" id="save_btn1">저장</button>
						</div>
					</div>
					<div>
						<div id="grid"></div>
					</div>
					<div style="float:left;"><h6 class="mt-3 fw-bolder">코드정보</h6></div>
					<div class="d-flex justify-content-end pb-1 mb-2 mt-2">
						<div>
							<button type="button" class="btn btn-secondary btn-sm" id="add_btn2">신규</button>
							<button type="button" class="btn btn-secondary btn-sm">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm">저장</button>
						</div>
					</div>
					<div>
						<div id="grid2"></div>
					</div>
					<div>
						<button type="button" class="btn btn-secondary btn-sm" id="saveBtn">저장</button>
						<button type="button" class="btn btn-secondary btn-sm" id="add_btn3">신규</button>
						<div id="grid3"></div>
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


	<!-- TOAST UI Grid -->
	<link rel="stylesheet"
		href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>


</body>
</html>
