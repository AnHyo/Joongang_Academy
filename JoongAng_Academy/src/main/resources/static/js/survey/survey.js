$(function() {
	var detaillist = "";
	
		//grid hover
		const Grid = tui.Grid;
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				}); 
				
	//공백제거
	$("input").on("input", function() {
		var inputVal = $(this).val().trim();
		$(this).val(inputVal);
	});
	
	//숫자만 입력
	$("input[numberOnly], [name=DGSTFN_NO]").on("input", function() {
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
	});
	
	
	//keydown함수 : 키보드가 눌렸을때 실행되는 함수
	//keyCode == 13 : '엔터키'
	$(".s_SBJCT_NM").keydown(function(key) {
		if (key.keyCode == 13) {
	        $("#search_btn").click();
	    }
	});
	$(".s_CRCLM_YEAR").keydown(function(key) {
		if (key.keyCode == 13) {
	        $("#search_btn").click();
	    }
	});
	
		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			scrollX : false,
			scrollY : true,
			bodyHeight : 250,
			 rowHeaders: [
			        {
			            type: 'rowNum',
			            header: 'No.',
			        }
			    ],
			columns : [ 
			{
				header : '년도',
				name : 'CRCLM_YEAR',
				width: 70,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '분기',
				name : 'CRCLM_HALF_NM',
				width: 60,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			}, 
			{
				header : '훈련과정명',
				name : 'CRCLM_CD_NM',
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			}, 
			{
				header : '과목명',
				name : 'SBJCT_NM',
				width: 150,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			},
			{
				header : '등록일자',
				name : 'DGSTFN_RGDATE',
				width: 110,
				editor: {
					type: 'datePicker',
					options: {
						formate: 'yyyy-MM-dd'
					}
				},
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '설문시작일',
				name : 'DGSTFN_SDATE',
				width: 110,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			}, {
				header : '설문종료일',
				name : 'DGSTFN_FDATE',
				width: 110,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			},{
				header : '개설여부',
				name : 'DGSTFN_OP_YN',
				width: 40,
				align : 'center',
				sortable: true,
			    sortingType: 'desc'
			}]
		});
		
		//surveyview
		var grid2 = new tui.Grid({
			el : document.getElementById('grid2'),
			scrollX : false,
			scrollY : true,
			//bodyHeight : 377,
			bodyHeight : 160,
			rowHeaders : [ 'checkbox' ],
			columns : [ 
				{
					header : '문항번호',
					name : 'DGSTFN_NO',
					width: 100,
					align : 'center',
					sortable: true,
					editor: 'text',
					 validation: {
		                validator: 'notEmpty',
		                message: '문항번호는 필수 입력 항목입니다'
		            }
				}, {
					header : '문항명',
					name : 'DGSTFN_CN',
					width: 850,
					sortable: true,
					editor: 'text'
				}, {
					header : '답변방식',
					name : 'QITEM_CD',
					sortable: true,
					align : 'center',
					copyOptions:{
						 useListItemText: true
					},formatter: 'listItemText',
			          editor: {
			              type: 'radio',
			              options: {
			                listItems: [
			                  { text: '객관식', value: '0010' },
			                  { text: '주관식', value: '0020' }
			                ]
			              }
			            }
				}
				,{
					header : 'CRCLM_CD',
					name : 'CRCLM_CD',
					hidden: true
				}
				,{
					header : 'CRCLM_YEAR',
					name : 'CRCLM_YEAR',
					hidden: true
				}
				,{
					header : 'CRCLM_HALF',
					name : 'CRCLM_HALF',
					hidden: true
				}
				,{
					header : 'SBJCT_NO',
					name : 'SBJCT_NO',
					hidden: true
				}
				/*, {
					header : '답변허용갯수',
					name : 'DGSTFN_ANS_N',
					width: 100,
					align : 'center',
					editor: 'text'
				}*/ //CRCLM_CD, CRCLM_YEAR, CRCLM_HALF, SBJCT_NO
				]
		});
		
		var grid2_2 = new tui.Grid({
			el : document.getElementById('grid2_2'),
			scrollX : false,
			scrollY : true,
			bodyHeight : 160,
			width : '300px',
			rowHeaders : [ 'checkbox' ],
			columns : [ 
				{
					header : '답변번호',
					name : 'CD_SORT_SN',
					width: 100,
					align : 'center',
					sortable: true,
					align : 'center',
					editor: 'text'
				}, {
					header : '답변명',
					name : 'CD_NM',
					sortable: true,
					align : 'center',
					editor: 'text'
				}]
		});
		
		var grid3 = new tui.Grid({
			el : document.getElementById('grid3'),
			scrollX : false,
			scrollY : true,
			bodyHeight : 160,
			 rowHeaders: [
			        {
			            type: 'rowNum',
			            header: 'No.',
			        }
			    ],
			columns : [  
				{
					header : '학번',
					name : 'STDNT_NO',
					width: 200,
					align : 'center',
					sortable: true,
					editor: 'text'
				}, {
					header : '학생명',
					name : 'KORN_FLNM',
					width: 200,
					align : 'center',
					sortable: true,
					editor: 'text'
				}, 
				{
					header : '전화번호',
					name : 'TELNO',
					width: 200,
					align : 'center',
					sortable: true,
					editor: 'text'
				}, 
				{
					header : 'CRCLM_CD',
					name : 'CRCLM_CD',
					hidden: true
				},
				{
					header : '년도',
					name : 'CRCLM_YEAR',
					width: 200,
					align : 'center',
					sortable: true
				},
				{
					header : '분기',
					name : 'CRCLM_HALF_NM',
					width: 200,
					align : 'center',
					sortable: true
				},
				{
					header : '과목명',
					name : 'SBJCT_NM',
					align : 'center',
					sortable: true
				},
				{
					header : '설문참여여부',
					name : 'DGSTFN_YN',
					width: 200,
					sortable: true,
					align : 'center',
					editor: 'text'
				}]
		});
		
		
		
		$("#tab1_btn").on('click',function(){
			$("#btn").show();
			$("#btn2").hide();
			 const inputTags = $("tbody input, tbody textarea, tbody select");
			inputTags.each(function() {
			 	 $(this).prop('disabled', true);
			});
		});
		$("#tab2_btn").on('click',function(){
			$("#btn").hide();
			$("#btn2").show();
			grid2.resetData([]);
			grid2_2.resetData([]);
		});
		$("#tab3_btn").on('click',function(){
			$("#btn").hide();
			$("#btn2").hide();
			grid3.resetData([]);
		});
		
		//전체리스트
		var s_CRCLM_YEAR = $("#s_CRCLM_YEAR").val(); //입력한년도
		$.post({
			url : "/surveyListAjax",
			dataType : "json",
				data : { "s_CRCLM_YEAR" : s_CRCLM_YEAR}
			}).done(function(data) {
				grid.resetData(data.list);
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		
		//조회버튼
		$("#search_btn").click(function(){
			//전역변수하면 안됨! (왜?)
			var s_CRCLM_YEAR = $("#s_CRCLM_YEAR").val(); //입력한년도
			var s_CRCLM_HALF = $('select[name=s_CRCLM_HALF]').val(); //상/하반기 선택
			var s_SBJCT_NM = $(".s_SBJCT_NM").val(); 
			var s_CRCLM_CD = $('select[name=s_CRCLM_CD_NM]').val(); //과정현황 선택
//  			alert("s_CRCLM_YEAR:"+s_CRCLM_YEAR);//ok
//  			alert("s_CRCLM_HALF:"+s_CRCLM_HALF);//ok
//  			alert("s_SBJCT_NM:"+s_SBJCT_NM);//ok
//  			alert("s_CRCLM_CD:"+s_CRCLM_CD);//ok
			const inputTags = $("tbody input, tbody textarea");
			inputTags.each(function() {
			 	 $(this).prop('disabled', true);
			});
			
			if (s_CRCLM_YEAR == "") {
				alert("학년도 입력은 필수항목입니다.");
				return false;
			}
			else {
				$.post({
					url : "/surveyListAjax",
					dataType : "json",
					cache : false,
					data : {
						"s_CRCLM_YEAR" : s_CRCLM_YEAR,
						"s_CRCLM_HALF" : s_CRCLM_HALF,
						"s_SBJCT_NM" : s_SBJCT_NM,
						"s_CRCLM_CD" : s_CRCLM_CD
					}
				}).done(function(data) {
					//var list = data.list;
					//검색값 있는경우
					/*if(s_CRCLM_HALF != null || s_SBJCT_NM != null || s_CRCLM_CD != null){
						if(list == ""){
							alert("조회결과가 없습니다."); 
							return false;
						}
						else {
				  	  		grid.resetData(data.list)
				  			//alert("조회되었습니다."); //ok
						}
					}
					//전체리스트 조회
					else {*/
				  	  		grid.resetData(data.list)
					//}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				}); 
			}
		});
		
			
			
		//grid 행 클릭시    	
		grid.on('click', function(ev) {

			var rowKey = ev.rowKey; // 클릭한 행의 키값
			var rowData = grid.getRow(rowKey); // 클릭한 행의 데이터
			//alert("rowKey:"+rowKey);//ok
			//alert("rowData:"+JSON.stringify(rowData));//ok
			
			grid2_2.resetData([]);
			
			//저장버튼 활성화
			$("#save_btn").prop('disabled', false);
			//input 활성화
 			const inputTags = $("tbody input, tbody textarea, tbody select, #btn2 button");
			inputTags.each(function() {
			 	 $(this).prop('disabled', false);
			});
			//답변정보 disabled
			const inputTags2 = $("#btn2_2 button");
			inputTags2.each(function() {
			 	 $(this).prop('disabled', true);
			});
				
			//사용자 입력칸 입력가능
			$(".SBJCT_NM").prop('disabled', true);
			$(".CRCLM_NO").prop('disabled', true);
			$(".CRCLM_YEAR").prop('disabled', true); 
			$(".CRCLM_HALF").prop('disabled', true); 
			$(".crclmNameList").prop('disabled', true); 
			
			
			//클릭한 행의 정보들
			var CRCLM_CD = rowData.CRCLM_CD; //과정코드로 과정명 불러오기
			var SBJCT_NM = rowData.SBJCT_NM; 
			var SBJCT_NO = rowData.SBJCT_NO; //수정 where절에 쓰기위함
			var CRCLM_NO = rowData.CRCLM_NO; 
			var CRCLM_YEAR = rowData.CRCLM_YEAR; // 연도
			var CRCLM_HALF = rowData.CRCLM_HALF; // 상/하반기
			var DGSTFN_OP_YN = rowData.DGSTFN_OP_YN; //개설여부
			var rgdate = rowData.DGSTFN_RGDATE; // 등록일
			var sdate = rowData.DGSTFN_SDATE; // 시작일
			var fdate = rowData.DGSTFN_FDATE; // 종료일
			var DGSTFN_TITLE = rowData.DGSTFN_TITLE;			
			var DGSTFN_INTRO = rowData.DGSTFN_INTRO;; //안내문구	
			//var CRCLM_NM = rowData.CRCLM_CD_NM;	
			//alert(CRCLM_NM);
			//날짜포맷( "-"를 구분자 넣기) //if로 예외처리함
			if(rgdate != null){
				var DGSTFN_RGDATE = rgdate.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");
			}
			if(sdate != null){
				var DGSTFN_SDATE = sdate.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");
			}
			if(fdate != null){
				var DGSTFN_FDATE = fdate.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");
			}
			//아래행에 정보넣기
			$(".SBJCT_NM").val(SBJCT_NM);
			$(".CRCLM_NO").val(CRCLM_NO);
			$(".CRCLM_YEAR").val(CRCLM_YEAR);
			$(".CRCLM_HALF").val(CRCLM_HALF);
			$(".DGSTFN_OP_YN").val(DGSTFN_OP_YN);
			$(".DGSTFN_RGDATE").val(DGSTFN_RGDATE);
			$(".DGSTFN_SDATE").val(DGSTFN_SDATE);
			$(".DGSTFN_FDATE").val(DGSTFN_FDATE);
			$(".DGSTFN_TITLE").val(DGSTFN_TITLE);
			$(".DGSTFN_INTRO").val(DGSTFN_INTRO);
			$(".crclmNameList").val(CRCLM_CD);
// 			alert("CRCLM_CD:"+rowData.CRCLM_CD);//ok
// 			alert("CRCLM_YEAR:"+rowData.CRCLM_YEAR);//ok
// 			alert("CRCLM_HALF:"+rowData.CRCLM_HALF);//ok
//			alert("DGSTFN_RGDATE:"+rowData.DGSTFN_RGDATE);//ok
//			alert(SBJCT_NO);//0001

			//문항정보
			$.post({
			url : "/surveyDetail",
			dataType : "json",
			data : { 
					"CRCLM_CD" : CRCLM_CD,
					"CRCLM_YEAR" : CRCLM_YEAR,
					"CRCLM_HALF" : CRCLM_HALF,
					"SBJCT_NO" : SBJCT_NO
					}
			}).done(function(data) {
				detaillist = data.detaillist;
				grid2.refreshLayout();
				grid2.resetData(detaillist);
				grid2.disableColumn('DGSTFN_NO');
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		
		//참석자정보
		 $.post({
			url : "/surveyStdnt",
			data: {
				"CRCLM_CD" : CRCLM_CD,
				"CRCLM_YEAR" : CRCLM_YEAR,
				"CRCLM_HALF" : CRCLM_HALF,
				"SBJCT_NM" : SBJCT_NM
				//"SBJCT_NO" : SBJCT_NO
			    },
			dataType : "json"
		}).done(function(data) {
			stdntlist = data.stdntlist;
			grid3.resetData(stdntlist);
			grid3.refreshLayout();
		}).fail(function() {
			alert("문제가 발생했습니다.");
		}); 
		
		
		
		
		
	//저장버튼	
 	//$("#save_btn").on.("click",function(){ //grid 클릭한수만큼 '수정완료' alert뜸!
	$("#save_btn").off().click(function(){
		//검색정보
		var s_CRCLM_YEAR = $("#s_CRCLM_YEAR").val(); //입력한년도
		var s_CRCLM_HALF = $('select[name=s_CRCLM_HALF]').val(); //상/하반기 선택
		var s_SBJCT_NM = $(".s_SBJCT_NM").val(); 
		var s_CRCLM_CD = $('select[name=s_CRCLM_CD_NM]').val(); //과정현황 선택
		
		//기준값
		var CRCLM_YEAR = $(".CRCLM_YEAR").val();
		var CRCLM_HALF = $(".CRCLM_HALF").val();
		var CRCLM_CD = rowData.CRCLM_CD; //과정코드로 과정명 불러오기
		var SBJCT_NO = rowData.SBJCT_NO; //수정 where절에 쓰기위함
// 		alert("CRCLM_YEAR:"+CRCLM_YEAR);//ok
// 		alert("CRCLM_HALF:"+CRCLM_HALF);//ok
// 		alert("CRCLM_CD:"+CRCLM_CD);//ok
// 		alert("SBJCT_NO:"+SBJCT_NO);//ok
		
		//수정한값
		var u_DGSTFN_OP_YN = $(".DGSTFN_OP_YN").val();
		var rgdate= $(".DGSTFN_RGDATE").val();
		var sdate = $(".DGSTFN_SDATE").val();
		var fdate = $(".DGSTFN_FDATE").val();
		var u_DGSTFN_TITLE = $(".DGSTFN_TITLE").val();
		var u_DGSTFN_INTRO = $(".DGSTFN_INTRO").val();
// 		alert("u_DGSTFN_RGDATE:"+u_DGSTFN_RGDATE);//ok
// 		alert("u_DGSTFN_SDATE:"+u_DGSTFN_SDATE);//ok
// 		alert("u_DGSTFN_FDATE:"+u_DGSTFN_FDATE);//ok
// 		alert("u_DGSTFN_TITLE:"+u_DGSTFN_TITLE);//ok

		if(rgdate != "" && sdate != ""){
			if(rgdate > sdate){
				alert("시작일이 등록일보다 이전입니다.");
		    	$(".DGSTFN_SDATE").val("");
		    	return false;
		    }
		}
			
		//시작일만 입력된경우
		if(sdate != ""){
			if(fdate == ""){
				alert("설문종료일을 입력해주세요.");
				return false;
			}
			if (fdate < sdate) {
				alert("종료일이 시작일보다 이전입니다.");
				$(".DGSTFN_FDATE").val("");
				return false;
			  }
			}
		//종료일만 입력된경우
		if(fdate != ""){
			if(sdate == ""){
				alert("설문시작일을 입력해주세요.");
				return false;
			}
		}
				
		//날짜포맷
		var u_dgstfn_rgdate = rgdate.split("-").join(",");
		var u_DGSTFN_RGDATE = u_dgstfn_rgdate.replace(/,/g, '');
		
		var u_dgstfn_sdate = sdate.split("-").join(",");
		var u_DGSTFN_SDATE = u_dgstfn_sdate.replace(/,/g, '');
		
		var u_dgstfn_fdate = fdate.split("-").join(",");
		var u_DGSTFN_FDATE = u_dgstfn_fdate.replace(/,/g, '');
		
// 		alert(u_DGSTFN_RGDATE);//ok //20220404
// 		alert(u_DGSTFN_SDATE); //ok
// 		alert(u_DGSTFN_FDATE);//ok
		
		 $.post({
			url : "/surveyUpdate",
			data: {
				"CRCLM_YEAR" :CRCLM_YEAR,
				"CRCLM_HALF" :CRCLM_HALF,
				"CRCLM_CD" :CRCLM_CD,
				"SBJCT_NO" :SBJCT_NO,
				"u_DGSTFN_RGDATE" :u_DGSTFN_RGDATE,
				"u_DGSTFN_OP_YN" :u_DGSTFN_OP_YN,
				"u_DGSTFN_TITLE":u_DGSTFN_TITLE,
				"u_DGSTFN_SDATE":u_DGSTFN_SDATE,
				"u_DGSTFN_FDATE":u_DGSTFN_FDATE,
				"u_DGSTFN_INTRO":u_DGSTFN_INTRO,
				"s_CRCLM_YEAR":s_CRCLM_YEAR,
				"s_CRCLM_HALF":s_CRCLM_HALF,
				"s_SBJCT_NM":s_SBJCT_NM,
				"s_CRCLM_CD":s_CRCLM_CD
			    },
			dataType : "json"
		}).done(function(data) {
			//alert(data.result); //0
			if(data.result == 1){ //수정된 사항이 없더라도 값이 들어가기때문에 항상 1
				alert("수정되었습니다.");
				grid.resetData(data.list);
				//grid.focus(rowKey);
				
				$("#save_btn").prop('disabled',true);
				
				const inputTags = $("tbody input, tbody textarea, tbody select");
				inputTags.each(function() {
				 	 $(this).prop('disabled', true);
				});
			}
				//grid.focus(createdRows[0].rowKey); //안됨. 마지막로우가 포커스됨
		}).fail(function() {
			alert("문제가 발생했습니다.");
		}); 	
			
	}); //저장버튼1 끝
	
	
	
	// 문항정보 신규 버튼
	$("#add_btn2").off().click(function(){
		$(this).prop('disabled', true);
		grid2.appendRow(detaillist, { //상단에 detaillist을 전역변수로 선언해줘야함
			focus : true //포커스
		});
		 var rowKey = grid2.getRowCount() - 1;
		 grid2.enableCell(rowKey, 'DGSTFN_NO');
		 //숨김컬럼 값 자동넣기
		 grid2.setColumnValues("CRCLM_CD", CRCLM_CD, false);
		 grid2.setColumnValues("CRCLM_YEAR", CRCLM_YEAR, false);
		 grid2.setColumnValues("CRCLM_HALF", CRCLM_HALF, false);
		 grid2.setColumnValues("SBJCT_NO", SBJCT_NO, false);
	
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
			 $("#add_btn2").prop('disabled', false);
			} else {
				alert("행을 선택해주세요");
			}
		});
	
	});
	
		
		
	
}); //grid.on 끝
	
	$("#tab2_btn").click(function(){
		$("#save_btn").prop('disabled',true);
		const inputTags = $("#btn2 button, #btn2_2 button");
		inputTags.each(function() {
			$(this).prop('disabled', true);
		});
	});
	$("#tab3_btn").click(function(){
		$("#save_btn").prop('disabled',true);
		const inputTags = $("#btn2 button, #btn2_2 button");
		inputTags.each(function() {
			$(this).prop('disabled', true);
		});
	});
	
	//문항정보 삭제
	//var deletedRows = [];
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
	
	// 문항정보 저장 버튼(추가,수정,삭제)
	$('#save_btn2').on('click', function(){
		//필수값 입력하기 함수
		function checkRequiredValues(){
			if(DGSTFN_NO == "" || DGSTFN_NO == null){
				alert("문항번호를 입력하세요");
				result = false;
			}
			else if(DGSTFN_CN == "" || DGSTFN_CN == null){
				alert("문항명을 입력하세요");
				result = false;
			}
			else if(QITEM_CD == "" || QITEM_CD == null){
				alert("답변방식을 선택하세요");
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

		
		//신규추가한 행의 정보 
		var createdRows = modifiedRows[0].createdRows;
		var createdData = createdRows.map(function(row) {
			//필수값 입력하기
			/*if(row.DGSTFN_NO == "" || row.DGSTFN_NO == null){
				alert("문항번호를 입력하세요");
				return false;
			}
			else if(row.DGSTFN_CN == "" || row.DGSTFN_CN == null){
				alert("문항명을 입력하세요");
				return false;
			}
			else if(row.QITEM_CD == "" || row.QITEM_CD == null){
				alert("답변방식을 선택하세요");
				return false;
			}
			else{*/
			    return {
			        DGSTFN_NO: row.DGSTFN_NO, // = SORT_SN
			        QITEM_CD: row.QITEM_CD, //0010, 0020
			        DGSTFN_CN: row.DGSTFN_CN,
					//숨긴컬럼 정보
			        CRCLM_CD: row.CRCLM_CD,
			        CRCLM_YEAR: row.CRCLM_YEAR,
			        CRCLM_HALF: row.CRCLM_HALF,
			        SBJCT_NO: row.SBJCT_NO
			    }
		//	}
		});
		//alert("createdData:" + JSON.stringify(createdData)); //ok
		//alert("data:" + JSON.stringify(data)); //ok
		//alert("createdRows.length:" + createdRows.length); //ok
		
	
	//수정한 행의 정보
	var updatedRows = modifiedRows[0].updatedRows;
	//alert("updatedRows.length:" + updatedRows.length); //ok
	//삭제한 행의 정보
	var deletedRows = modifiedRows[0].deletedRows;
	
	
	if(createdRows.length > 0 || updatedRows.length > 0 || deletedRows.length > 0){
		//if(createdRows && createdRows.length > 0){	
		//신규값이 있는경우 
		if(createdRows.length > 0){	
			var DGSTFN_NO = createdData[0].DGSTFN_NO;
			var QITEM_CD = createdData[0].QITEM_CD;
			var DGSTFN_CN = createdData[0].DGSTFN_CN;
			var CRCLM_CD = createdData[0].CRCLM_CD;
			var CRCLM_YEAR = createdData[0].CRCLM_YEAR;
			var CRCLM_HALF = createdData[0].CRCLM_HALF;
			var SBJCT_NO = createdData[0].SBJCT_NO;
			
			if(!checkRequiredValues()){ //boolean
		           return false;
		    }

			//추가한정보 삽입 
			$.post({
				url : "/ITEMCreate",
				data: {
					"DGSTFN_NO" :DGSTFN_NO,
					"QITEM_CD":QITEM_CD,
					"DGSTFN_CN":DGSTFN_CN,
					"CRCLM_CD" : CRCLM_CD,
					"CRCLM_YEAR" : CRCLM_YEAR,
					"CRCLM_HALF" : CRCLM_HALF,
					"SBJCT_NO" : SBJCT_NO
				    },
				dataType : "json"
			}).done(function(data) {
				if(data.result == 1){
					alert("(신규)저장되었습니다.");
					//grid.resetData(data.list);
					//createdData = [];
					grid2.refreshLayout();
					//grid2.resetData(data.detaillist);
					//$("#save_btn2").prop('disabled', true);
					//$("#save_btn2").prop('disabled', false);
					 var rowKey = grid2.getRowCount() - 1;
				    grid2.disableCell(rowKey, 'DGSTFN_NO');

					const inputTags_c = $("#btn2 button");
					inputTags_c.each(function() {
				 			$(this).prop('disabled', false);
					});
					//$("#del_btn2_2").prop('disabled', true);
					//grid2.focus(createdRows[0].rowKey); //안됨. 마지막로우가 포커스됨
				} 
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		}//신규 끝
		
		if(updatedRows.length > 0){
				var updateData = []; //수정된행의 모든정보
			    for (var i = 0; i < updatedRows.length; i++) {
			      var row = updatedRows[i];
			      updateData.push({
			        DGSTFN_NO: row.DGSTFN_NO,
			        QITEM_CD: row.QITEM_CD,
			        DGSTFN_CN: row.DGSTFN_CN,
			        CRCLM_CD: row.CRCLM_CD,
			        CRCLM_YEAR: row.CRCLM_YEAR,
			        CRCLM_HALF: row.CRCLM_HALF,
			        SBJCT_NO: row.SBJCT_NO
			      });
			if(!checkRequiredValues()){ //boolean
			           return false;
			}
		}

				//alert("updateData:"+JSON.stringify(updateData)); //ok
				$.post({
					url : "/ITEMUpdate",
					    contentType: 'application/json;charset=UTF-8',
					    data: JSON.stringify(updateData),
						dataType : "json"
				}).done(function(data) {
					if(data.result > 0){
						alert("수정 되었습니다.");
						updatedRows = [];
						grid2.refreshLayout();
						//grid2.resetData(data.detaillist);
						
						/*const inputTags_u = $("#btn2 button");
						inputTags_u.each(function() {
				 			$(this).prop('disabled', true);
						});*/
						//grid2.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
			//삭제
			if(deletedRows.length > 0){
				
			    var deleteData = []; //삭제된행의 모든정보
			    for (var i = 0; i < deletedRows.length; i++) {
			      var row = deletedRows[i];
			      deleteData.push({
			        DGSTFN_NO: row.DGSTFN_NO,
			        QITEM_CD: row.QITEM_CD,
			        DGSTFN_CN: row.DGSTFN_CN,
			        CRCLM_CD: row.CRCLM_CD,
			        CRCLM_YEAR: row.CRCLM_YEAR,
			        CRCLM_HALF: row.CRCLM_HALF,
			        SBJCT_NO: row.SBJCT_NO
			      });
			    }
				
				$.post({
					url : "/ITEMDelete",
					    contentType: 'application/json;charset=UTF-8',
					    data: JSON.stringify(deleteData),
					dataType : "json"
				}).done(function(data) {
					if(data.result > 0){
						alert("삭제 되었습니다.");
						deletedRows = [];
						grid2.refreshLayout();
						grid2_2.resetData([]);
						//grid1.focus(updatedRows[0].rowKey); //안됨. 마지막로우가 포커스됨
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
		}//delete 끝
		
		
	} //전체if 끝
	else {
			alert("저장할 데이터가 없습니다.");
		} 
	
}); //save_btn2 끝
	
	
	
	/*// 답변정보 신규 버튼
	$("#add_btn2_2").click(function(){
	    grid2_2.prependRow();
		
	    var rowKey = grid2_2.getRowCount() - 1;
	    grid2_2.enableCell(rowKey, 'CD_CLSF');
	    grid2_2.enableCell(rowKey, 'CD');
	    $(this).addClass("disabled"); 
	});*/
	
	//문항정보 클릭시(답변정보)
	grid2.on('click', function(ev) {
	
		var rowKey = ev.rowKey; // 클릭한 행의 키값
		var rowData = grid2.getRow(rowKey); // 클릭한 행의 데이터
		//alert("rowKey:"+rowKey);
		//alert("rowData:"+JSON.stringify(rowData)); //신규행을 클릭시 모든 문항정보의 정보가 다뜸
		//신규행 클릭한 경우는 제외하기
		if(rowData.QITEM_CD != null && rowData.QITEM_CD !=''){
		var QITEM_CD = rowData.QITEM_CD;
		//alert(rowData.CRCLM_YEAR); //숨김컬럼 //ok
		const inputTags = $("#btn2_2 button");
		inputTags.each(function() {
			$(this).prop('disabled', false);
		});
		
			if(QITEM_CD == '0010'){ //객관
			
				$.post({
				url : "/surveyANS",
				dataType : "json",
				data : { 
						"QITEM_CD" : QITEM_CD
						}
				}).done(function(data) {
					var anslist = data.anslist;
					grid2_2.refreshLayout();
					grid2_2.resetData(anslist);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
			else if(QITEM_CD == '0020'){
				//alert("답변방식이 주관식입니다.");
				const inputTags = $("#btn2_2 button");
				inputTags.each(function() {
					$(this).prop('disabled', true);
				});
				grid2_2.resetData([]);
			}
		}
	});
	

		
});