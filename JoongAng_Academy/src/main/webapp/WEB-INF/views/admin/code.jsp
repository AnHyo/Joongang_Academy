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
	
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style type="text/css">
.tui-grid-cell {
  font-size: 14px;
}

</style>
<script type="text/javascript">
$(function() {
	var list = "";
	var detaillist = "";
 	var grid1 = new tui.Grid({
		el : document.getElementById('grid'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 280,
		rowHeaders : [ 'checkbox' ],
		columns : [ 
		{
			header : '코드분류',
			name : 'CD_CLSF',
			width: 100,
			align : 'center',
			sortable: true,
			editor: 'text',
		    sortingType: 'desc'
		}, {
			header : '코드',
			name : 'CD',
			width: 100,
			editor: 'text',
			align : 'center',
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
                 { text: 'Y', value : 'Y'},
                 { text: 'N', value : 'N'}
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
				header : '코드분류',
				name : 'CD_CLSF',
				width: 100,
				align : 'center',
				sortable: true,
				 //editable: false, // 기본값: 편집 불가능
			    sortingType: 'desc'
			}];
		grid1.setColumns(columns);  */
  		grid1.resetData(data.list);
		grid1.disableColumn('CD_CLSF');
		grid1.disableColumn('CD');
	    //grid1.setReadOnlyCell('CD_NM', true);
	    
// 	      grid.on('beforeChange', ev => {
// 		    console.log('before change:', ev);
// 		  });
// 		  grid.on('afterChange', ev => {
// 		    console.log('after change:', ev);
// 		  });
		  

  		// cell 하나 클릭시 한 줄 전체 범위 지정
// 		grid1.on('focusChange', (ev) => {
// 			  grid1.setSelectionRange({
// 			    start: [ev.rowKey, 0],
// 			    end: [ev.rowKey, grid1.getColumns().length]
// 			  });
// 		});
	}).fail(function() {
		alert("문제가 발생했습니다.");
	});
	
	
	var grid2 = new tui.Grid({
		el : document.getElementById('grid2'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 160,
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
			    sortingType: 'desc',
			    copyOptions:{
				 useListItemText: true
			},formatter: 'listItemText',
	         editor: {
	             type: 'radio',
	             options: {
	               listItems: [
	                 { text: 'Y', value : 'Y'},
	                 { text: 'N', value : 'N'}
	               ], defaultValue: "'Y'"
	             }
	           } 
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
	    grid1.appendRow(list, { //상단에 detaillist을 전역변수로 선언해줘야함
			focus : true //포커스
		});
	    var rowKey = grid1.getRowCount() - 1;
	    grid1.enableCell(rowKey, 'CD_CLSF');
	    grid1.enableCell(rowKey, 'CD');
	    $(this).addClass("disabled"); 
	    
		//신규행 삭제(저장전)
		var deletedRows = [];
		$("#del_btn1").off().click(function(){
			var selectedRows = grid1.getCheckedRows();// 선택된 행들의 정보를 가져옴
			if(selectedRows.length > 0){
			  // 선택된 행들의 rowKey 값을 추출하여 배열로 변환
			  var rowKeys = selectedRows.map(function(row) {
			    return row.rowKey;
			  });
			  // 선택된 행들을 삭제
			  grid1.removeRows(rowKeys);
			 // createdRows = [];
			  $("#add_btn1").removeClass("disabled");
			} else {
				alert("행을 선택해주세요");
			}
		});
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
	
	// 신규2 버튼
	$("#add_btn2").click(function(){
	  grid2.appendRow(detaillist, { //상단에 detaillist을 전역변수로 선언해줘야함
			focus : true //포커스
		});
	    var rowKey = grid2.getRowCount() - 1;
	    grid2.enableCell(rowKey, 'CD_CLSF');
	    grid2.enableCell(rowKey, 'CD');
	    $(this).addClass("disabled"); 
	    
	    
		//신규행 삭제(저장전)
		//var deletedRows = [];
		$("#del_btn2").off().click(function(){
			var selectedRows = grid2.getCheckedRows();// 선택된 행들의 정보를 가져옴
			if(selectedRows.length > 0){
			  // 선택된 행들의 rowKey 값을 추출하여 배열로 변환
			  var rowKeys = selectedRows.map(function(row) {
			    return row.rowKey;
			  });
			  // 선택된 행들을 삭제
			  grid2.removeRows(rowKeys);
			 // createdRows = [];
			  $("#add_btn2").removeClass("disabled");
			} else {
				alert("행을 선택해주세요");
			}
		});
	});

	//삭제1
	var deletedRows = [];
	$("#del_btn1").on('click', function(){
		var selectedRows = grid1.getCheckedRows();// 선택된 행들의 정보를 가져옴
		if(selectedRows.length > 0){
		  // 선택된 행들의 rowKey 값을 추출하여 배열로 변환
		  var rowKeys = selectedRows.map(function(row) {
		    return row.rowKey;
		  });
		  // 선택된 행들을 삭제
		  grid1.removeRows(rowKeys);
		} else {
			alert("행을 선택해주세요");
		}
	});
	
	//삭제2
	var deletedRows = [];
	$("#del_btn2").on('click', function(){
		var selectedRows = grid2.getCheckedRows();// 선택된 행들의 정보를 가져옴
		if(selectedRows.length > 0){
		  // 선택된 행들의 rowKey 값을 추출하여 배열로 변환
		  var rowKeys = selectedRows.map(function(row) {
		    return row.rowKey;
		  });
		  // 선택된 행들을 삭제
		  grid2.removeRows(rowKeys);
		} else {
			alert("행을 선택해주세요");
		}
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
		  var data = modifiedRows.map(function(row) {
		    delete row['__modified__'];
		    return row;
		  }); 
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
			var updatedRows = modifiedRows[0].updatedRows;
			//삭제한 행의 정보
			var deletedRows = modifiedRows[0].deletedRows;
			//alert(deletedRows.length);//ok
		if(createdRows.length > 0 || updatedRows.length > 0 || deletedRows.length > 0){
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
						var rowKey = createdRows[0].rowKey;
						alert(rowKey);
						grid1.focus(rowKey, "CD_CLSF");
						grid2.resetData([]);
						$("#add_btn1").removeClass("disabled");
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			} //create 끝 
			
			if(updatedRows.length > 0){
				var updateData = []; //수정된행의 모든정보
			    for (var i = 0; i < updatedRows.length; i++) {
			      var row = updatedRows[i];
			      updateData.push({
			        CD_CLSF: row.CD_CLSF,
			        CD: row.CD,
			        CD_NM: row.CD_NM,
			        CD_USE_YN: row.CD_USE_YN,
			        CD_EXPLN: row.CD_EXPLN,
			        CD_SORT_SN: row.CD_SORT_SN
			      });
			    }
				//alert("updateData:"+JSON.stringify(updateData)); //ok
				$.post({
					url : "/codeUpdate",
					    contentType: 'application/json;charset=UTF-8',
					    data: JSON.stringify(updateData),
						dataType : "json"
				}).done(function(data) {
					if(data.result2 == 2){
						alert("이미 존재하는 코드입니다.");
					} 
					else if(data.result > 0){
						alert("수정 되었습니다.");
						updatedRows = [];
						grid1.resetData(data.list, {focus:true});
						grid2.resetData([]);
						//grid1.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
			
			//삭제
			if(deletedRows.length > 0){
				
			    var deleteData = []; //삭제된행의 모든정보
			    var hasYn;
			    
			    for (var i = 0; i < deletedRows.length; i++) {
			      var row = deletedRows[i];
			      if(row.CD_USE_YN == "Y"){
			    	  hasYn = true;
			    	  
			      } else {
				      deleteData.push({
				        CD_CLSF: row.CD_CLSF,
				        CD: row.CD,
				        CD_NM: row.CD_NM,
				        CD_USE_YN: row.CD_USE_YN,
				        CD_EXPLN: row.CD_EXPLN,
				        CD_SORT_SN: row.CD_SORT_SN
				      });
				    }
			    }
			    if(hasYn){
			    	alert("사용여부가 'N'인 코드만 삭제가 가능합니다.");
			    	//grid 전체리스트     
			    	$.post({
			    		url : "/codeListAjax",
			    		dataType : "json"
			    	}).done(function(data) {
			      		grid1.resetData(data.list);
			    		grid1.disableColumn('CD_CLSF');
			    		grid1.disableColumn('CD');
			    		grid2.resetData([]);
			    	}).fail(function() {
			    		alert("문제가 발생했습니다.");
			    	});
			    } else if(hasYn != true){
				    $.post({
						url : "/codeDelete",
						    contentType: 'application/json;charset=UTF-8',
						    data: JSON.stringify(deleteData),
							dataType : "json"
					}).done(function(data) {
						if(data.result > 0){
							alert("삭제 되었습니다.");
							deletedRows = [];
							grid1.resetData(data.list);
							grid2.resetData([]);
							//grid1.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
						}
					}).fail(function() {
						alert("이미 사용중인 코드입니다.");
					});
			    }
		}//delete 끝
		
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
			grid2.disableColumn('CD_CLSF');
			grid2.disableColumn('CD');
			
// 		  grid2.on('focusChange', (ev) => {
// 				  grid2.setSelectionRange({
// 				    start: [ev.rowKey, 0],
// 				    end: [ev.rowKey, grid2.getColumns().length]
// 				  });
// 			});
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
	
	
	
	
	// 저장2 버튼(추가,수정,삭제)
	$('#save_btn2').on('click', function(){
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
		
		var modifiedRows = grid2.getModifiedRows(); //추가/수정/삭제된 값 

		// 배열로 변환
		if (!Array.isArray(modifiedRows)) {
		  modifiedRows = [modifiedRows];
		}
		
		  // __modified__ 속성 제거 후 반환
		  var data = modifiedRows.map(function(row) {
		    delete row['__modified__'];
		    return row;
		  }); 
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
			var updatedRows = modifiedRows[0].updatedRows;
			//삭제한 행의 정보
			var deletedRows = modifiedRows[0].deletedRows;
			//alert(deletedRows.length);//ok
		if(createdRows.length > 0 || updatedRows.length > 0 || deletedRows.length > 0){
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
						grid2.resetData([]);
						$("#add_btn2").removeClass("disabled");
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			} //create 끝 
			
			if(updatedRows.length > 0){
				var updateData = []; //수정된행의 모든정보
			    for (var i = 0; i < updatedRows.length; i++) {
			      var row = updatedRows[i];
			      updateData.push({
			        CD_CLSF: row.CD_CLSF,
			        CD: row.CD,
			        CD_NM: row.CD_NM,
			        CD_USE_YN: row.CD_USE_YN,
			        CD_EXPLN: row.CD_EXPLN,
			        CD_SORT_SN: row.CD_SORT_SN
			      });
			    }
				//alert("updateData:"+JSON.stringify(updateData)); //ok
				$.post({
					url : "/codeUpdate",
					    contentType: 'application/json;charset=UTF-8',
					    data: JSON.stringify(updateData),
					dataType : "json"
				}).done(function(data) {
					if(data.result2 == 2){
						alert("이미 존재하는 코드입니다.");
					} 
					else if(data.result > 0){
						alert("수정 되었습니다.");
						updatedRows = [];
						grid1.resetData(data.list);
						grid2.resetData(data.detaillist);
						//grid1.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
			
			//삭제
			if(deletedRows.length > 0){
				
			    var deleteData = []; //삭제된행의 모든정보
			    var hasYn2 = false;
			    
			    for (var i = 0; i < deletedRows.length; i++) {
			      var row = deletedRows[i];
			      if(row.CD_USE_YN == 'Y'){
			    	  hasYn2 = true;
			      }else{
				      deleteData.push({
				        CD_CLSF: row.CD_CLSF,
				        CD: row.CD,
				        CD_NM: row.CD_NM,
				        CD_USE_YN: row.CD_USE_YN,
				        CD_EXPLN: row.CD_EXPLN,
				        CD_SORT_SN: row.CD_SORT_SN
				      });
			      }
			    }
				
			    if(hasYn2){
			    	alert("사용여부가 'N'인 코드만 삭제가 가능합니다.");
			    	//grid 전체리스트     
			    	$.post({
			    		url : "/codeListAjax",
			    		dataType : "json"
			    	}).done(function(data) {
			      		grid1.resetData(data.list);
			    		grid1.disableColumn('CD_CLSF');
			    		grid1.disableColumn('CD');
			    		grid2.resetData([]);
			    	}).fail(function() {
			    		alert("문제가 발생했습니다.");
			    	});
			    }else if(hasYn2=="N"){
					$.post({
						url : "/codeDelete",
						    contentType: 'application/json;charset=UTF-8',
						    data: JSON.stringify(deleteData),
						dataType : "json"
					}).done(function(data) {
						if(data.result > 0){
							alert("삭제 되었습니다.");
							deletedRows = [];
							grid1.resetData(data.list);
							grid2.resetData([]);
							//grid1.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					});
			    }
			}//delete 끝
		
		}
		else {
			alert("저장할 데이터가 없습니다.");
		} 
}); //save_btn1 끝
	//grid hover
	 	const grid = tui.Grid;
		grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				}); 
		
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
<%-- 	<%@include file="../bar/topbar.jsp"%> --%>
<!-- 	<div id="layoutSidenav"> -->
<%-- 		<%@include file="../bar/sidebar.jsp"%> --%>
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
							<button type="button" class="btn btn-secondary btn-sm" id="del_btn2">삭제</button>
							<button type="button" class="btn btn-secondary btn-sm" id="save_btn2">저장</button>
						</div>
					</div>
					<div>
						<div id="grid2"></div>
					</div>




				</div>
			</main>
			<%@include file="../bar/footer.jsp"%>
		</div>
<!-- 	</div> -->
	
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
<!-- 	<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" /> -->
<!-- 	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> -->

	<!-- Toast UI Grid Editing Module -->
<!-- 	<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/grid.css" /> -->
<!-- 	<script src="https://uicdn.toast.com/grid/latest/grid.js"></script> -->


</body>
</html>
