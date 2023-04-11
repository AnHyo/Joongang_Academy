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

const grid = new tui.Grid({
    el: document.getElementById('grid'),
    data: gridData,
    scrollX: false,
    scrollY: false,
    columns: [
      {
        header: 'Name',
        name: 'name'
      },
      {
        header: 'Artist',
        name: 'artist'
      },
      {
        header: 'Type',
        name: 'type'
      },
      {
        header: 'Release',
        name: 'release'
      },
      {
        header: 'Genre',
        name: 'genre'
      }
    ]
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
						<div style="width:200px; "> 
							<h5 style="font-weight: bold; color:#565757;">강의출결관리</h5>
						</div>
					</div>
					
<!-- 					<hr> -->
					<div style="width:100%; height:1px; background-color:#c1c2c2; margin:5px 0 13px 0;"></div>
					
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
						<div class="position-relative justify-content-center" style="display:flex; width:100%; height: 45px; padding:10px 0 10px 0; background-color:#eef4f8;">
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
						<!-- <div id="grid"></div> -->
						<table class="table table-sm mt-2" style="text-align:center; font-size:14px;">
							<thead style="background-color: lightgray;">
								<tr>
									<th><input type="checkbox"></th>
									<th>훈련과정명</th>
									<th>과목코드</th>
									<th>이수구분</th>
									<th>과목명</th>
									<th>수강인원</th>
									<th>담당강사</th>
									<th>총 훈련일수</th>
									<th>강의시간</th>
									<th>강의실</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox"> </td>
									<td>JAVA 풀스택 어쩌구</td>
									<td>123456</td>
									<td>필수</td>
									<td>HTML</td>
									<td>23</td>
									<td>강사1</td>
									<td>52</td>
									<td>화1,2,3 목1,2,3</td>
									<td>401호</td>
								</tr>
								<tr>
									<td><input type="checkbox"> </td>
									<td>JAVA 풀스택 어쩌구</td>
									<td>123456</td>
									<td>필수</td>
									<td>HTML</td>
									<td>23</td>
									<td>강사1</td>
									<td>52</td>
									<td>화1,2,3 목1,2,3</td>
									<td>401호</td>
								</tr>
								<tr>
									<td><input type="checkbox"> </td>
									<td>JAVA 풀스택 어쩌구</td>
									<td>123456</td>
									<td>필수</td>
									<td>HTML</td>
									<td>23</td>
									<td>강사1</td>
									<td>52</td>
									<td>화1,2,3 목1,2,3</td>
									<td>401호</td>
								</tr>
								<tr>
									<td><input type="checkbox"> </td>
									<td>JAVA 풀스택 어쩌구</td>
									<td>123456</td>
									<td>필수</td>
									<td>HTML</td>
									<td>23</td>
									<td>강사1</td>
									<td>52</td>
									<td>화1,2,3 목1,2,3</td>
									<td>401호</td>
								</tr>
								<tr>
									<td><input type="checkbox"> </td>
									<td>JAVA 풀스택 어쩌구</td>
									<td>123456</td>
									<td>필수</td>
									<td>HTML</td>
									<td>23</td>
									<td>강사1</td>
									<td>52</td>
									<td>화1,2,3 목1,2,3</td>
									<td>401호</td>
								</tr>
							</tbody>
						</table>
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
								<div>
									<table class="mt-2 table table-sm" style="width:100%; text-align:center; font-size:14px;">
										<thead style="background-color: lightgray;">
											<tr>
												<th>훈련과정명</th>
												<th>학번</th>
												<th>이름</th>
												<th>출석시수</th>
												<th>결석시수</th>
												<th>01.03</th>
												<th>01.05</th>
												<th>01.10</th>
												<th>01.12</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>JAVA 풀스택 어쩌구</td>
												<td>123456</td>
												<td>학생1</td>
												<td>46</td>
												<td>0</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>JAVA 풀스택 어쩌구</td>
												<td>019392</td>
												<td>학생2</td>
												<td>42</td>
												<td>4</td>
												<td></td>
												<td>/</td>
												<td>/</td>
												<td></td>
											</tr>
											<tr>
												<td>JAVA 풀스택 어쩌구</td>
												<td>113345</td>
												<td>학생3</td>
												<td>44</td>
												<td>2</td>
												<td></td>
												<td></td>
												<td></td>
												<td>/</td>
											</tr>
										</tbody>
									</table>
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
								<div class="mt-2 position-relative"  style="display:flex; width:100%; height:28px; line-height:27px; padding:0; font-weight:bold; font-size:14px; border: solid 1px; background-color: lightgray;">
									<div style="width:50px; text-align:center;">학번</div>
									<div style="width:150px; text-align:center;"></div>
									<div style="width:50px; text-align:center;">이름</div>
									<div style="width:150px; text-align:center;"></div>
								</div>
								<div>
									<table class="mt-2 table table-sm" style="width:100%; text-align:center; font-size:14px;">
										<thead style="background-color: lightgray;">
											<tr>
												<th>강의일자</th>
												<th>교시</th>
												<th>출결구분</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>23.01.03</td>
												<td>1</td>
												<td>출석</td>
											</tr>
											<tr>
												<td>23.01.03</td>
												<td>2</td>
												<td>출석</td>
											</tr>
										</tbody>
									</table>
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
