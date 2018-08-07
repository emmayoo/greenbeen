$(function() {
	var i = $('#which').val();

	if (i == 'area') {
		$('#permaterial').hide();
		$.ajax({
			type : "Post",
			url : "makelist.env",
			data : {
				"which" : i
			},
			dataType : "html",
			success : function(data) {
				// alert(data);
				var s = data.indexOf("[");
				var e = data.indexOf("]");
				var t = data.substring((s + 1), e);
				// alert(t);
				var list = t.split(",");
				$(list).each(
						function(index, it) {
							$("#addr1").append(
									'<option value=' + it + '>' + it
											+ '</option>');
							if (it == "강원도") {
								alert("강원도");
							}

							// $("#addr2").append('<option
							// value='+it.addr2+'>'+it.addr2+'</option>');
							// $("#year").append('<option
							// value='+it.year+'>'+it.year+'</option>'); 일단
							// 2015,2016 만 하자,
							// 나중에 추가되는 값도 있으니까 하긴 해야지..
						});

			},
			error : function(request, status, e) { // call back함수로 값을 돌려 받지 못할
				// 때 error함수를 돌릴 수 있다.
				alert("1st AJAX ERROR code: " + request.status + "\n message:"
						+ request.responseText + "\n data error");
			}
		});
	}

	// 지역을 바꾸었을 때
	$('#addr1').change(
			function() {
				var obj = $('#obj').val();
				var state = $('#addr1').val();
				var province = $('#addr2').val();
				var year = $('#year').val();

				$("#addr2").html('');
				$("#addr2").append('<option value="all">전체</option>');
				var state = $('#addr1').val();
				var code = "";

				alert("지역바꿈 ajax" + state + year)

				$.ajax({
					type : "Post",
					url : "makesublist.env", // 주소 클릭할때
					data : {
						"state" : state
					},
					dataType : "html",
					success : function(data) {

						alert("makesublist: " + data);

						var f = data.indexOf("K");
						code = data.substring((f - 1), (f + 5)).trim();

						drawRegionsMap(code);

						if (obj == 'objall') {

							alert("firstajax obj" + state + province + year)

							$.post("amount.env", "com_addr1=" + state
									+ "&com_year=" + year, function(msg) {

								alert("도넛들어가기전~!" + state + msg);
								// 도넛 차트
								drawChart(msg);
								
								$(window).resize(function(){
									alert("resize11")
									drawChart(msg);
									
								});


							});
						}
						
						$(window).resize(function(){
							drawRegionsMap(code);
						});

					},
					error : function(request, status, e) {
						alert("AJAX2 ERROR code: " + request.status
								+ "\n message:" + request.responseText
								+ "\n data error");
					}
				});

			});

	// 지역+주소+날짜+물질 변경 했을 때
	$('#obj').change(

			function() {
				var state = $('#addr1').val();
				var province = $('#addr2').val();
				var year = $('#year').val();
				var sum = 0;
				var obj = $('#obj').val();

				$('#none').text("");

				// 물질이 정해졌을 경우

				if (obj != 'objall') {
					alert("arealist물질이 정해짐")

					$('#mapchart').hide();
					$('#addr2').hide();
					$('#permaterial').show();

					$.ajax({
						type : "Post",
						url : "makesublist.env", // 주소 클릭할때
						data : {
							"state" : state,
							"obj" : obj,
							"year" : year
						},
						dataType : "html",
						success : function(data) {

							alert("makesublist: " + data);
							// 시+구 나누는것
							var s = data.indexOf("[");
							var e = data.indexOf("]");
							var t = data.substring((s + 1), e);
							var list = t.split(",");
							// 도 코드 구하기
							var f = data.indexOf("K");
							code = data.substring((f - 1), (f + 5)).trim();

							// 숫자 결과
							var g = data.indexOf("x");
							var h = data.indexOf("y");
							var l = data.substring((g + 4), h - 3);
							alert(t);
							alert(l);

							// 구글 차트 메소드
							// 지역 지도
							// drawRegionsMap(code);
							// 바 그래프

							drawBasic(t, l)

							
							// 지역의 시/구를 loop로 돌려서 테이블 + select에 넣기
							$(list).each(function(index, it) { //
								state = $('#addr1').val();
								addr2 = it;

							});
							
							$(window).resize(function(){
								alert("resizeTK")
								drawBasic(t, l);

							});

						},
						error : function(request, status, e) {
							alert("AJAX2 ERROR code: " + request.status
									+ "\n message:" + request.responseText
									+ "\n data error");
						}
					});
				} else {
					alert("물질ALL")
					$('#mapchart').show();
					$('#permaterial').hide();

					var province = "all";

					$.post("amount.env", "com_addr1=" + state + "&com_addr2="
							+ province + "&com_year=" + year, function(msg) {

						alert("도넛들어가기전~!" + state + msg);
						// 도넛 차트
						drawChart(msg);
						
						$(window).resize(function(){
							alert("resize1")
							drawChart(msg);
							
						});

					});
					
					

				}

			});

});
