//학생검색
$(function(){
	
		// 조회 버튼 클릭
		$(document).off("click","#infoSearch").on("click","#infoSearch",function(){
			$("#StuInfoModal").modal("show");
			
			//조회버튼 선택시
			$(document).off("click",'#stuInfoShow').on("click",'#stuInfoShow', function(){
				if($("#numName").val() == "" || $("#numName").val() < 1){
					alert("이름(학번)을 1글자 이상 입력해 주세요.");
				} else {
					$("#stuInfoChoose").attr("disabled", false);
					var numName = $.trim($("#numName").val());
					var courseNum = $("#courseNum").text();
					var statusA = $("select[name='statusA'] option:selected").val();
					
						$.post({
							url : "/studentInfoSearch",
							data:{
								"numName" : numName,
								"courseNum" : courseNum,
								"statusA" : statusA
							},
							cache : false,
							dataType : "json"
						}).done(function(data){
							var result = data.stulist;
							grid.resetData(result);
							let selectedRowKey = null;
							grid.on('focusChange', (ev) => {
								grid.setSelectionRange({
									start: [ev.rowKey, 0],
									end: [ev.rowKey, grid.getColumns().length]
								});
							});
							
							grid.on('click', () => {
								$(document).off("click", "#stuInfoChoose").on("click", "#stuInfoChoose", function(){
									var rowKey = grid.getFocusedCell().rowKey;
									var obj = grid.getRow(rowKey);
									var keys = Object.values(obj);
									var student_ID = keys[0];
									var student_Name = keys[1];

									$.post({
										url: "/studentDeInfo",
										data: {
											"student_ID": student_ID
										},
										cache: false,
										dataType: "json"
									}).done(function(data) {
										var list = data.list[0];
										var elist = data.elist;
										enrolGrid.resetData(elist);
										
										var tel = list.TELNO;
										var etel = list.REL_TELNO;
										var rel = list.REL_CD;
										var name = list.KORN_FLNM;
										var email = list.EML_ADDR;
										var postNum = list.ZIP;
										var addr = list.ADDR;
										var age = list.AGE;
										var deaddr = list.DADDR;
										
										var list2 = data.list2[0];
										var birthday = list2.USER_BRDT;
										var eduname = list2.CRCLM_CD_NAME;
										var sex =  list2.GENDER_CD_NAME;
										var situation = list2.CRCLM_YEAR;
										var quarter = list2.CRCLM_HALF_NAME;
										
										$("#nameNumInfo").text(student_ID);
										$("#nameNumInput").val(student_Name);
										$("#StudentID").val(student_ID);
										$("#telInfo").val(tel);
										$("#emerTel").val(etel);
										$('#relation option[value="'+rel+'"]').prop('selected', true);
										$("#nameInfo").val(name);
										$("#emailInfo").val(email);
										$("#birthInfo").val(birthday);
										$("#postNum").val(postNum);
										$("#genderInfo").val(sex);
										$("#addrInfo").val(addr);
										$("#ageInfo").val(age);
										$("#addrDetail").val(deaddr);
										
										$("#curriculumName").val(eduname);
										$("#statusInfo").val(situation);
										$("#quarter").val(quarter);
										
										
										$("#StuInfoModal").modal("hide");
										
									}).fail(function() {
										alert("문제가 발생 했습니다.");
									});
									
									
									
								});
							
							});

						}).fail(function() {
							alert("문제가 발생했습니다.");
						});
					
					
				}
				
			
			});
			
			var nameNumInput = $("#nameNumInput").val();
			if (nameNumInput != "") {
				$("#numName").val(nameNumInput);
			}
			
			
		});
		
		//모달 띄울때 그리드 새로고침
		$('#StuInfoModal').on('shown.bs.modal', function(e) {
			grid.refreshLayout();
			grid.off('click');
		});
	
		//화면 끌 경우 초기화
		$('#StuInfoModal').on('hidden.bs.modal', function(e) {
					$("#courseInput").val('');
					$("#numName").val('');
					$("#stuInfoChoose").attr("disabled", true);
					$('#statusA').val($('#statusA').find('option:first').val());
					$("#courseNum").text('');
					grid.resetData([]);
					grid.off('click');
		});
		
		//수정버튼 눌러서 수정하기
		$(document).on("click","#infoUpdate",function(){
			if($("#StudentID").val() == "" || $("#StudentID").val() < 1){
				alert("수정할 학생정보가 없습니다.");
			} else {
				$("#infoUpdate").hide();
				$("#infoSaveNo").show();
				$("#infoSave").show();
				$("#telInfo").prop("disabled", false);
				$("#emerTel").prop("disabled", false);
				$("#relation").prop("disabled", false);
				$("#emailInfo").prop("disabled", false);
				$("#postNum").prop("disabled", false);
				$("#addrInfo").prop("disabled", false);
				$("#addrDetail").prop("disabled", false);
				$("#postSearch").prop("disabled", false);
			}
			
			
				
		});
		
		//저장 버튼
		$(document).on("click","#infoSave",function(){
			//정규식 검사(email형식이 맞는지)
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			//전화번호 정규식
			var RegExp  = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ A-Z\uAC00-\uD7A3\u3131-\u3163]/gim;
			
			if(! (filter.test($("#emailInfo").val()) )){
				alert("올바른 email형식을 입력하세요.");
				var a = $('#emailInfo').val().replace(/ /gi, '');
				$('#emailInfo').val(a);
				$("#emailInfo").focus();
				return false;
			}
			
			if($("#telInfo").val() == "" || $("#telInfo").val().length > 11 || 
				RegExp.test($("#telInfo").val())	){
				alert("전화번호는 숫자만 입력해 주세요.");
				var b = $('#telInfo').val().replace(RegExp, '');
				$('#telInfo').val(b);
				$("#telInfo").focus();
				return false;
			}
			
			if($("#emerTel").val().length > 11 || RegExp.test($("#emerTel").val())	){
				alert("전화번호는 숫자만 입력해 주세요.");
				var c = $('#emerTel').val().replace(RegExp, '');
				$('#emerTel').val(c);
				$("#emerTel").focus();
				return false;
			}
			
			if($("#emerTel").val() != ""){
				if($("#relation").val() == ""){
					alert("관계를 선택해 주세요.");
					$("#relation").focus();
					return false;
				}	
			} else {
				if($("#relation").val() != ""){
					alert("비상연락처를 입력해 주세요.");
					$("#relation").val("");
					$("#emerTel").focus();
					return false;
				}
			}
			
			
			
			
			var studentID = $("#StudentID").val();
			
			var telinfo = $("#telInfo").val();
			var etelinfo = $("#emerTel").val();
			var emailinfo = $("#emailInfo").val();
			var relationinfo = $("#relation").val();
			var postinfo = $("#postNum").val();
			var addrinfo = $("#addrInfo").val();
			var addrdeinfo = $.trim($("#addrDetail").val());
			
			$.post({
				url: "/studentInfoUpdate",
				data: {
					"studentID": studentID,
					"telinfo": telinfo,
					"etelinfo": etelinfo,
					"emailinfo": emailinfo,
					"relationinfo": relationinfo,
					"postinfo": postinfo,
					"addrinfo": addrinfo,
					"addrdeinfo": addrdeinfo
				},
				cache: false,
				dataType: "json"
			}).done(function(data) {
				if (data.result == "1") {
					alert("수정이 완료되었습니다.");
					$("#infoUpdate").show();
					$("#infoSaveNo").hide();
					$("#infoSave").hide();
					$("#telInfo").prop("disabled", true);
					$("#emerTel").prop("disabled", true);
					$("#relation").prop("disabled", true);
					$("#emailInfo").prop("disabled", true);
					$("#postNum").prop("disabled", true);
					$("#addrInfo").prop("disabled", true);
					$("#addrDetail").prop("disabled", true);
					$("#postSearch").prop("disabled", true);

				} else {
					alert("문제가 발생했습니다. \n다시 시도해주세요.");
				}
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

		});	
		
		//취소 버튼
		$(document).on("click","#infoSaveNo",function(){
			location.reload();
		});
		
		
	
		
	var Grid = tui.Grid;
		
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				});
		
	
		
		var grid = new tui.Grid({
		      el: document.getElementById('stuSearchGrid'),
		      bodyHeight: 420,
		      scrollX: true,
		      scrollY: true,
		      rowHeaders: ['rowNum'],
		      columns: [
		        {
		          header: '학번',
		          name: 'STDNT_NO',
		          width:120,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		        {
		          header: '이름',
		          name: 'KORN_FLNM_S',
		          width:120,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		        {
		          header: '생년월일',
		          name: 'USER_BRDT',
		          width:120,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		        {
		          header: '성별',
		          name: 'GENDER_CD_NAME',
		          width:100,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		       
				{
					header : '교육과정',
					name : 'CRCLM_CD_NAME',
					width:350,
			        align:'center',
				    sortingType: 'asc',
				    sortable: true
				}, 
				{
					header : '학적상태',
					name : 'REG_CD_NAME',
					width:150,
				    align:'center',
				    sortingType: 'asc',
				    sortable: true
				}
				],
			selectionUnit: 'row'
			
			});
			
			var enrolGrid = new tui.Grid({
		      el: document.getElementById('enrolmentGrid'),
		      bodyHeight: 190,
		      scrollX: true,
		      scrollY: true,
		      rowHeaders: ['rowNum'],
		      columns: [
		        {
		          header: '과목코드',
		          name: 'SBJCT_NO',
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
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
		          name: 'ESNTL_TYPE',
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		       
				{
					header : '강의시간',
					name : 'CLASSTM',
			        align:'center',
				    sortingType: 'asc',
				    sortable: true
				}, 
				{
					header : '강의실',
					name : 'ROOM_NM',
				    align:'center',
				    sortingType: 'asc',
				    sortable: true
				}
				],
			selectionUnit: 'row'
			
			});
		 
			 
});

//소속학과 검색
$(function(){
	//교육과정 검색
	$(document).off("click", "#courseSearch").on("click", "#courseSearch", function() {
			
		$("#SearchModal").modal("show");
		
		
		//조회버튼 선택시
		$(document).off("click",'#depShow').on("click",'#depShow', function(){
			$("#depChoose").attr("disabled", false);
			var dep_searchs = $.trim($("#dep_Search_text").val());
			$.post({
					url : "/depsearch",
					data:{
						"depsearchs" : dep_searchs
					},
					cache : false,
					dataType : "json"
				}).done(function(data){
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
						var rowKey = grid2.getFocusedCell().rowKey;
						var obj = grid2.getRow(rowKey);
						var keys = Object.values(obj);
						var code_num = keys[0];
						var code_name = keys[1];
						
						//선택버튼 클릭 시
						$(document).off("click","#depChoose").on("click","#depChoose",function(){
							$("#courseNum").text(code_num);
							$("#courseInput").val(code_name);
							$("#SearchModal").modal("hide");
							});
						
					});
					
					
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
		});
		
		var department = $("#courseInput").val();
		if (department != "") {
		$("#dep_Search_text").val(department);
		$("#depShow").trigger("click");
			$(document).off("click", "#depChoose").on("click", "#depChoose", function() {
				var rowKey = grid2.getFocusedCell().rowKey;
				var obj = grid2.getRow(rowKey);
				var keys = Object.values(obj);
				var code_num = keys[0];
				var code_name = keys[1];
				$("#courseNum").text(code_num);
				$("#courseInput").val(code_name);
				$("#SearchModal").modal("hide");
			});
		}
		
		
		
	});	
		
		
		//모달 띄울때 그리드 새로고침
		$('#SearchModal').on('shown.bs.modal', function(e) {
			grid2.refreshLayout();
			grid2.off('click');
		});
	
		//화면 끌 경우 초기화
		$('#SearchModal').on('hidden.bs.modal', function(e) {
					$("#dep_Search_text").val('');
					$("#depChoose").attr("disabled", true);
					grid2.resetData([]);
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
		      rowHeaders: ['rowNum'],
		      columns: [
		        {
		          header: '코드',
		          name: 'CRCLM_CD',
		          width:120,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		        {
		          header: '교육과정명',
		          name: 'CRCLM_CD_NAME',
		          width:350,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        },
		        {
		          header: '년도',
		          name: 'CRCLM_YEAR',
		          width:120,
		          align:'center',
				  sortingType: 'desc',
				  sortable: true
		        },
		        {
		          header: '교육분기',
		          name: 'CRCLM_HALF',
		          width:120,
		          align:'center',
				  sortingType: 'asc',
				  sortable: true
		        }
				],
			selectionUnit: 'row'
			
			});
			


});
