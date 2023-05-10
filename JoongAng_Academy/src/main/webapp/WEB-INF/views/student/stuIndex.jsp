<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (session.getAttribute("id") != null) {
   if (!session.getAttribute("groupCD").equals("0010")) {
      response.sendRedirect("/login?error=1234");
   }
} else {
   response.sendRedirect("/login?error=4321");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>중앙정보처리학원</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
    <!-- Place favicon.ico in the root directory -->
<script src="https://kit.fontawesome.com/a31e2023c3.js" crossorigin="anonymous"></script>
    <!-- Web Font -->
 <link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">

    <!-- ========================= CSS here ========================= -->
  
<!--     <link rel="stylesheet" href="assets/css/bootstrap.min.css" /> -->
<!--     <link rel="stylesheet" href="assets/css/animate.css" /> -->
    <link href="css/styles2.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/tiny-slider.css" />
    <link rel="stylesheet" href="assets/css/glightbox.min.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
	
</head>

<body>

    <!-- Preloader -->
	<!-- loading -->
    <div class="preloader">
        <div class="preloader-inner">
            <div class="preloader-icon">
                <span></span>
                <span></span>
            </div>
        </div>
    </div>
    <!-- /End Preloader -->
<%@include file="../portalbar/topbar.jsp"%>


    <!-- Start Hero Area -->
    <section class="hero-area overlay">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1 col-md-12 col-12">
                    <div class="hero-text text-center">
                        <!-- Start Hero Text -->
                        <div class="section-heading">
                            <h2 class="wow fadeInUp" data-wow-delay=".3s">중앙정보처리학원</h2>
                            <p class="wow fadeInUp" data-wow-delay=".5s">4차 산업혁명 SoftWare 선도인력 양성, First Mover <b>“중앙”</b><br>
							Since 1969, Leading SoftWare Technology Education Services</p>
                        </div>
                        <!-- End Search Form -->
                     
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Hero Area -->

    <!-- Start Categories Area -->
    <section class="categories">
        <div class="container">
            <div class="cat-inner">
                <div class="row">
                    <div class="col-12 p-0">
                        <div class="category-slider">
                            <!-- Start Single Category -->
                            <a href="/stuApply" class="single-cat">
                                <div class="icon mt-1 mb-0">
                                    <i class="fa-solid fa-school fa-2xl" style="width:28px; height:28px;color: #20c997;"></i>
                                </div>
                                <h3>수강신청</h3>
                            </a>
                            <!-- End Single Category -->
                            <!-- Start Single Category -->
                            <a href="" class="single-cat">
                                <div class="icon mt-1 mb-0">
                                    <i class="fa-solid fa-chalkboard-user fa-2xl" style="width:28px; height:28px; color: #20c997;"></i>
                                </div>
                                <h3>출결확인</h3>
                            </a>
                            <!-- End Single Category -->
                            <!-- Start Single Category -->
                            <a href="" class="single-cat">
                                <div class="icon mt-1 mb-0">
                                    <i class="fa-solid fa-square-poll-vertical fa-2xl" style="width:28px; height:28px;color: #20c997;"></i>
                                </div>
                                <h3>설문조사</h3>
                            </a>
                            <!-- End Single Category -->
                            <!-- Start Single Category -->
                            <a href="/timetable" class="single-cat">
                                <div class="icon mt-1 mb-0">
                                   <i class="fa-regular fa-calendar-days fa-2xl" style="width:28px; height:28px;color: #20c997;"></i>
                                </div>
                                <h3>학생 시간표</h3>
                            </a>
                            <!-- End Single Category -->
                            <!-- Start Single Category -->
                            <a href="/stuinfoMod" class="single-cat">
                                <div class="icon mt-1 mb-0">
                                   <i class="fa-solid fa-user-tag fa-2xl" style="width:28px; height:28px;color: #20c997;"></i>
                                </div>
                                <h3>개인정보 수정</h3>
                            </a>
                            <!-- End Single Category -->
                            <!-- Start Single Category -->
                            <a href="/pwCheckMod" class="single-cat">
                                <div class="icon mt-1 mb-0">
                                    <i class="fa-solid fa-user-shield fa-2xl" style="width:28px; height:28px;color: #20c997;"></i>
                                </div>
                                <h3>비밀번호 수정</h3>
                            </a>
                            <!-- End Single Category -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<%@include file="../portalbar/footer.jsp"%>
    </section>
    <!-- /End Categories Area -->


    

   
   

    <!-- ========================= scroll-top ========================= -->
    <!--<a href="#" class="scroll-top btn-hover">
        <i class="lni lni-chevron-up"></i>
    </a>-->

    <!-- ========================= JS here ========================= -->
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/tiny-slider.js"></script>
    <script src="assets/js/glightbox.min.js"></script>
    <script src="assets/js/main.js"></script>
    <script type="text/javascript">
        //========= Category Slider 
        tns({
            container: '.category-slider',
            items: 3,
            slideBy: 'page',
            autoplay: false,
            mouseDrag: true,
            gutter: 0,
            nav: false,
            controls: true,
            controlsText: ['<i class="lni lni-chevron-left"></i>', '<i class="lni lni-chevron-right"></i>'],
            responsive: {
                0: {
                    items: 1,
                },
                540: {
                    items: 2,
                },
                768: {
                    items: 4,
                },
                992: {
                    items: 5,
                },
                1170: {
                    items: 6,
                }
            }
        });
    </script>
</body>

</html>