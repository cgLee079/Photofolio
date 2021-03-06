<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!--  TOP 버튼 -->
<div class="btn-scroll-top off col-center" onclick="scrollToTop()">
	<a>TOP</a>
</div>

<!-- PROGRESS BAR -->
<div class="progress-bar off">
	<div class="spinner">
		<div class="double-bounce1"></div>
		<div class="double-bounce2"></div>
	</div>
</div>

<!-- Header -->
<div class="header-occupy"></div>
<div class="wrap-header">
	<div class="header">
		<div class="wrap-home-logo col-center">
			<img src="${pageContext.request.contextPath}/resources/image/icon-logo.svg"  class="logo" onclick="window.location.href = '${pageContext.request.contextPath}/'" ></img>
		</div>
		
		<!-- PC용 메뉴바 -->
		<div class="web-menus">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
		  		<div class="web-menu menu-logout"><a href="${pageContext.request.contextPath}/j_spring_security_logout">로그아웃 </a></div>
		  		<div class="web-menu menu-mgnt-project"><a href="${pageContext.request.contextPath}/mgnt/projects">프로젝트관리 </a></div>
		  		<div class="web-menu menu-mgnt-study"><a href="${pageContext.request.contextPath}/mgnt/studies">스터디관리 </a></div>
		  		<div class="web-menu menu-mgnt-blog"><a href="${pageContext.request.contextPath}/mgnt/blogs">블로그관리 </a></div>
		  		<div class="web-menu menu-mgnt-photo"><a href="${pageContext.request.contextPath}/mgnt/photos">사진관리 </a></div>
			</sec:authorize>
		
			<div class="web-menu menu-about"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/introduce">이력</a></div>
			<div class="web-menu menu-project"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/projects">프로젝트</a></div>
			<div class="web-menu menu-study"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/studies">스터디</a></div>
			<div class="web-menu menu-blog"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/blogs">블로그</a></div>
			<div class="web-menu menu-photo"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/photos">사진</a></div>
			<div class="web-menu menu-search"><a onclick="focuseSearch(this)" href="javascript:void(0);">검색</a></div>
			<div class="web-menu menu-search-field">
				<input type="text" class="global-search">
			</div>
		</div>
		
		<!-- MOBILE용 메뉴바 -->
		<div class="mob-nav">
			<div class="wrap-mobnav-icon" onclick="drawMobileMenu(this)">
				<div class="mobnav-icon">
					<span></span>
					<span></span>
					<span></span>
				</div>
			</div>
		</div>
		
		<div class="bg-mob-menus"></div>
		<div class="mob-menus">
			<div class="mob-menu-header">
				<img src="${pageContext.request.contextPath}/resources/image/icon-logo.svg"  onclick="window.location.href = '${pageContext.request.contextPath}/'" ></img>
			</div>
			
			<div class="mob-menu-margin"></div>
			<div class="mob-menu search">
				<div class="mobnav-search-field">
					<input type="text" class="global-search">
				</div>
				<div class="wp-mobnav-search" >
					<a href="javascript:void(0)" onclick="focuseSearch(this)">검색</a>
				</div>
			</div>
			<div class="mob-menu"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/introduce">이력</a></div>
			<div class="mob-menu"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/projects">프로젝트</a></div>
			<div class="mob-menu"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/studies">스터디</a></div>
			<div class="mob-menu"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/blogs">블로그</a></div>
			<div class="mob-menu"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/photos">사진</a></div>
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="mob-menu-margin"></div>
		 		<div class="mob-menu"><a href="${pageContext.request.contextPath}/mgnt/projects">프로젝트관리 </a></div>
		 		<div class="mob-menu"><a href="${pageContext.request.contextPath}/mgnt/studies">스터디관리 </a></div>
		 		<div class="mob-menu"><a href="${pageContext.request.contextPath}/mgnt/blogs">블로그관리 </a></div>
		 		<div class="mob-menu"><a href="${pageContext.request.contextPath}/mgnt/photos">사진관리 </a></div>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="mob-menu-margin"></div>
				<div class="mob-menu"><a href="${pageContext.request.contextPath}/j_spring_security_logout">로그아웃</a></div>
			</sec:authorize>
			
			<div class="mob-menu-margin"></div>
			<div class="mob-menu"><a href="https://github.com/cglee079" target="_blank" >Github</a></div>
			<div class="mob-menu"><a href="https://www.instagram.com/cglee079" target="_blank" >Instagram</a></div>
			
			<sec:authorize access="!hasRole('ROLE_ADMIN')">
				<div class="mob-menu-margin"></div>
				<div class="mob-menu"><a onclick="Progress.start()" href="${pageContext.request.contextPath}/login">로그인</a></div>
			</sec:authorize>
			
		</div>
	</div>
</div>


<!--  MAIN 	-->
