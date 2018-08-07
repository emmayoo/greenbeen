<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>

<script src="https://www.gstatic.com/charts/loader.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.9/semantic.min.js"></script>

<script type="text/javascript">
	var i = "";

	google.charts.load("current", {
		packages : [ "corechart" ]
	});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart(msg) {
		alert("dd=" + msg);
		var i = msg.split(",");

		//for(var j=0; j<i.length;j++) {alert(i[j]);}

		var data = google.visualization.arrayToDataTable([
				[ '물질', '총 량(ton)' ], [ '용수 사용량', parseInt(i[1]) ],
				[ '에너지 사용량', parseInt(i[2]) ], [ '폐기물 배출량', parseInt(i[5]) ] ]);

		var options = {

			chartArea : {
				width : '50%'
			},

			bars : 'horizontal',

			hAxis : {
				title : '총 량',
				minValue : 0
			},

			vAxis : {
				title : '업종'
			},

			colors : [ '#005e1f' ]

		};

		var data2 = google.visualization
				.arrayToDataTable([ [ '물질', '총 량(ton)' ],
						[ '대기오염 배출량', parseInt(i[3]) ],
						[ '수질오염 배출량', parseInt(i[4]) ],
						[ '화학물질 배출량', parseInt(i[6]) ],
						[ '용수 재활용량', parseInt(i[7]) ],
						[ '폐기물 재활용량', parseInt(i[8]) ] ]);

		var options2 = {
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

			colors : [ '#005e1f' ]

		};

		var chart2 = new google.visualization.BarChart(document
				.getElementById('piechart'));

		chart2.draw(data2, options2);

		var chart = new google.visualization.BarChart(document
				.getElementById('barchart_material'));

		chart.draw(data, options);
	}
</script>

</head>
<body>
<input type="hidden" id="hidden" value="part">
	<input type="hidden" id="which" value="part">
	<jsp:include page="top.jsp" />
	
	 <div class="tab" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
         	<li role="presentation" ><a class="dropdown-item" href="area.env" id="area" aria-controls="home" role="tab" data-toggle="tab">지역별</a></li>
         	<li role="presentation"><a class="dropdown-item" href="object.env" id="object" aria-controls="profile" role="tab" data-toggle="tab">물질별</a></li>
          	<li role="presentation" class="active"><a class="dropdown-item" href="part.env" id="part" aria-controls="messages" role="tab" data-toggle="tab">업종별</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" aria-controls="messages" role="tab" data-toggle="tab">내설정</a></li>
         </ul>
	</div>	
	
	<div class="container">
			<table align=center id="selectmenu">
				<tr>
					<td><select class="form-control" id="type" name="com_type"></select></td>

					<td><select class="form-control" id="year" name="com_year">
							<option value="2015">2015</option>
							<option value="2016" selected>2016</option>
					</select></td>
				</tr>
			</table>
				
			<div id=mapchart>
			
			<div id="piechart" style="width: 100%; height: 100%;"></div>
			<div id="barchart_material" style="width: 100%; height: 100%;"></div>
			</div>
		
	</div>
</div></div>
</div></div>

		<div id="footer">
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>