function parseWeather(){
	loadJSON(function(response){
		
		var jsonData = JSON.parse(response);
		
		var temp = Math.round(jsonData["main"]["temp"]-273.15);
		document.getElementById("todayTemp").innerHTML = +temp + ' ˚C';
		
		var icon = jsonData["weather"][0]["icon"];
		document.getElementById("icon").innerHTML = "<image src='https://openweathermap.org/img/wn/"+icon+".png' width='35'>";
		
		document.getElementById('currentDate').innerHTML = new Date().toISOString().slice(5, 10);
	});
}

function loadJSON(callback){
	
	var url = "https://api.openweathermap.org/data/2.5/weather?q=Seoul,KR&cnt=7&appid=4e843bd1d669f0389af7e25aa1fb2b21";
	var request = new XMLHttpRequest();
	request.overrideMimeType("application/json");
	request.open('GET',url,true);
	
	request.onreadystatechange = function(){
		if(request.readyState == 4 && request.status == "200")
			{
				callback(request.responseText);
			}
	};
	request.send(null);
		
}

window.onload = function(){
	parseWeather();
}

