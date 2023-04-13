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
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" /> <!-- 그리드 -->
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />

<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<style type="text/css">
body{
	color:#565757;
}
.marginPadding0{
	margin:0;
	padding:0;
}

.textheight25{
	height:25px;
}

</style>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> <!-- 그리드 -->
<script type="text/javascript">
$(function(){
const gridData = [
    {
      name: 'Beautiful Lies',
      artist: 'Birdy',
      release: '2016.03.26',
      type: 'Deluxe',
      genre: 'Pop'
    },
    {
      name: 'X',
      artist: 'Ed Sheeran',
      release: '2014.06.24',
      type: 'Deluxe',
      genre: 'Pop',
      _attributes: {
        disabled: true // A current row is disabled
      }
    },
    {
      name: 'Moves Like Jagger',
      release: '2011.08.08',
      artist: 'Maroon5',
      type: 'Single',
      genre: 'Pop,Rock',
      _attributes: {
        checkDisabled: true // A checkbox is disabled only
      }
    },
    {
      name: 'A Head Full Of Dreams',
      artist: 'Coldplay',
      release: '2015.12.04',
      type: 'Deluxe',
      genre: 'Rock',
      _attributes: {
        checked: true, // A checkbox is already checked while rendering
        className: {
          // Add class name on a row
          row: ['red']
        }
      }
    }
  ];

  const grid = new tui.Grid({
    el: document.getElementById('grid'),
    data: gridData,
    scrollX: false,
    scrollY: false,
    rowHeaders: ['checkbox'],
    columns: [
      {
        header: '훈련과정명',
        name: 'name'
      },
      {
        header: '과목번호',
        name: 'artist'
      },
      {
        header: '이수구분',
        name: 'type'
      },
      {
        header: '과목명',
        name: 'release'
      },
      {
        header: '수강인원',
        name: 'genre'
      },
      {
          header: '담당강사',
          name: 'genre'
      },
      {
          header: '총 훈련일수',
          name: 'genre'
      },
      {
          header: '강의시간',
          name: 'genre'
      },
      {
          header: '강의실',
          name: 'genre'
      }
      
    ]
  });
  
  const grid2 = new tui.Grid({
	    el: document.getElementById('grid2'),
	    data: gridData,
	    scrollX: false,
	    scrollY: true,
	    rowHeaders: ['checkbox'],
	    columns: [
	      {
	        header: '훈련과정명',
	        name: 'name'
	      },
	      {
	        header: '학번',
	        name: 'artist'
	      },
	      {
	        header: '이름',
	        name: 'type'
	      },
	      {
	        header: '출석시수',
	        name: 'release'
	      },
	      {
	        header: 'Genre',
	        name: 'genre'
	      }
	    ]
	  });
  
  const grid3 = new tui.Grid({
	    el: document.getElementById('grid3'),
	    data: gridData,
	    scrollX: false,
	    scrollY: false,
	    rowHeaders: ['checkbox'],
	    columns: [
	      {
	        header: '강의일자',
	        name: 'name'
	      },
	      {
	        header: '교시',
	        name: 'artist'
	      },
	      {
	        header: '출결구분',
	        name: 'type'
	      }
	    ]
	  });
	
});

</script>
</head>
<body class="sb-nav-fixed">
	<%@include file="../bar/topbar.jsp"%>
	<div id="layoutSidenav">
	<%@include file="../bar/sidebar.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="mt-4 position-relative row">
						<div style="width:30px;">
						<img src="./image/joongang_logo.png" style="width:25px;">
						</div>
						<div style="width:200px; height:30px;  "> 
							<h5 style="font-weight: bold; color:#565757; line-height:35px;">강의출결관리</h5>
						</div>
					</div>
					
					<div class="mt-2 mb-1" style="width:100%; height:1px; background-color:#c1c2c2;"></div>
					
					<div class="mt-2 marginPadding0 position-relative" style="width:100%; height:31px;">
						<div class="float-start" style="width:170px; height:auto; padding:0; ">
							<button type="button" class="btn btn-sm btn-secondary">출석부</button>
							<button type="button" class="btn btn-sm btn-secondary">수강신청명단</button>
						</div>
						<div class="float-end" style="width:150px; height:auto; padding:0;">
							<button type="button" class="btn btn-sm btn-secondary">조회</button>
							<button type="button" class="btn btn-sm btn-secondary">삭제</button>
							<button type="button" class="btn btn-sm btn-secondary">저장</button>
						</div>
					</div>
					
					<div class="mt-2">
						<div class="position-relative justify-content-center" style="display:flex; width:100%; height: 45px; font-weight:bold; padding:10px 0 10px 0; background-color:#eef4f8;">
							<div style="width:70px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 10px 0 0;">
								학년도
							</div>
							<div style="width:100px; height:30px; margin:0 10px 0 0;">
								<input type="text" class="form-control"  style=" height:25px; border:0; font-size:13px; ">
							</div>
							<div style="width:100px; height:25px; margin:0 20px 0 0;">
								<select class="form-select form-select-sm" aria-label="Default select example" style="height:25px; font-size:13px; padding:0 0 0 10px;">
									<option value="1">상반기</option>
									<option value="2">하반기</option>
								</select>
							</div>
							<div style="width:100px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 0 0 20px;">
								훈련과정명
							</div>
							<div>
								<div style="width:250px; height:30px; margin:0 10px;">
									<input type="text" class="form-control"  style=" height:25px; border:0; font-size:13px; ">
								</div>
							</div>
							<div style="width:100px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 0 0 20px;">
								개설과목
							</div>
							<div>
								<div style="width:150px; height:30px; margin:0 10px;">
									<input type="text" class="form-control"  style=" height:25px; border:0; font-size:13px; ">
								</div>
							</div>
							<div style="width:100px; height:25px; font-size:14px; text-align:right; line-height:25px; margin:0 0 0 20px;">
								담당강사
							</div>
							<div>
								<div style="width:150px; height:30px; margin:0 10px;">
									<input type="text" class="form-control"  style=" height:25px; border:0; font-size:13px;  ">
								</div>
							</div>
						</div>
					</div>
					
					<div class="mt-3 position-relative"  style="display:flex; width:100%; height:27px;">
							<div style="width:10px; height:27px; background-color:#498c5f;">
							</div>
							<div style="width:80px; height:27px; font-size:17px; font-weight: bold; line-height:30px; margin:0 10px;">
								강의목록
							</div>
							<div style="width:150px; height:27px; font-size:13px; color:#a3a3a7; line-height:35px; margin:0 10px;">
								00건이 조회되었습니다.
							</div>
					</div>

					<div style="width: 100%; height: 500px;">
					<!-- 강의목록 그리드 -->
						<div class="mt-2" id="grid"></div>
						<div class="mt-3 position-relative" style="display:flex;">
							<div style=" width:75%; height:400px; margin-right:15px;">
								<div class="position-relative"  style="display:flex; width:100%; height:27px;">
									<div style="width:10px; height:27px; background-color:#498c5f;">
									</div>
									<div style="width:80px; height:27px; font-size:17px; font-weight: bold; line-height:30px; margin:0 10px;">
										출석정보
									</div>
									<div style="width:150px; height:27px; font-size:13px; color:#a3a3a7; line-height:35px; margin:0 10px;">
										00건이 조회되었습니다.
									</div>
								</div>
								<div class="mt-2" style="width:100%; text-align:center; font-size:14px;">
								<!-- 출석정보 그리드 -->
									<div id="grid2"></div>
								</div>
							</div>
							<div style=" width:25%; height:400px;">
								<div class="position-relative"  style="display:flex; width:100%; height:27px; ">
									<div class="float-start" style="width:10px; height:27px; background-color:#498c5f;"></div>
									<div class="float-start" style="width:80px; height:27px; font-size:17px; font-weight: bold; line-height:30px; margin:0 10px;">
										개인출결
									</div>
									<div class="position-absolute end-0" style="width:auto; color:#a3a3a7;">
										<button type="button" class="btn btn-secondary" style="height:27px; font-size:13px; padding:0 10px;">출결저장</button>
									</div>
								</div>
								<div class="mt-2 position-relative"  style="display:flex; width:100%; height:30px; line-height:27px; padding:0; font-weight:bold; font-size:14px; border: solid 1px; background-color: lightgray;">
									<div style="width:50px; text-align:center;">학번</div>
									<div style="width:150px; text-align:center;"></div>
									<div style="width:50px; text-align:center;">이름</div>
									<div style="width:150px; text-align:center;"></div>
								</div>
								<div class="mt-2" style="width:100%; text-align:center; font-size:14px;">
									<!-- 개인출결 그리드 -->
									<div id="grid3"></div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</main>
			<%@include file="../bar/footer.jsp" %>
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
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> <!-- 그리드 -->
</body>
</html>
