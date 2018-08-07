$(function() {
	var i = $('#which').val();

	$('#ob_obj').change(

			function() {
				var year = $('#ob_year').val();
				var sum = 0;
				var obj = $('#ob_obj').val();

				alert("obobjchange" + year + obj)

				// 물질이 정해졌을 경우

				$.ajax({
					type : "Post",
					url : "objsublist.env", // 주소 클릭할때
					data : {
						"obj" : obj,
						"year" : year
					},
					dataType : "html",
					success : function(data) {

						// alert("makesublist: " + data);
						// 시+구 나누는것
						var s = data.indexOf("[");
						var e = data.indexOf("]");
						var t = data.substring((s + 1), e);
						var list = t.split(",");

						// 숫자 결과
						var g = data.indexOf("x");
						var h = data.indexOf("y");
						var l = data.substring((g + 4), h - 3);
						alert(t);
						alert(l);

						drawStuff(t, l);
						
						$(window).resize(function() {
							alert("resize obj")
							drawStuff(t, l);
						});

						alert("drawStuff이후에 year" + year)

						$.post("objtypelist.env", "obj=" + obj + "&year="
								+ year, function(data) {

							alert("type bar graph !");

							// alert("makesublist: " + data);
							// 시+구 나누는것
							var s = data.indexOf("[");
							var e = data.indexOf("]");
							var t = data.substring((s + 1), e);
							var list = t.split(",");

							// 숫자 결과
							var g = data.indexOf("x");
							var h = data.indexOf("y");
							var l = data.substring((g + 4), h - 3);
							alert(t);
							alert(l);

							drawBasic(t, l);

							
							$(window).resize(function() {
								alert("resize obj2");
								drawBasic(t, l);
								
							});
							
						});


					},
					error : function(request, status, e) {
						alert("AJAX2 ERROR code: " + request.status
								+ "\n message:" + request.responseText
								+ "\n data error");
					}
				});

			});

});
