$(function() {
		var i = $('#which').val();

		if(i=='part'){
			$.ajax({
				type : "Post",
				url : "makelist.env",
				data :{"which":i},
				success : function(data) {
					alert(data);
					var s = data.indexOf("[");
					var e = data.indexOf("]");
					var t = data.substring((s + 1), e);
					//alert(t);
					var list = t.split(",");
					$(list).each(function(index, it) {
						$("#type").append('<option value='+it+'>' + it+ '</option>');
					});

				},
				error : function(request, status, e) { //call back함수로 값을 돌려 받지 못할 때 error함수를 돌릴 수 있다.
					alert("code: " + request.status + "\n message:"+ request.responseText + "\n data error");
				}
			});}
	
		$('#type, #year').change(function() {
					var type = $('#type>:selected').text();
					var year = $('#year').val();
					
					alert("sdfsd="+type)

					$.ajax({
						type : "Post",
						url : "typesublist.env",
						data : {"type" : type, "year" : year},
						dataType : "html",
						success : function(data) {
							
							drawChart(data);		

								//	});
							
							$(window).resize(function(){
								drawChart(data);
							});

						},
						error : function(request, status, e) {
							alert("code: " + request.status + "\n message:"
									+ request.responseText + "\n data error");
						}
					});
			});
		
});

