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
		el: document.getElementById('grid'),
		scrollX: false,
		scrollY: true,
		bodyHeight: 250,
		rowHeaders: [
			{
				type: 'rowNum',
				header: 'No.',
			}
		],
		columns: [
			{
				header: '년도',
				name: 'CRCLM_YEAR',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			}, {
				header: '분기',
				name: 'CRCLM_HALF_NM',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			},
			{
				header: '훈련과정명',
				name: 'CRCLM_CD_NM',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			},
			{
				header: '과목명',
				name: 'SBJCT_NM',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			},
			{
				header: '설문시작일',
				name: 'SCHDL_BGNG_DT',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			}, {
				header: '설문종료일',
				name: 'SCHDL_END_DT',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			}, {
				header: '개설여부',
				name: 'DGSTFN_OP_YN',
				align: 'center',
				sortable: true,
				sortingType: 'desc'
			}]
	});

	//surveyview
	var grid2 = new tui.Grid({
		el: document.getElementById('grid2'),
		scrollX: false,
		scrollY: true,
		bodyHeight: 160,
		rowHeaders: ['checkbox'],
		columns: [
			{
				header: '문항번호',
				name: 'DGSTFN_NO',
				width: 100,
				align: 'center',
				sortable: true,
				editor: 'text',
				validation: {
					validator: 'notEmpty',
					message: '문항번호는 필수 입력 항목입니다'
				}
			}, {
				header: '문항명',
				name: 'DGSTFN_CN',
				width: 850,
				sortable: true,
				editor: 'text'
			}, {
				header: '답변방식',
				name: 'QITEM_CD',
				sortable: true,
				align: 'center',
				copyOptions:  {
				useListItemText: true
				}, formatter: 'listItemText',
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
			, {
				header: 'CRCLM_CD',
				name: 'CRCLM_CD',
				hidden: true
			}
			, {
				header: 'CRCLM_YEAR',
				name: 'CRCLM_YEAR',
				hidden: true
			}
			, {
				header: 'CRCLM_HALF',
				name: 'CRCLM_HALF',
				hidden: true
			}
			, {
				header: 'SBJCT_NO',
				name: 'SBJCT_NO',
				hidden: true
			}]
	});

	var grid2_2 = new tui.Grid({
		el: document.getElementById('grid2_2'),
		scrollX: false,
		scrollY: true,
		bodyHeight: 160,
		width: '300px',
		rowHeaders: ['checkbox'],
		columns: [
			{
				header: '답변번호',
				name: 'CD_SORT_SN',
				width: 100,
				align: 'center',
				sortable: true,
				align: 'center',
				editor: 'text'
			}, {
				header: '답변명',
				name: 'CD_NM',
				sortable: true,
				align: 'center',
				editor: 'text'
			}]
	});

	var grid3 = new tui.Grid({
		el: document.getElementById('grid3'),
		scrollX: false,
		scrollY: true,
		bodyHeight: 160,
		rowHeaders: [
			{
				type: 'rowNum',
				header: 'No.',
			}
		],
		columns: [
			{
				header: '학번',
				name: 'STDNT_NO',
				width: 200,
				align: 'center',
				sortable: true,
				editor: 'text'
			}, {
				header: '학생명',
				name: 'KORN_FLNM',
				width: 200,
				align: 'center',
				sortable: true,
				editor: 'text'
			},
			{
				header: '전화번호',
				name: 'TELNO',
				width: 200,
				align: 'center',
				sortable: true,
				editor: 'text'
			},
			{
				header: 'CRCLM_CD',
				name: 'CRCLM_CD',
				hidden: true
			},
			{
				header: '년도',
				name: 'CRCLM_YEAR',
				width: 200,
				align: 'center',
				sortable: true
			},
			{
				header: '분기',
				name: 'CRCLM_HALF_NM',
				width: 200,
				align: 'center',
				sortable: true
			},
			{
				header: '과목명',
				name: 'SBJCT_NM',
				align: 'center',
				sortable: true
			},
			{
				header: '설문참여여부',
				name: 'DGSTFN_YN',
				width: 200,
				sortable: true,
				align: 'center',
				editor: 'text'
			}]
	});



	$("#tab1_btn").on('click', function() {
		$("#btn").show();
		$("#btn2").hide();
		const inputTags = $("tbody input, tbody textarea, tbody select");
		inputTags.each(function() {
			$(this).prop('disabled', true);
		});
	});
	$("#tab2_btn").on('click', function() {
		$("#btn").hide();
		$("#btn2").show();
		grid2.resetData([]);
		grid2_2.resetData([]);
	});
	$("#tab3_btn").on('click', function() {
		$("#btn").hide();
		$("#btn2").hide();
		grid3.resetData([]);
	});

	//전체리스트
	var s_CRCLM_YEAR = $("#s_CRCLM_YEAR").val(); //입력한년도
	$.post({
		url: "/surveyListAjax",
		dataType: "json",
		data: { "s_CRCLM_YEAR": s_CRCLM_YEAR }
	}).done(function(data) {
		grid.resetData(data.list);
	}).fail(function() {
		alert("문제가 발생했습니다.");
	});

	//조회버튼
	$("#search_btn").click(function() {
		//전역변수하면 안됨! (왜?)
		var s_CRCLM_YEAR = $("#s_CRCLM_YEAR").val(); //입력한년도
		var s_CRCLM_HALF = $('select[name=s_CRCLM_HALF]').val(); //상/하반기 선택
		var s_SBJCT_NM = $(".s_SBJCT_NM").val();
		var s_CRCLM_CD = $('select[name=s_CRCLM_CD_NM]').val();
		const inputTags = $("tbody input, tbody textarea, tbody select");
		inputTags.each(function() {
			$(this).prop('disabled', true);
		});

		if (s_CRCLM_YEAR == "") {
			alert("학년도 입력은 필수항목입니다.");
			return false;
		}
		else {
			$.post({
				url: "/surveyListAjax",
				dataType: "json",
				cache: false,
				data: {
					"s_CRCLM_YEAR": s_CRCLM_YEAR,
					"s_CRCLM_HALF": s_CRCLM_HALF,
					"s_SBJCT_NM": s_SBJCT_NM,
					"s_CRCLM_CD": s_CRCLM_CD
				}
			}).done(function(data) {
				grid.resetData(data.list)
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		}
	});



	//grid 행 클릭시    	
	grid.on('click', function(ev) {
		var rowKey = ev.rowKey; // 클릭한 행의 키값
		var rowData = grid.getRow(rowKey); // 클릭한 행의 데이터
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

		//사용자 입력불가능 칸
		$(".SBJCT_NM").prop('disabled', true);
		$(".CRCLM_NO").prop('disabled', true);
		$(".CRCLM_YEAR").prop('disabled', true);
		$(".CRCLM_HALF").prop('disabled', true);
		$(".crclmNameList").prop('disabled', true);
		$(".SCHDL_BGNG_DT").prop('disabled', true);
		$(".SCHDL_END_DT").prop('disabled', true);


		//클릭한 행의 정보들
		var CRCLM_CD = rowData.CRCLM_CD; //과정코드로 과정명 불러오기
		var SBJCT_NM = rowData.SBJCT_NM;
		var SBJCT_NO = rowData.SBJCT_NO; //수정 where절에 쓰기위함
		var CRCLM_NO = rowData.CRCLM_NO;
		var CRCLM_YEAR = rowData.CRCLM_YEAR; // 연도
		var CRCLM_HALF = rowData.CRCLM_HALF; // 상/하반기
		var DGSTFN_OP_YN = rowData.DGSTFN_OP_YN; //개설여부
		var sdate = rowData.SCHDL_BGNG_DT; // 시작일
		var fdate = rowData.SCHDL_END_DT; // 종료일
		var DGSTFN_TITLE = rowData.DGSTFN_TITLE;
		var DGSTFN_INTRO = rowData.DGSTFN_INTRO;; //안내문구	

		//아래행에 정보넣기
		$(".SBJCT_NM").val(SBJCT_NM);
		$(".CRCLM_NO").val(CRCLM_NO);
		$(".CRCLM_YEAR").val(CRCLM_YEAR);
		$(".CRCLM_HALF").val(CRCLM_HALF);
		$(".DGSTFN_OP_YN").val(DGSTFN_OP_YN);
		$(".SCHDL_BGNG_DT").val(sdate);
		$(".SCHDL_END_DT").val(fdate);
		$(".DGSTFN_TITLE").val(DGSTFN_TITLE);
		$(".DGSTFN_INTRO").val(DGSTFN_INTRO);
		$(".crclmNameList").val(CRCLM_CD);

		//문항정보
		$.post({
			url: "/surveyDetail",
			dataType: "json",
			data: {
				"CRCLM_CD": CRCLM_CD,
				"CRCLM_YEAR": CRCLM_YEAR,
				"CRCLM_HALF": CRCLM_HALF,
				"SBJCT_NO": SBJCT_NO
			}
		}).done(function(data) {
			detaillist = data.detaillist;
			grid2.refreshLayout();
			grid2.resetData(detaillist);
			var rowCount = grid2.getRowCount(); // grid 객체의 총 row 개수 구하기
			//문항갯수 23개 이상이면 신규버튼 불가능 
			if (rowCount >= 23) {
				$("#add_btn2").prop('disabled', true);
				$("#help").show();
				$("#help-o").hide();
			} else {
				$("#help").hide();
				$("#help-o").show();
			}
			grid2.disableColumn('DGSTFN_NO');
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});

		//참석자정보
		$.post({
			url: "/surveyStdnt",
			data: {
				"CRCLM_CD": CRCLM_CD,
				"CRCLM_YEAR": CRCLM_YEAR,
				"CRCLM_HALF": CRCLM_HALF,
				"SBJCT_NM": SBJCT_NM
			},
			dataType: "json"
		}).done(function(data) {
			stdntlist = data.stdntlist;
			grid3.resetData(stdntlist);
			grid3.refreshLayout();
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});



		//저장버튼	
		$("#save_btn").off().click(function() {
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

			//수정한값
			var u_DGSTFN_OP_YN = $(".DGSTFN_OP_YN").val();
			var rgdate = $(".DGSTFN_RGDATE").val();
			var u_DGSTFN_TITLE = $(".DGSTFN_TITLE").val();
			var u_DGSTFN_INTRO = $(".DGSTFN_INTRO").val();

			$.post({
				url: "/surveyUpdate",
				data: {
					"CRCLM_YEAR": CRCLM_YEAR,
					"CRCLM_HALF": CRCLM_HALF,
					"CRCLM_CD": CRCLM_CD,
					"SBJCT_NO": SBJCT_NO,
					"u_DGSTFN_OP_YN": u_DGSTFN_OP_YN,
					"u_DGSTFN_TITLE": u_DGSTFN_TITLE,
					"u_DGSTFN_INTRO": u_DGSTFN_INTRO,
					"s_CRCLM_YEAR": s_CRCLM_YEAR,
					"s_CRCLM_HALF": s_CRCLM_HALF,
					"s_SBJCT_NM": s_SBJCT_NM,
					"s_CRCLM_CD": s_CRCLM_CD
				},
				dataType: "json"
			}).done(function(data) {
				if (data.result == 1) { //수정된 사항이 없더라도 값이 들어가기때문에 항상 1
					alert("수정되었습니다.");
					grid.resetData(data.list);
					$("#save_btn").prop('disabled', true);

					const inputTags = $("tbody input, tbody textarea, tbody select");
					inputTags.each(function() {
						$(this).prop('disabled', true);
					});
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

		}); //저장버튼1 끝


		// 문항정보 신규 버튼
		$("#add_btn2").off().click(function()  {
			$(this).prop('disabled', true);
			grid2.appendRow(detaillist, { //상단에 detaillist을 전역변수로 선언해줘야함
				focus: true //포커스
			});
			var rowKey = grid2.getRowCount() - 1;
			grid2.enableCell(rowKey, 'DGSTFN_NO');
			//숨김컬럼 값 자동넣기
			grid2.setColumnValues("CRCLM_CD", CRCLM_CD, false);
			grid2.setColumnValues("CRCLM_YEAR", CRCLM_YEAR, false);
			grid2.setColumnValues("CRCLM_HALF", CRCLM_HALF, false);
			grid2.setColumnValues("SBJCT_NO", SBJCT_NO, false);

			//신규행 삭제(저장전)
			$("#del_btn2").off().click(function() {
				var selectedRows = grid2.getCheckedRows();// 선택된 행들의 정보를 가져옴
				if (selectedRows.length > 0) {
					// 선택된 행들의 rowKey 값을 추출하여 배열로 변환
					var rowKeys = selectedRows.map(function(row) {
						return row.rowKey;
					});
					// 선택된 행들을 삭제
					grid2.removeRows(rowKeys);
					$("#add_btn2").prop('disabled', false);
				} else {
					alert("행을 선택해주세요");
				}
			});

		});
	}); //grid.on 끝

	$("#tab2_btn").click(function() {
		$("#save_btn").prop('disabled', true);
		const inputTags = $("#btn2 button, #btn2_2 button");
		inputTags.each(function() {
			$(this).prop('disabled', true);
		});
	});
	$("#tab3_btn").click(function() {
		$("#save_btn").prop('disabled', true);
		const inputTags = $("#btn2 button, #btn2_2 button");
		inputTags.each(function() {
			$(this).prop('disabled', true);
		});
	});

	//문항정보 삭제
	$("#del_btn2").on('click', function() {
		var selectedRows = grid2.getCheckedRows();// 선택된 행들의 정보를 가져옴
		if (selectedRows.length > 0) {
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
	$('#save_btn2').on('click', function() {

		//필수값 입력하기 함수
		function checkRequiredValues() {
			if (DGSTFN_NO == "" || DGSTFN_NO == null) {
				alert("문항번호를 입력하세요");
				result = false;
			}
			else if (DGSTFN_CN == "" || DGSTFN_CN == null) {
				alert("문항명을 입력하세요");
				result = false;
			}
			else if (QITEM_CD == "" || QITEM_CD == null) {
				alert("답변방식을 선택하세요");
				result = false;
			}
			else {
				result = true;
			}
			return result;
		};
		var modifiedRows = [];
		modifiedRows = grid2.getModifiedRows(); //추가/수정/삭제된 값 
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
		var createdRows = [];
		createdRows = modifiedRows[0].createdRows;

		//수정한 행의 정보
		var updatedRows = modifiedRows[0].updatedRows;
		//삭제한 행의 정보
		var deletedRows = modifiedRows[0].deletedRows;


		if (createdRows.length > 0 || updatedRows.length > 0 || deletedRows.length > 0) {
			//신규값이 있는경우 
			if (createdRows.length > 0) {
				var createdData = [];
				createdData = createdRows.map(function(row) {
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
				});

				var DGSTFN_NO = createdData[0].DGSTFN_NO;
				var QITEM_CD = createdData[0].QITEM_CD;
				var DGSTFN_CN = createdData[0].DGSTFN_CN;
				var CRCLM_CD = createdData[0].CRCLM_CD;
				var CRCLM_YEAR = createdData[0].CRCLM_YEAR;
				var CRCLM_HALF = createdData[0].CRCLM_HALF;
				var SBJCT_NO = createdData[0].SBJCT_NO;

				if (!checkRequiredValues()) { //boolean
					return false;
				}

				//추가한정보 삽입 
				$.post({
					url: "/ITEMCreate",
					data: {
						"DGSTFN_NO": DGSTFN_NO,
						"QITEM_CD": QITEM_CD,
						"DGSTFN_CN": DGSTFN_CN,
						"CRCLM_CD": CRCLM_CD,
						"CRCLM_YEAR": CRCLM_YEAR,
						"CRCLM_HALF": CRCLM_HALF,
						"SBJCT_NO": SBJCT_NO
					},
					dataTyp: "json"
				}).done(function(data) {
					if (data.result == "exist") {
						alert("이미 등록된 번호입니다.");
					} else if (data.result == 1) {
						alert("(신규)저장되었습니다.");

						var rowKey = grid2.getRowCount() - 1;
						grid2.disableCell(rowKey, 'DGSTFN_NO');
						grid2.resetData([]);
						//createdRows = [];
						grid2.refreshLayout();
						grid2_2.resetData([]);
						const inputTags_c = $("#btn2 button");
						inputTags_c.each(function() {
							$(this).prop('disabled', true);
						});
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}//신규 끝

			if (updatedRows.length > 0) {
				var updateData = []; //수정된행의 모든정보
				alert("updatedRows.length:"+updatedRows.length);
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
					/*if (!checkRequiredValues()) { //boolean
						return false;
					}*/
				}
				$.post({
					url: "/ITEMUpdate",
					contentType: 'application/json;charset=UTF-8',
					data: JSON.stringify(updateData),
					dataType: "json"
				}).done(function(data) {
					if (data.result > 0) {
						alert("수정 되었습니다.");
						updatedRows = [];
						grid2.refreshLayout();
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
			//삭제
			if (deletedRows.length > 0) {

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
					url: "/ITEMDelete",
					contentType: 'application/json;charset=UTF-8',
					data: JSON.stringify(deleteData),
					dataType: "json"
				}).done(function(data) {
					if (data.result > 0) {
						alert("삭제 되었습니다.");
						deletedRows = [];
						grid2.refreshLayout();
						grid2_2.resetData([]);
						const inputTags_c = $("#btn2 button");
						inputTags_c.each(function() {
							$(this).prop('disabled', true);
						});
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


	//문항정보 클릭시(답변정보)
	grid2.on('click', function(ev) {

		var rowKey = ev.rowKey; // 클릭한 행의 키값
		var rowData = grid2.getRow(rowKey); // 클릭한 행의 데이터
		//신규행 클릭한 경우는 제외하기
		if (rowData.QITEM_CD != null && rowData.QITEM_CD != '') {
			var QITEM_CD = rowData.QITEM_CD;
			const inputTags = $("#btn2_2 button");
			inputTags.each(function() {
				$(this).prop('disabled', false);
			});

			if (QITEM_CD == '0010') { //객관
				$.post({
					url: "/surveyANS",
					dataType: "json",
					data: {
						"QITEM_CD": QITEM_CD
					}
				}).done(function(data) {
					var anslist = data.anslist;
					grid2_2.refreshLayout();
					grid2_2.resetData(anslist);
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
			}
			else if (QITEM_CD == '0020') {
				const inputTags = $("#btn2_2 button");
				inputTags.each(function() {
					$(this).prop('disabled', true);
				});
				grid2_2.resetData([]);
			}
		}
	});

});