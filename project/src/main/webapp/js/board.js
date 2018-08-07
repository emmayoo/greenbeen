//modifyForm
	function fake(){
  		var photo = document.getElementById("attach1");
		photo.click();  		
  	}
	
	function ch(){
		var photo = document.getElementById("attach1");
		var text = document.getElementById("attach1_text");
  		text.value=photo.value; 
	}
	function attach1_del(){
		var photo = document.getElementById("attach1");
		var text = document.getElementById("attach1_text");
  		text.value="";
  		photo.value="";
	}

//deleteForm(ad_best,ad_com,files,question,notice,know_quiz,know_news)
function chk() {
		if (frm.passwd.value != frm.passwd2.value) {
			alert("암호가 다릅니다. 수정후 작업하세요");
			frm.passwd.focus();
			return false;
		}
}
//modifyForm(ad_best,ad_com,question,notice,know_quiz,know_news,files)
function chk() {
	if (frm.passwd.value != frm.passwd2.value) {
		alert("암호가 다릅니다");
		frm.passwd2.focus();
		return false;
	}
}

$(function(){
	//bsidebar, sidebar (top.jsp에 있음)
	var id = $('#hidden').val();
	var classname = $("."+id).attr("class"); 
 	$("."+id).attr("class",classname+" active"); 
 	/*	
 	$('.dropdown-item').click(function(e){
		id = $(e.target).attr("id");
		//alert(id);
		location.href="summary.env?id="+id;
	});
 	
 	$('.intro').click(function(e){
		id = $(e.target).attr("id");
		//alert(id);
		location.href="summary.env?id="+id;
	});	
	
	$('.board').click(function(e){
		id = $(e.target).attr("id");
		//alert(id);
		location.href="summary.env?id="+id;
	});*/
	
 	//list
	$('.ad_best_new').click(function(){
		location.href="ad_best_new.env?id=ad_best_list&pageNum=1";
	});
	$('.ad_com_new').click(function(){
		location.href="ad_com_new.env?id=ad_com_list&pageNum=1";
	});
	$('.notice_new').click(function(){
		location.href="notice_new.env?id=notice_list&pageNum=1"
	});

	$('.files_new').click(function(){
		location.href="files_new.env?id=files_list&pageNum=1"
		//$('.db').load("files_new.env?id=files_list&pageNum=1");
	});
	
	$('.know_quiz_new').click(function(){
		location.href="know_quiz_new.env?id=know_quiz_list&pageNum=1"
		//$('.db').load("know_quiz_new.env?id=know_quiz_list&pageNum=1");
	});
	
	$('.know_news_new').click(function(){
		location.href="know_news_new.env?id=know_news_list&pageNum=1"
		//$('.db').load("know_news_new.env?id=know_news_list&pageNum=1");
	});
	
	$('.question_new').click(function(){
		var id = $('#id').val();
		if(id=="n"){
			$('#id').val("n1");
			location.href="logincheck.env";
		}else{
			location.href="question_new.env?id=question_list&pageNum=1"		
		} 
	});
	
/*question_view (reply)
	$('#slist').load('question_slist.env?num=${board.num}') 
	//$('#list').load('question_list.env?pageNum=${pageNum}');
	
	$('#repInsert').click(function() {
		alert("here2")
		if (!frm.replytext.value) {
			alert('댓글 입력후에 클릭하시오');
			frm.replytext.focus();
			return false;
		}
		var frmData = $('form').serialize();
		// var frmData = 'replyer='+frm.replyer.value+'&bno='+
		//				  frm.bno.value+'&replytext='+frm.replytext.value;				  
//		$.post('question_sInsert.env', frmData, function(data) {
//			//$('#slist').html(data);
//			frm.replytext.value ="";
//		});
		location.href="question_sInsert.env?"+frmData;
		frm.replytext.value ="";
	});*/
});

