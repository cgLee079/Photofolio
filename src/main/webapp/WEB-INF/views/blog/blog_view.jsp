<%@ page pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/included/included_head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blog/blog-view.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/included/included-comment.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/included/included-export.css" />
<script src="${pageContext.request.contextPath}/resources/js/blog/blog-view.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/included/included-comment.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/included/included-export.js"></script>

<link rel="canonical" href="${url}${requestScope['javax.servlet.forward.request_uri']}">
<meta name="description" content="${blog.title}">
<meta name="keywords" content="${blog.tag}">
<meta name="author" content="Lee Changoo">
<meta property ="og:title" content="${blog.title} - CHANGOO'S">
<meta property ="og:site_name" content="CHANGOO'S">
<meta property ="og:type" content="website">
<meta property ="og:url" content="${url}${requestScope['javax.servlet.forward.request_uri']}">
<meta property ="og:description" content="${blog.title}">

<c:choose>
	<c:when test="${not empty blog.thumbnail}" >
		<c:set var="thumbnail" value="${blogThumbDir}${blog.thumbnail}"/>
	</c:when>
	<c:when test="${fn:length(blog.images) > 0}" >
		<c:set var="thumbnail" value="${blogImageDir}${blog.images[0].pathname}"/>
	</c:when>
</c:choose>

<meta property="og:image" content="${url}${thumbnail}">

<body>
	<div class="wrapper">
		<c:import url="../included/included_nav.jsp" charEncoding="UTF-8" />
		<c:import url="../included/included_export.jsp" charEncoding="UTF-8">
			<c:param name = "thumbnail" value = "${thumbnail}" />
			<c:param name = "title" value = "[블로그] ${blog.title}" />
			<c:param name = "hits" value = "${blog.hits}" />
			<c:param name = "comtCnt" value = "${blog.comtCnt}" />
		</c:import>
		
		<div class="wrap-blog">
			<div class="blog-head">
				<div class="blog-head-bg" style="background-image: url('${pageContext.request.contextPath}${thumbnail}')"></div>
				<div class="blog-head-fg"></div>
				<div class="blog-head-desc">
					<div class="tag"><c:out value="${blog.tag}"/></div>
					<div class="title"><c:out value="${blog.title}"/></div>
					<div class="subinfo">
						<div><c:out value="${blog.date}"/></div>
						<div class="colum-border"></div>
						<div>조회수 <c:out value="${blog.hits}"/></div>
					</div>
				</div>
				<div class="blog-head-submenu">
					<a href="javascript:void(0);" onclick="drawExportView()">공유하기</a>
					<a class="btn-list" href="${pageContext.request.contextPath}/blogs">목록</a>
				</div>
			</div>
			
			<div class="blog-main">
				<div class="blog-contents editor-contents">
					<c:out value="${blog.contents}" escapeXml="false"/>
					
					<c:if test="${!empty files}">
						<h3>첨부파일</h3>
						<div class="blog-files">
							<c:forEach var="file" items="${files}">
								<fmt:formatNumber var="filesize" value="${file.size/(1024*1024)}" pattern="0.00"/>
								<div class="blog-file">
									 <a onclick="downloadFile('${blogFileDir}', '${file.pathname}', '${file.filename}')"> 
									 	<c:out value="${file.filename}"/> (<c:out value="${filesize}"/> MB)
								 	</a>
								</div>												
							</c:forEach>
						</div>
					</c:if>
				</div>
				
				<c:import url="../included/included_comment.jsp" charEncoding="UTF-8">
				   <c:param name = "boardType" value = "${boardType.BLOG.val}" />
				   <c:param name = "boardSeq" value = "${blog.seq}" />
				   <c:param name = "comtCnt" value = "${blog.comtCnt}" />
				</c:import>
			</div>
			
			
		</div>	
	
		<c:import url="../included/included_footer.jsp" charEncoding="UTF-8">
		</c:import>
		
	</div>
</body>
</html>