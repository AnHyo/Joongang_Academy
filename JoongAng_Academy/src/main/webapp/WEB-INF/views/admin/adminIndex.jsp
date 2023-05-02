<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>index</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script type="text/javascript">
$(function() {

	
	$("#icon").hide();
	
    var tabID = 1;
    var menuNames = [];
    var tabs = {}; // 클릭한 메뉴에 대한 div 요소를 저장하는 객체
	
    // 바 메뉴 클릭 시 탭에 메뉴명 띄우기
    $('#collapseLayouts1 .nav-link').click(function() {
        var menuName = $(this).text();
        var menuHref = $(this).attr('href');
        addTab(menuName, menuHref);
    });

    $('#collapseLayouts2 .nav-link').click(function() {
        var menuName = $(this).text();
        var menuHref = $(this).attr('href');
        addTab(menuName, menuHref);
    });

    $('#collapseLayouts3 .nav-link').click(function() {
        var menuName = $(this).text();
        var menuHref = $(this).attr('href');
        addTab(menuName, menuHref);
    });
    $('#collapseLayouts4 .nav-link').click(function() {
        var menuName = $(this).text();
        var menuHref = $(this).attr('href');
        addTab(menuName, menuHref);
    });
    
    var existingTabIndex;

    function addTab(tabName, menuHref) {
    	 if (menuNames.length >= 10) { // 탭 개수가 10개 이상이면 추가 기능을 비활성화
    	        alert("최대 10개까지만 열 수 있습니다.");
    	        return;
    	    }
    	 
    	 if ($("#tab-list button").length >= 0) {
    		    $("#icon").show();
    		} else {
    		    $("#icon").hide();
    		}
    	
    	 existingTabIndex = menuNames.indexOf(tabName);
    		//alert(existingTabIndex);
    	    if (existingTabIndex !== -1) { // 이미 해당 메뉴명을 가진 탭이 있는 경우
    	    	 $("#tab-list button").eq(existingTabIndex).click(); // 해당 탭을 클릭
    	    } else {
    	        var newTabID = "tab" + tabID;
    	        var divTabID = "nav-inquire" + tabID;
    	        var $newButton = $('<button class="nav-link" id="' + newTabID + '" data-bs-toggle="tab" data-bs-target="#' + divTabID + '" type="button" role="tab" aria-controls="' + divTabID + '" style="margin-top: 5px; font-size: 14px; padding: 5px;"><div class="center"><span style="float: left;">' + tabName + '</span><input type="button" id="ib'+divTabID+'" class="btn-close" aria-label="Close" style="float: left;"></div></button>');

    	        $('#tab-list').append($newButton);
    	        $('#nav-tabContent').append($('<div class="tab-pane fade" id="' + divTabID + '" aria-labelledby="' + newTabID + '" role="tabpanel"><iframe src="' + menuHref + '" src="' + menuHref + '" width="100%" height="800px"></iframe></div>'));
    	        tabID++;
    	        menuNames.push(tabName); // 메뉴명 배열에 추가
    	        $("#" + newTabID).click();
    	    }
    	    
     }
	
    //탭 X 버튼 클릭시
    $('#tab-list').on('click', '.btn-close', function() {
    	 var tabID = $(this).parents('button').attr('id'); //newTabID
    	 var divID = $(this).parents('button').attr('aria-controls'); //divTabID
    	 
    	 // var existingTabIndex = $('#' + tabID).text(); // 현재 탭의 인덱스를 찾음
    	 var existingTabIndex = menuNames.indexOf($('#' + tabID).text()); // 배열에서 인덱스를 찾음
    	 var menuNamesLength = menuNames.length;
    	 
         $('#'+ tabID).remove();
         $('#'+ divID).remove();
         
         if (existingTabIndex !== -1) { // 배열에서 해당 인덱스를 삭제 & 앞의 메뉴 선택
             menuNames.splice(existingTabIndex, 1);
             $("#tab-list button").eq(existingTabIndex-1).click();
         }
         
         if(menuNamesLength < 2){
        	 $("#icon").hide();
         }
         
         
    });
    
    $('#icon').click(function(){
    	  $('#tab-list button').each(function() {
    	    var tabID = $(this).attr('id');
    	    var divID = $(this).attr('aria-controls');
    	    $('#' + tabID).remove();
    	    $('#' + divID).remove();
    	  });
    	  menuNames = []; // 배열 초기화
    	  $("#icon").hide();
    	});
    
    $('a').click(function(event) {
        event.preventDefault();
    });

    
});
</script>	
<style type="text/css">
.center {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: row;
}

.center span {
    margin-right: 3px;
    margin-left: 3px;
    width: auto;
}

.center input {
    width: 10px;
    height: 10px;
    line-height: 30px;
    padding: 0 5px;
}

/* 선택된 탭 */
.nav-link.active span {
  font-weight: bold;
}

/* 선택되지 않은 탭 */
.nav-link:not(.active) {
  color: gray;
}
.nav-link{
	z-index: 10;
}
.close-tab{
	width: 100%;
	height: 38px;
	position: absolute;
	cursor: pointer;
	
}

.nav-tabs{
	position: relative;
}

.xi-close-square{
	right: 0;
	float: right;
	margin-right: 10px;
}
</style>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
		<%@include file="../bar/sidebar.jsp"%>


		<!-- 메인 -->
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid">
				<div class="mb-2">
				  <nav>
				   <div class="nav nav-tabs" id="tab-list" role="tablist">
					     <div class="close-tab">
					  		<i class="xi-close-square xi-2x" id="icon" style="line-height: 38px;"></i>
					  	 </div> 
					</div>

				  </nav>
				  
				</div> 			
			</div>
			<!-- <iframe name="view" width="100%" height="800px"></iframe> -->
			
			<div class="tab-content" id="nav-tabContent">
				
			</div>

			</main>
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