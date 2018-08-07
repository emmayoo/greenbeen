<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
 function highlight(text) {
	  var inputText = document.getElementById("content2");
	  var innerHTML = inputText.innerHTML;
	  var index = innerHTML.indexOf(text);
	  while(index>=0){
			  innerHTML = innerHTML.substring(0,index) + "<b class='highlight'>" + innerHTML.substring(index,index+text.length) + "</b>" + innerHTML.substring(index + text.length);
			  alert(innerHTML);
			  index = innerHTML.indexOf(text,(index+25));
			  inputText.innerHTML = innerHTML;
	  }
	} 
 </script>
 <style>
	.highlight {
 		 background-color: yellow;
	}
</style>
 <body onload="highlight('안녕')">
	<div id="content2">
	
설레이는 이 마음은 뭘까
왠지 잠을 이룰 수가 없어

혹시 꿈을 꾸고 있는지
나는 몰라

내가 있는 곳 여기가 어딘지
언제부터 시작되어 온 건지

아무도 내게 말 안해
가르쳐 주지 않아

눈으로 볼 수 있는 세상이
너무나 작다는 걸 알았어

바람에 실려 온
세상 저 편에
소식들 궁금해

안녕 디지몬
네 꿈을 꾸면서 잠이 들래

안녕 디지몬
친구들 모두 안녕

안녕 디지몬
너와 함께하고 싶어

안녕 디지몬
난 너를 찾아갈래

어디선가 넌 가만히 다가와
나의 손을 잡아 줄 것 같아

미지의 세상 그 곳에
나를 데려가줘

조용히 눈을 감고 있으면
저 파란하늘 높이 날아가

모두가 꿈꾸던
환한 세상이 보이는 것 같아

안녕 디지몬
네 꿈을 꾸면서 잠이 들래

안녕 디지몬
친구들 모두 안녕

안녕 디지몬
너와 함께 하고 싶어

안녕 디지몬
난 너를 찾아 갈래
	</div>
 </body>