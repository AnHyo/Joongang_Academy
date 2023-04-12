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
<link href="css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="css/jquery-ui.css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="js/jquery-ui.js"></script>
<style>
#dialog label, #dialog input {
	display: block;
}

#dialog label {
	margin-top: 0.5em;
}

#dialog input, #dialog textarea {
	width: 95%;
}

#tabs {
	margin-top: 1em;
}

#tabs li {
	border-radius: 5px 5px 0 0 ;
}

#tabs li .ui-icon-close {
	float: left;
	margin: 0.4em 0.2em 0 0;
	cursor: pointer;
}

#add_tab {
	cursor: pointer;
}
</style>
<script>
	$(function() {
		
		
		
//  		var tabTitle = $("#tab_title"), 
		var tabTitle = "과목관리", 
		tabContent = $("#tab_content"), 
		tabTemplate = "<li><a href='<%="#"%>{href}'><%="#"%>{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>",
		tabCounter = 2;

		var tabs = $("#tabs").tabs();

		// Modal dialog init: custom buttons and a "close" callback resetting the form inside
		var dialog = $("#dialog").dialog({
			autoOpen : false,
			modal : true,
			buttons : {
				Add : function() {
					addTab();
					$(this).dialog("close");
				},
				Cancel : function() {
					$(this).dialog("close");
				}
			},
			close : function() {
				form[0].reset();
			}
		});

		// AddTab form: calls addTab function on submit and closes the dialog
		var form = dialog.find("form").on("submit", function(event) {
			addTab();
			dialog.dialog("close");
			event.preventDefault();
		});

		// Actual addTab function: adds new tab using the input from the form above
		function addTab() {
			var label = tabTitle || "Tab " + tabCounter, 
				id = "tabs-"+ tabCounter, 
				li = $(tabTemplate.replace(/#\{href\}/g,"#" + id).replace(/#\{label\}/g, label));
// 				, tabContentHtml = tabContent.val()  || "Tab " + tabCounter + " content.";

			tabs.find(".ui-tabs-nav").append(li);
	/* 		tabs.append("<div id='" + id + "'><p>" + tabContentHtml
					+ "</p></div>"); */
			tabs.tabs("refresh");
			tabCounter++;
		}

		// AddTab button: just opens the dialog
		$(".add_tab").on("click",function() {
// 			var tabTitle = $(".add_tab").text(), 
<%-- 			var tabTitle = "과목관리", 
			tabTemplate = "<li><a href='<%="#"%>{href}'><%="#"%>{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>",
			tabCounter = 2; --%>
			addTab();
			dialog.dialog("close");
			event.preventDefault();
		});

		// Close icon: removing the tab on click
		tabs.on("click", "span.ui-icon-close", function() {
			var panelId = $(this).closest("li").remove().attr("aria-controls");
			$("#" + panelId).remove();
			tabs.tabs("refresh");
		});

		tabs.on("keyup", function(event) {
			if (event.altKey && event.keyCode === $.ui.keyCode.BACKSPACE) {
				var panelId = tabs.find(".ui-tabs-active").remove().attr(
						"aria-controls");
				$("#" + panelId).remove();
				tabs.tabs("refresh");
			}
		});
	});
</script>
</head>
<body class="sb-nav-fixed">
	<%@include file="./bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="./bar/sidebar.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<!-- 탭 메뉴 -->
			

				<div id="tabs" class="m-0 p-0" >
					<ul class="m-0" style="height: 45.59px; background-color:#212529 !important;">
						<!-- <li><a href="#tabs-1">Nunc tincidunt</a> <span
							class="ui-icon ui-icon-close" role="presentation">Remove
								Tab</span></li> -->
					</ul>
			<!-- 		<div id="tabs-1">
						<p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo
							a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet
							mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa
							et lorem. Mauris dapibus lacus auctor risus. Aenean tempor
							ullamcorper leo. Vivamus sed magna quis ligula eleifend
							adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum.
							Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede
							varius sollicitudin. Sed ut dolor nec orci tincidunt interdum.
							Phasellus ipsum. Nunc tristique tempus lectus.</p>
					</div> -->
				</div>
	<!-- 			<div id="dialog" title="Tab data">
					<form>
						<fieldset class="ui-helper-reset">
							<label for="tab_title">Title</label> <input type="text"
								name="tab_title" id="tab_title" value="Tab Title"
								class="ui-widget-content ui-corner-all"> <label
								for="tab_content">Content</label>
							<textarea name="tab_content" id="tab_content"
								class="ui-widget-content ui-corner-all">Tab content</textarea>
						</fieldset>
					</form>
				</div>

				<button id="add_tab">Add Tab</button> -->
				<div class="container-fluid"></div>
			</main>
			<%@include file="./bar/footer.jsp"%>
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
</body>
</html>
