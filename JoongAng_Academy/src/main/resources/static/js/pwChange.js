/**
 * 
 */

$(function(){
	$("#pwModal").click(function(){
		$("#pwChangeModal").modal("show");

	});
	$("#nowPw,#newPw,#newPwCheck").keydown(function(key){
		  if(key.keyCode == 13){
			$("#changebtn").click();
		  }
	});
	$("#changebtn").click(function(){
		var user_id = $("#userID").text();
		var nowPw = $("#nowPw").val();
		var newPw = $("#newPw").val();
		var newPwCheck = $("#newPwCheck").val();
		
		if(nowPw == ""){
			alert("현재 비밀번호를 입력해주세요.");
			$("#nowPW").focus();
			return false;
		} 
		if (newPw == "") {
			alert("새 비밀번호를 입력해주세요.");
			$("#newPw").focus();
			return false;
		}
		if (newPwCheck == "") {
			alert("새 비밀번호 확인을 입력해주세요.");
			$("#newPwCheck").focus();
			return false;
		}
		if(newPw != "" && newPwCheck != ""){
			if (newPwCheck != newPw) {
				alert("새 비밀번호가 일치하지 않습니다.");
				$("#newPw").focus();
				return false;
			}	
		}
		
		$.post({
				url : "/pwCheckAjax",
				data : {
					"user_id" : user_id,
					"nowPw" : nowPw
				},
				dataType : "json"

			}).done(function(data) {
				if (data.result == 1) {
					
	
				
					$.post({
						url : "/pwCheckAjax",
						data : {
							"user_id" : user_id,
							"nowPw" : newPw
						},
						dataType : "json"
		
					}).done(function(data) {
						if (data.result == 1) {
							alert("현재 비밀번호와 새 비밀번호가 같습니다. 다시 입력해주세요.");
							$("#newPw").focus();
						} else {
							
							$.post({
								url : "/pwChangeAjax",
								data : {
									"user_id" : user_id,
									"newPw" : newPw
								},
								dataType : "json"
		
							}).done(function(data) {
								if (data.result == 1) {
									$("#pwChangeModal").modal("hide");
									alert("비밀번호를 변경했습니다. 다시 로그인해주세요.");
									location.href = "/logout";
								}
							}).fail(function() {
								alert("문제가 발생했습니다.");
							});
					}
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
				} else {
					alert("현재 비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
					$("#nowPw").val("");
					$("#nowPw").focus();
				}
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
		
	});
});