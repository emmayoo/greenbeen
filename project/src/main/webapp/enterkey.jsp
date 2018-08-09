<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" language="javascript">
    function mf_Search() {
        var strSearchTxt = $.trim($(".input").val());
 
        if (strSearchTxt == "") {
            alert("검색어를 입력해 주세요.");
            $(".input").focus();
            return;
        } else {
            // 엔터 후 발생시킬 이벤트
        }
    }
</script>
 
<input type="text" class="input" id="inputSearch" maxlength="100"onkeydown="javascript: if (event.keyCode == 13) { mf_Search();}"/>
 cs

 