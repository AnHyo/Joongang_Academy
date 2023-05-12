$(function(){
	
	var Grid = tui.Grid;
				Grid.applyTheme('clean');
				var tchGrid = new tui.Grid({
					el : document.getElementById("tchgrid"),
					scrollX : false,
					scrollY : true,
					bodyHeight : 300,
					rowHeaders : [ 'rowNum' ],
					columns : [ {
						header : "사용자번호",
						name : 'USER_NO',
						align: 'center',
						sortingType: 'asc',
						sortable: true
					}, {
						header : "성명",
						name : 'KORN_FLNM',
						align:'center',
						sortingType: 'asc',
						sortable: true
					}, {
						header : "생년월일",
						name : 'USER_BRDT',
						align: 'center',
						sortingType: 'asc',
						sortable: true
					}, {
						header : "Email",
						name : 'EML_ADDR',
						align: 'center',
						sortingType: 'asc',
						sortable: true
					}, {
						header : "연락처",
						name : 'TELNO',
						align: 'center',
						sortingType: 'asc',
						sortable: true
					}]
				});

	
	$("#nav-profile-tab").on("click", function(){
		tchGrid.refreshLayout();
		teacherUnregList();
	});
	
	// -- 강사등록 그리드 출력 Ajax
	function teacherUnregList (){
		$.post({
					url: "/teacherUnregList",
					cache: false,
					dataType: "json"
				}).done(function(data) {
					tchGrid.resetData(data.unreglist);
					tchGrid.on('click', () => {
						$("#i").val("");
						$("#postNum").val("");
						$("#addrInfo").val("");
						$("#addrDetail").val("");
						$("#k").val("");

						var rowKey = tchGrid.getFocusedCell().rowKey;
						var obj = tchGrid.getRow(rowKey);
						var keys = Object.values(obj);
						var user_no = keys[0];
						var istrc_name = keys[1];
						var i_birth = keys[2];
						var i_email = keys[3];
						var i_tel = keys[4];
						
						$("#j").val(user_no);
						$("#b").val(istrc_name);
						$("#c").val(i_birth);
						$("#d").val(i_email);
						$("#e").val(i_tel);
						
						$("#d").prop("disabled", false);
						$("#postNum").prop("disabled", false);
						$("#addrInfo").prop("disabled", false).attr("placeholder", "우편번호를 검색해주세요.");
						$("#addrDetail").prop("disabled", false);
						$("#e").prop("disabled", false);
						$("#k").prop("disabled", false);
						$("#i").prop("disabled", false);
						$("#postSearch").prop("disabled", false);
						
					});
					
					
					
					
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
	}	


	
		$("#newSaveBtn").on("click",function(){
			if($("#j").val() == "" || $("#j").val() < 1){
				alert("등록할 강사정보가 없습니다.");
				return false;
			} else {
				//정규식 검사(email형식이 맞는지)
				var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				//전화번호 정규식
				var RegExp  = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ A-Z\uAC00-\uD7A3\u3131-\u3163]/gim;
				
				if(! (filter.test($("#d").val()) )){
					alert("올바른 email형식을 입력하세요.");
					var a = $('#d').val().replace(/ /gi, '');
					$('#d').val(a);
					$("#d").focus();
					return false;
				}
				
				if($("#e").val() == "" || $("#e").val().length > 11 || 
						RegExp.test($("#e").val())	){
						alert("전화번호는 숫자만 입력해 주세요.");
						var b = $('#e').val().replace(RegExp, '');
						$('#e').val(b);
						$("#e").focus();
						return false;
				}
				
				if($("#i").val() == ""){
					alert("성별을 선택해 주세요.");
					$("#i").focus();
					return false;
				}
				
				if($("#postNum").val() == "" || $("#postNum").val().length < 1){
						alert("주소를 입력해 주세요.");
						$("#postNum").focus();
						return false;
				}
				
				
				if($("#k").val() == ""){
					alert("소속 교육기관을 선택해 주세요.");
					$("#k").focus();
					return false;
				}
				
				var inst_no = $("#a").val();
				
				//중복확인
				$.post({
					url: "/telChenck",
					data:{"inst_no":inst_no},
					cache: false,
					dataType: "json"
				}).done(function(data) {
					var result = data.telList;
					for(let i = 0; result.length > i; i++){
							if($("#e").val() == result[i].TELNO){
							alert("이미 등록되어있는 전화번호입니다.");
							$("#e").focus();
							return false;
							}
						}
						
					var newName = $("#b").val();
					var newBirth = $("#c").val();
					var newEmail = $("#d").val();
					var newTel = $("#e").val();
					var newGender = $("#i").val();
					var newPostNum = $("#postNum").val();
					var newAddr = $("#addrInfo").val();
					var newDaddr = $.trim($("#addrDetail").val());
					var newUserNo = $("#j").val();
					var newEndstNo = $("#k").val();
					
					
					$.post({
						url: "/teacherNewRegist",
						data:{
							"newName":newName,
							"newBirth":newBirth,
							"newEmail":newEmail,
							"newTel":newTel,
							"newGender":newGender,
							"newPostNum":newPostNum,
							"newAddr":newAddr,
							"newDaddr":newDaddr,
							"newUserNo":newUserNo,
							"newEndstNo":newEndstNo
						},
						cache: false,
						dataType: "json"
					}).done(function(data) {
						if (data.result == "1") {
							alert("강사등록이 완료되었습니다.");
							$("form").on("reset", function() {
								// input, select, textarea 요소 초기화
								$(this).find("select, textarea").val("");
								$(this).find('input[type="text"]').val("");
		
								// select 요소의 첫번째 옵션 선택
								$(this).find("select").prop("selectedIndex", 0);
							});
	
							$("form").trigger("reset");
							
							
							$("#d").prop("disabled", true);
							$("#postNum").prop("disabled", true);
							$("#addrInfo").prop("disabled", true).removeAttr('placeholder');
							$("#addrDetail").prop("disabled", true);
							$("#e").prop("disabled", true);
							$("#k").prop("disabled", true);
							$("#i").prop("disabled", true);
							$("#postSearch").prop("disabled", true);
							
							teacherUnregList();
	
	
						} else{
							alert("실패");
						}
					}).fail(function() {
						alert("문제가 발생했습니다.");
					}); // -- 등록 끝
					
				}).fail(function() {
					alert("문제가 발생했습니다.");
				}); // -- 중복확인 끝
				
			}
		});
		
						 
	tchGrid.on('focusChange', (ev) => {
			  tchGrid.setSelectionRange({
			    start: [ev.rowKey, 0],
			    end: [ev.rowKey, tchGrid.getColumns().length]
			  });						
		});

		
		
		// -- 탭바 클릭시 초기화
		$(document).on("click","#nav-home-tab",function(){
			tchGrid.resetData([]);
			
			$("form").on("reset", function() {
				// input, select, textarea 요소 초기화
				$(this).find("select, textarea").val("");
				$(this).find('input[type="text"]').val("");
	
				$(this).find("select").prop("selectedIndex", 0);
			});
			
			$("form").trigger("reset");
			
			$("#d").prop("disabled", true);
			$("#postNum").prop("disabled", true);
			$("#addrInfo").prop("disabled", true).removeAttr('placeholder');
			$("#addrDetail").prop("disabled", true);
			$("#e").prop("disabled", true);
			$("#k").prop("disabled", true);
			$("#i").prop("disabled", true);
			$("#postSearch").prop("disabled", true);
		});
			 
});