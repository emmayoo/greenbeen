var options = { 
    startTag : "<b class='highlight'>",  
    endTag   : "</b>"
} 

function highlight2(keywords) { 
	var text = document.getElementById("content").innerHTML;
	var regex = keywords.split(' '); 
    regex = regex.filter(function(char){ 
      return char !== ''; 
    }); 
    regex = regex.join('|'); 
    regex = regex.replace(/[-[\]{}()*+?.,\\^$]/g, "\\$&"); 
    var matcher = new RegExp(regex, 'gi');  //g는 모든 문자를 바꿔라, i는 대소문자 관계없이
  
  //  return text.replace(matcher, wrapper =>options.startTag + match + options.endTag); 
    return text.replace(matcher, wrapper =>"<b class='highlight'>"+wrapper+"</b>"); 
} 

//module.exports = highlight; 

