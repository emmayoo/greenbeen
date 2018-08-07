<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.9/semantic.min.js"></script>

<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'bar' ]
	});
	google.charts.setOnLoadCallback(drawStuff);

	function drawStuff(t, l) {
		var hn = [];

		var i = t.split(",");
		alert("drawstuffisize" + i.length)

		var m = l.split(",");
		alert("msize" + m.length)

		hn.push([ '시/구', '총 량(ton) *에너지(TOE)*' ]);

		for (var k = 0; k < i.length; k++) {
			hn.push([ i[k], parseInt(m[k]) ]);
		}

		var data = new google.visualization.arrayToDataTable(hn);

		var options = {
			title : '지역 별 총 량',
			chartArea : {
				width : '50%'
			},
			hAxis : {
				title : '총 량',
				minValue : 0
			},
			vAxis : {
				title : '지역'
			}
		};

		var chart = new google.visualization.BarChart(document
				.getElementById('top_x_div'));

		chart.draw(data, options);
	};
</script>
<script>
	google.charts.load('current', {
		packages : [ 'corechart', 'bar' ]
	});
	google.charts.setOnLoadCallback(drawBasic);

	function drawBasic(t, l) {

		var hn = [];

		var i = t.split(",");
		alert("drawstuffisize" + i.length)

		var m = l.split(",");
		alert("msize" + m.length)

		hn.push([ '업종', '총 량(ton) *에너지 총 량(TOE)*', {
			role : 'style'
		} ]);

		for (var k = 0; k < i.length; k++) {
			hn.push([ i[k], parseInt(m[k]), '#56005e' ]);
		}

		var data = new google.visualization.arrayToDataTable(hn);

		var options = {
			title : '업종 별 총량',
			chartArea : {
				width : '50%'
			},
			chart : {
				title : '업종 별 총량',
				subtitle : 'ton'
			},
			bars : 'horizontal',

			hAxis : {
				title : '총 량',
				minValue : 0
			},
			vAxis : {
				title : '업종'
			},

			colors : [ '#56005e' ]

		};

		var chart = new google.visualization.BarChart(document
				.getElementById('chart_div'));

		chart.draw(data, options);
	}
</script>

</head>
<body>
	<input type="hidden" id="hidden" value="object">
	<input type="hidden" id="which" value="object">
	<jsp:include page="top.jsp" />

 	<div class="tab" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
         	<li role="presentation"><a class="dropdown-item" href="area.env" id="area" aria-controls="home" role="tab" data-toggle="tab">지역별</a></li>
         	<li role="presentation" class="active"><a class="dropdown-item" href="object.env" id="object" aria-controls="profile" role="tab" data-toggle="tab">물질별</a></li>
          	<li role="presentation"><a class="dropdown-item" href="part.env" id="part" aria-controls="messages" role="tab" data-toggle="tab">업종별</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" aria-controls="messages" role="tab" data-toggle="tab">내설정</a></li>
         </ul>
	</div>	



	<div class="container">
		<%-- 	<div class="row">
				<div class="col left-side">                            
				<jsp:include page="datasidebar.jsp" /></div>
			<div class="col"> --%>
		<table align=center id="selectmenu">
			<tr>
				<td><select class="form-control" id="ob_obj" name="ob_obj">
						<option value="objall" selected>전체</option>
						<option value="com_water">용수 사용</option>
						<option value="com_rewater">용수 재활용</option>
						<option value="com_air">대기오염</option>
						<option value="com_wp">수질오염</option>
						<option value="com_waste">폐기물 사용</option>
						<option value="com_rewaste">폐기물 재활용</option>
						<option value="com_chemical">화학</option>
						<option value="com_energy">에너지</option>
				</select></td>

				<td><select class="form-control" id="ob_year"
					name="ob_com_year">
						<option value="2015">2015</option>
						<option value="2016" selected>2016</option>
				</select></td>

			</tr>
		</table>


				<div id="chart_div"  style="width: 100%; height:100%"></div>
				<div id="top_x_div"  style="width: 100%; height:100%"></div>
				내용

	</div>
	</div>
	</div>
	</div>
	</div>


	<div id="footer">
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>