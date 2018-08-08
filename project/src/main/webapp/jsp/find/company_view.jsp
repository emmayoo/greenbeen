<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>company_view</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0928e05cd17dd4c9d5fc571fe14095bd&libraries=services"></script>

</head>
<body>
	<div id="top">
		<jsp:include page="../top.jsp"/>
	</div>
	<div id="content">	
		<p style="margin-top:-12px">
    		<em class="link">
        		<a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
            		혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
        		</a>
    		</em>
		</p>
		<div id="map" style="width:100%;height:350px;"></div>
		<c:forEach items="${company}" var="com" begin="0" end="0">
		회사 이름 : ${com.com_name}<br><input type="hidden" id="com_name" value="${com.com_name}">
		회사 위치 :<a id="addr">${com.com_addr1} ${com.com_addr2} ${com.com_addr3}</a><br>
		회사 업종 : ${com.com_type}<br> 
		>세부업종: ${com.com_typedt}<br>
		</c:forEach>
		<script>
		var com_name= document.getElementById('com_name').value;
		var addr = document.getElementById('addr').innerHTML;
		var ind = addr.indexOf(" ",18);
		var addr2 = addr.substring(0,ind);
		//alert(addr);
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   	 	mapOption = {
        	center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        	level: 3 // 지도의 확대 레벨
    	};  

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {

    		// 정상적으로 검색이 완료됐으면 
     		if (status === daum.maps.services.Status.OK) {
	
        	var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        	// 결과값으로 받은 위치를 마커로 표시합니다
       		var marker = new daum.maps.Marker({
            	map: map,
            	position: coords
        	});

        	// 인포윈도우로 장소에 대한 설명을 표시합니다
        	var infowindow = new daum.maps.InfoWindow({
            	content: '<div style="width:150px;text-align:center;padding:6px 0;">'+com_name+'</div>'
        	});
        	infowindow.open(map, marker);

        	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        	map.setCenter(coords);
    		}else{
    			alert("지도에서 회사를  찾을 수 없습니다")

    			geocoder.addressSearch(addr2, function(result, status) {
    			var coords = new daum.maps.LatLng(result[0].y, result[0].x);

       	 		// 결과값으로 받은 위치를 마커로 표시합니다
       	 		var marker = new daum.maps.Marker({
           			map: map,
            		position: coords
       			});

        		// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        		map.setCenter(coords);
    			});
    		}
		});    
		</script>
		<br><br>
		<table border=1>
		<tr><td>년도\</td>
			<td>용수 사용량(ton)</td>
			<td>용수 재활용량(%)</td>
			<td>에너지 사용량(AOE)</td>
			<td>대기오염물질 사용량(ton)</td>
			<td>수질오염물질 사용량(ton)</td>
			<td>폐기물 사용량(ton)</td>
			<td>폐기물 재활용량(%)</td>
			<td>화학물질 사용량(ton)</td></tr>
		<c:forEach items="${company}" var="co">
		<tr><td>${co.com_year}</td>
			<td>${co.com_water}</td>
			<td>${co.com_rewater}</td>
			<td>${co.com_energy}</td>
			<td>${co.com_air}</td>
			<td>${co.com_wp}</td>
			<td>${co.com_waste}</td>
			<td>${co.com_rewaste}</td>
			<td>${co.com_chemical}</td></tr>
		</c:forEach>
		</table>
	</div>
	<div id="footer">
		<jsp:include page="../footer.jsp"/>
	</div> 
</body>
</html>