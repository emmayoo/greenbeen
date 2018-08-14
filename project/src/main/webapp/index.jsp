<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <script>
	location.href="first.env";
	//location.href="main.env";
</script>
 
<h2>애니메이션 만들기</h2>
<style>
#container
{
    width: 400px;
    height: 400px;
    position: relative;
    background: yellow;
}
#animate
{
    width: 50px;
    height: 50px;
    position: absolute;
    background: red;
}
</style>
<p>
<button onclick="myMove()">클릭</button>
</p> 
<div id="container">
  <div id="animate"></div>
</div>
<script>
function myMove()
{
    var elem = document.getElementById("animate");
    var pos = 0;
    var id = setInterval(frame, 5);
    function frame()
    {
        if (pos == 350)
        {
            clearInterval(id);
        }
        else
        {
            pos++;
            elem.style.top = pos + 'px';
            elem.style.left = pos + 'px';
        }
    }
}
</script>

[출처] [예제코드 : javascript] 81.자바스크립트 HTML DOM 애니메이션(animation)|작성자 근육빵빵코더
 