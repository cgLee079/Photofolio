<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script>
$(document).ready(function(){
	var data = {
		thumbnail 	: '${param.thumbnail}',
		title 		: '${param.title}',
		comtCnt 	:'${param.comtCnt}'
	}
	
	initExportKakao(data);
})

  	
function drawExportView(){
	$(".bg-wrap-export").addClass("on");
	$(".wrap-export").addClass("on");
	$("body").css("overflow", "hidden");
	$("body").on("scroll touchmove mousewheel", function(event) {
		event.preventDefault();
		event.stopPropagation();
		return false;
	});
	
	$("body").on("click", function(e){ //문서 body를 클릭했을때
		if($(e.target).hasClass("wrap-export")){
			exitExportView();			
		}
	});
	
  	return false;
}

function exitExportView(){
	$(".bg-wrap-export").removeClass("on");
	$(".wrap-export").removeClass("on");
	$("body").off("scroll touchmove mousewheel");
	$("body").off("click");
	$("body").css("overflow", "");
}

function urlClipCopy() { 
	var dummy = $('<input>');
	dummy.appendTo($("body"));
    dummy.val(window.location.href);
    
	dummy.select();
	document.execCommand('copy');
	
	dummy.remove();

	swal({
		text : "URL이 복사 되었습니다", 
		icon : "success",
	}).then(function() {
		exitExportView();
	});
}


</script>

<div class="bg-wrap-export"></div>
<div class="wrap-export">
	<div class="export">
		<div class="btn btn-export-exit" onclick="exitExportView()">
			<span></span> <span></span>
		</div>
	
		<div class="wp-export-img">
			<div class="bg-img"></div>
			<c:if test="${!empty param.thumbnail}">
				<div class="img">
					<img src="${pageContext.request.contextPath}${param.thumbnail}" />
				</div>
			</c:if>
		</div>
	
		<div class="exps">
			<div class="btn exp exp-url" onclick="urlClipCopy()">
				<img class="exp-icon"
					src="${pageContext.request.contextPath}/resources/image/btn-export-url.svg">
				<span>URL 복사</span>
			</div>
			<div id="expKakaotalk" class="btn exp exp-kakaotalk"
				onclick="exitExportView();">
				<img class="exp-icon"
					src="${pageContext.request.contextPath}/resources/image/btn-export-kakaotalk.svg">
				<span>카카오톡 공유하기</span>
			</div>
	
		</div>
	</div>

</div>

<style>
.bg-wrap-export{
	z-index: 10;
	position: fixed;
	top: 60px;
	left: 0;
	right : 0;
	bottom : 0;
	display: none;
	background: #000;
    opacity: 0.8;	
}

.bg-wrap-export.on{
	display: initial;
}

.wrap-export {
	z-index: 11;
	position: fixed;
	top: 60px;
	left: 0;
	right : 0;
	bottom : 0;
	
	display: none;
	justify-content : center;
	align-items : center;
	flex-flow: column;
}

.wrap-export.on {
	display: flex;
}

.export{
	width : 400px;
	height: 70%;
	position: relative;
	
	display: flex;
	flex-flow: column;
}

@media (max-width : 800px){
	.export{
		width : 100%;
		height: 100%;
	}
}

.btn-export-exit {
	z-index: 11;
	position: absolute;
	left: 0;
	top: 0;
	margin: 10px;
	padding: 20px;
}

.btn-export-exit span {
	display: block;
	position: absolute;
	height: 1.5px;
	width: 100%;
	background: #FFF;
	border-radius: 9px;
	left: 0;
}

.btn-export-exit span:nth-child(1) {
	-webkit-transform: rotate(45deg);
	-moz-transform: rotate(45deg);
	-o-transform: rotate(45deg);
	transform: rotate(45deg);
}

.btn-export-exit span:nth-child(2) {
	-webkit-transform: rotate(-45deg);
	-moz-transform: rotate(-45deg);
	-o-transform: rotate(-45deg);
	transform: rotate(-45deg);
}

.wp-export-img {
	width: 100%;
	height: 50%;
	position: relative;
}

.wp-export-img .bg-img {
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: #000;
	opacity: 0.7;
}

.wp-export-img .img {
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	display: flex;
	align-items: center;
	justify-content: center;
}

.wp-export-img .img img {
	max-height: 70%;
	max-width: 80%;
}

.exps {
	flex: 1;
	background: #FFF;
	padding-top: 20px;
}

.exps .exp {
	display: flex;
	align-items: center;
	padding: 0.3rem 2rem;
	font-weight: bold;
}

.exps .exp .exp-icon {
	width: 30px;
	margin: 0.7rem 1rem
	;
}
</style>

<script>
function initExportKakao(data){
	var url = window.location.href;
	var thumbnailURL = window.location.origin + data.thumbnail;
	
	Kakao.init('3684e89896f38ed809137a3e7062bf95');
	
	// 카카오링크 버튼을 생성
	Kakao.Link.createDefaultButton({
		container: '#expKakaotalk',
		objectType: 'feed',
  		content: {
    		title: data.title,
    		imageUrl: thumbnailURL,
    		link: {
    			mobileWebUrl: url,
    			webUrl: url
    		}
  		},
  		social: {
 	        commentCount: parseInt(data.comtCnt),
 	    },
  		buttons: [
			{
	   			title: '웹으로 보기',
	   			link: {
					mobileWebUrl: url,
					webUrl: url
				}
			}
  		]
	});
}
</script>