/**
 * 
 */

$(function() {
	$("#infoModal").click(function() {
		$("#infoModModal").modal("show");
	});

	$("#nowPw2,#telNo,#emailAddr").keydown(function(key){
		  if(key.keyCode == 13){
			$("#modbtn").click();
		  }
	});

	var user_id = $("#userID2").text();

	$.post({
		url: "/admininfoAjax",
		data: {
			"user_id": user_id
		},
		dataType: "json"

	}).done(function(data) {
		var info = data.info;
		$("#telNo").val(info[0].TELNO);
		$("#emailAddr").val(info[0].EML_ADDR);

	}).fail(function() {
		alert("문제가 발생했습니다.");
	});
	//정규식 검사(email형식이 맞는지)
	var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	//전화번호 정규식
	var RegExp = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ A-Z\uAC00-\uD7A3\u3131-\u3163]/gim;

	$("#modbtn").click(function() {
		var nowPw = $("#nowPw2").val();
		if (nowPw == "") {
			alert("현재 비밀번호를 입력해주세요.");
			$("#nowPW").focus();
			return false;
		}

		if (!(filter.test($("#emailAddr").val()))) {
			alert("올바른 email형식을 입력하세요.");
			var a = $('#emailAddr').val().replace(/ /gi, '');
			$('#emailAddr').val(a);
			$("#emailAddr").focus();
			return false;
		}

		if ($("#telNo").val() == "" || $("#telNo").val().length > 11 | RegExp.test($("#telNo").val())) {
			alert("전화번호는 숫자만 입력해 주세요.");
			var b = $('#telNo').val().replace(RegExp, '');
			$('#telNo').val(b);
			$("#telNo").focus();
			return false;
		}

		var telNo = $("#telNo").val();
		var emailAddr = $("#emailAddr").val();

		$.post({
			url: "/pwCheckAjax",
			data: {
				"user_id": user_id,
				"nowPw": nowPw
			},
			dataType: "json"

		}).done(function(data) {
			if (data.result == 1) {
				var newPw = $("#newPw").val();
				var newPwCheck = $("#newPwCheck").val();
				$.post({
						url : "/adminInfoUpdate",
						data : {
							"user_id" : user_id,
							"telNo" : telNo,
							"emailAddr" : emailAddr
							
						},
						cache : false,
						dataType : "json"
					}).done(function(data) {
						if (data.result == "1") {
							alert("수정이 완료되었습니다.");
							$("#nowPw2").val("");
							$("#infoModModal").modal("hide");
						} else {
							alert("문제가 발생했습니다. \n다시 시도해주세요.");
						}

					}).fail(function() {
						alert("문제가 발생했습니다.");
					});


			} else {
				alert("현재 비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
				$("#nowPw2").val("");
				$("#nowPw2").focus();
			}
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});

	});
});